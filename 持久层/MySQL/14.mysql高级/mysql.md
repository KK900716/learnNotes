[TOC]

------



## 配置文件

1. 二进制日志log-bin（主从复制）
2. 错误日志log-error
3. 查询日志log
4. 数据文件
    1. frm存放表结构
    2. myd存放表数据
    3. myi存放表索引

## 逻辑架构简介

1. Connectors（JDBC等）连接层

2. Management Services&Utllties服务层
    1. Connection Pool
    2. SQL Interface
    3. Parser
    4. Optimlzer 优化器（如果自己设计mysql可以将优化器拔出）
    5. Caches&Buffers

3. Pluggable Storage Engines引擎层
    1. MyISAM

    2. InnoDB

        |        | 主外键 |  事务  |       行表锁       |             缓存             | 表空间 | 关注点 | 默认安装 |
        | :----: | :----: | :----: | :----------------: | :--------------------------: | :----: | :----: | :------: |
        | MyISAM | 不支持 | 不支持 | 表锁，不适合高并发 |          只缓存索引          |   小   |  性能  |    Y     |
        | InnoDb |  支持  |  支持  |  行锁，适合高并发  | 缓存索引和数据，内存影响性能 |   大   |  事务  |    Y     |

    3. PerconaServer 为MySql数据库服务器进行了改进，在功能和性能上较Mysql有显著提升，该本本提升了在高负载情况下InnoDB的性能，为DBA提供了一些非常有用的性能诊断工具，另外有更多的参数和命令来控制服务器行为

    4. 该公司新建了一款存储引擎叫 XtraDB 完全可以替代Innodb，并且性能和并发更好

    5. 阿里大部分数据库其实是在percona的选型上加以修改（AliSql+AliRedis）

4. File system存储层

5. Files&logs

6. 插件式的存储引擎架构将查询处理和其他的系统任务以及数据的存储提取相分离


## SQL优化

### 索引优化

1. 分析
    1. 性能下降sql慢
    2. 执行时间长
    3. 等待时间长
2. 原因
    1. 查询语句写的不好
    2. 索引实现
        1. 单值索引
        2. 复合索引
        3. 关联查询太多join（设计缺陷或不得已的需求）
        4. 服务器调优及各个参数设置（缓冲、线程数等）
    3. 常见的通用的Join查询
        1. SQL执行顺序
            1. 手写
            2. 机读顺序from、on、where、group by、having、select、distinct、order by、limit
            3. 解析
                1. from 笛卡尔积
                2. on 主表保留
                3. join 不符合on也添加 where 非聚合非select 别名
                4. group by 改变对表引用
                5. having 只作用分组后
                6. select distinct
                7. order by 可使用select别名
                8. limit rows offset
        2. 7种joins
3. 索引简介
    1. 官方定义：索引（Index）是帮助mysql高效获取数据的数据结构
    2. 目的是提高查询效率，可以类比字典
    3. 理解：排好序的快速查找数据结构
    4. 在数据之外，数据库系统还维护着满足特定查找算法的数据结构，这些数据结构以某种方式引用（指向）数据，这样就可以在这些数据结构上实现高级查找算法。这种数据结构就是索引，
    5. 一般来说索引本身也很大，不可能全部存储在内存中，因此索引往往以文件的形式存储到磁盘
    6. 索引一般为多路搜索树B树，聚集索引、次要索引、覆盖索引、复合索引、前缀索引、唯一索引默认使用B+树索引，除此之外还有哈希索引等
4. 优劣
    1. 优势
        1. 提高数据检索的效率，降低数据库的IO成本
        2. 降低数据排序的成本，降低CPU的消耗
    2. 劣势
        1. 实际上索引也是一张表，该表保存了主键与索引字段，并指向实体表的记录，所以索引列也是要占用空间的
        2. 虽然索引大大提高了查询速度，同时却也降低更新表的速度
5. 索引分类
    1. 单值索引 一个索引只包含单个列，一个表可以有多个单列索引（建议一张表少于5个）
    2. 唯一索引 索引列值必须唯一，但允许空值
    3. 复合索引 
    4. 基本语法
6. 索引结构
    1. BTree
    2. Hash
    3. full-text
    4. R-Tree
7. 索引使用建议
    1. 使用索引的情况
        1. 主键自动建立唯一索引
        2. 频繁作为查询条件的字段应创建索引
        3. 查询中与其他表关联的字段，外键关心建立索引
        4. 高并发下倾向创建组合索引
        5. 查询中排序的字段
        6. 查询中统计或者分组的字段
    2. 不使用索引的情况
        1. 表记录太少
        2. 经常增删改的表
        3. 数据重复且分布平均的表字段
        4. 索引的选择性是指索引列中不同值的数目与表中记录的比，一个索引的选择性越接近1，效率越高
        5. where条件里用不到的字段

### 性能分析

1. MySql Query Optimizer
    1. 通过计算分析系统中收集的统计信息，为客户端请求地Query提供他认为最优的执行计划（可能不是DBA人为最优的）
2. MySql常见瓶颈
    1. CPU在饱和的时候一般发生在数据装入内存或从磁盘读取数据的时候
    2. 磁盘IO瓶颈发生在装入数据远大于内存容量的时候
    3. 服务器硬件性能瓶颈 top free iostat vmstat来查看系统的性能
3. Explain
    1. 使用EXPLAIN关键字可以模拟优化器执行SQL查询语句，从而知道Mysql是如何处理你的SQL语句，分析你的查询语句或是表结构的性能瓶颈
    2. Explain+SQL语句
        1. 表的读取顺序
        2. 数据读取操作的操作类型
        3. 那些索引可以使用
        4. 那些索引被实际使用
        5. 表之间的引用
        6. 每张表有多少行被优化器查询
    3. 表头
        1. id
            1. select查询的序列号，包含一组数字，表示查询中执行select子句或操作表的顺序
            2. 情况
                1. id相同表的执行顺序从上到下
                2. id不同如果是子查询，id序号会递增，id值越大执行优先级越高
        2. select_type
            1. SIMPLE 简单查询（不包含子查询和union）
            2. PRIMARY 主查询
            3. SUBQUERY 子查询
            4. DERIUED 衍生，在from列表中包含的子查询被标为DERIVED，MySQL会递归执行这些子查询，吧结果放在临时表中
            5. UNION 若第二个select出现union之后则被标记为union，若union包含在from子句的子查询中，外层select江北标记为derived
            6. UNION RESULT 从union表获取结果的select
        3. table
            1. DERIVED衍生虚表
        4. type
            1. all  index   range   ref eq_ref  const,system    NULL
            2. 显示查询使用了何种类型
            3. 最好到最差排序依次是system>const>eq_ref>ref>range>index>all
            4. system const eq_ref ref fulltext ref_or_null index_merge unique_subquery index_subquery range index all
            5. 至少达到range级别，最好能达到ref级别
            6. system 表只有一行记录（等于系统表），这是const类型的特例，平时不会出现
            7. const 表示通过索引一次就找到了，const用于比较primary key或者unique索引，因为只匹配一行数据，所以很快，如将主键置于where列表中，mysql就能将该查询转换为一个常量
            8. eq_ref 唯一索引扫描，对于每个索引建，表中只有一条记录与之匹配，常见于主键或唯一索引扫描
            9. ref非唯一性索引扫描，返回匹配某个单独值的所有行，本事上也是一种索引访问，他返回所有匹配某个单独值的行，然而，他可能会找到多个符合条件的行，所以他应该属于查找和扫描的混合体
            10. range只检索给定范围的行，使用一个索引来选择行，key列显示使用了那个索引，一般就是在你的where语句中出现了between、<、>、in等的查询，这种范围扫描索引扫描比全表扫描要好，因为它只需要开始于索引的某一点，而结束于另一点，不用扫描全部索引
            11. index Full Index Scan，index与all区别为index类型只遍历索引树，这通常比all快，因为索引文件通常比数据文件小
            12. all 全表扫描
        5. possible_keys
            1. 显示可能应用在这张表的索引，一个或多个
            2. 查询涉及到的字段上若存在索引，则该索引将被列出，但不一定被查询实际使用
        6. key
            1. 实际使用的索引，如果为NULL，则没有使用索引
            2. 查询中若使用了覆盖索引，则该索引仅出现在key列表中
        7. key_len
            1. 表示索引中使用的字节数，可通过该列计算查询中使用的索引长度。在不损失精确性的情况下，长度越短越好
            2. 显示的值为索引字段的虽大可能长度，并非实际使用长度，即是通过表定义得来，而非表内检索出来
        8. ref
            1. 显示索引的哪一列被使用了，如果可能的话，是一个常数
            2. 哪些列或常量被用于查找索引列上的值
        9. rows
            1. 根据表统计信息及索引选用情况，大致估算出找到所需的记录所需要读取的行数
            2. 即每张表有多少数据被优化器查询
        10. Extra
            1. 包含不适合在其他列中显示，但十分重要的额外信息
            2. Using filesort
               1. 说明mysql会对数据使用一个外部的索引排序，而不是按照表内的索引顺序进行读取
               2. mysql中无法利用索引完成的排序操作成为“文件排序”
            3. Using temporary
               1. 使用了临时表保存中间结果
               2. mysql在对查询结果排序是使用临时表，常见于order by 和 group by
            4. Using index
               1. 表示相应的select的操作使用了覆盖索引，避免访问了表的数据行，效率不错
               2. 如果同时出现using where，表明索引被用来执行索引键值的查找
               3. 如果没有同时出现using where，表明索引用来读取数据而非执行查找动作
               4. 覆盖索引Covering index 索引覆盖
                  1. 理解
                     1. select的数据列只用从索引中就能取得，不必读取数据行，mysql可以利用索引返回列表中的字段，不必根据索引再次读取数据文件
                     2. 换句话说查询列要被所建的索引覆盖
                  2. 使用覆盖索引要注意select列表中只取出所需要的列，避免 select *
                  3. 如果将所有字段一起做索引会导致索引文件过大，查询性能下降
            5. Using where
            6. Using join buffer 使用了连接缓存
            7. impossible where 不可能的条件，不会获得结果
            8. select tables optimized away
               1. 在没有GROUPBY子句的情况下，基于索引优化MIN/MAX操作或者对于MyIsam存储引擎优化Count(*)操作，不必等到执行阶段再计算，查询执行计划生成的阶段即完成优化
            9. distinct 优化distinct操作，找到第一匹配的元组后即停止找同样值的动作

### 索引优化（为查询建立索引）

1. 多表连接
   1. 左连接右表加索引，右连接左表加索引
   2. 原理是连接的表全都有，被连接的表驱动
   3. 尽可能减少Join语句中的NestedLoop的循环总次数，永远用小结果集驱动大结果集
   4. 优先优化NestedLoop的内层循环，保证Join语句中被驱动表上Join条件字段已经被索引
   5. 当无法保证被驱动表的Join条件字段被索引且内存资源充足的前提下，不要太吝惜JoinBuffer的设置

2. 索引失效的情况
   1. like 以%开头，索引无效；当like前缀没有%，后缀有%时，索引有效
   2. or语句前后没有同时使用索引
      1. 当or左右查询字段只有一个是索引，该索引失效，只有当or左右查询字段均为索引时，才会生效

   3. 组合索引，不是使用第一列索引，索引失效
   4. 如果列类型是字符串，那一定要在条件中将数据使用引号引用起来，否则不使用索引
      1. 数据类型出现隐式转化。如varchar不加单引号的话可能会自动转换为int型，使索引无效，产生全表扫描

   5. 在索引列上使用 IS NULL 或 IS NOT NULL操作
      1. 在索引列上使用 IS NULL 或 IS NOT NULL操作，索引不一定失效

   6. 在索引字段上使用not，<>，!=
   7. 对索引字段进行计算操作、字段上使用函数
   8. 当全表扫描速度比索引速度快时，mysql会使用全表扫描，此时索引失效


### 查询截取分析（为排序、分组建立索引）

1. 操作
   1. 开启慢查询日志，设置阈值，并捕获
   2. explain+慢sql分析
   3. show profile 查询sql在mysql服务器里的执行细节和生命周期情况
   4. 进行sql数据库服务器的参数调优
2. 优化建议
   1. 永远小表驱动大表（字段应该建立索引）
      1. 子查询数据少 in 优于 exits
      2. 子查询数据多 exits 优于 in
3. ORDER BY
   1. 尽量遵循索引排序
   2. 如果不在索引列上，filesort有两种算法
      1. 双路排序
         1. mysql4.1之前是使用双路排序，扫描两次磁盘得到数据
         2. 读取行指针和orderby列，对它们进行排序，然后扫描已经排序号的列表，按照列表中的值重新从列表中读取对应的数据输出
         3. 从磁盘取排序字段，在buffer进行排序，再从磁盘取其他字段
      2. 单路排序
         1. 从磁盘读取查询所需的所有列，按orderby在buffer对它们排序进行输出，占用了更多内存，但效率有显著提高
         2. 把随机IO变成顺序IO，避免两次读取数据
      3. 若单路排序一次无法抓取所有数据则效率会低于双路排序
      4. sort_buffer容量是决定效率的重要因素
         1. 慎用select *
         2. 增大sort_buffer_size参数
         3. 增大max_length_for_sort_data参数
            1. 提高该参数会增加用改进算法的概率，但如果设置过高则会占用更多buffer
4. GROUP BY
   1. 同查询、排序原则相同
   2. where高于having，能写在where的限定条件不要用having

### 慢查询日志

1. 简介

   1. mysql的慢查询日志是mysql提供的一种日志记录，它用来记录在mysql中响应时间超过阈值的用户拒，具体指运行时间超过long_query_time的sql
   2. long_query_time默认值为10s
   3. 默认mysql不开启慢查询，如果不是调优，一般不建议启动该参数

2. 查看是否开启

   1. 默认 SHOW VARIABLES LIKE '%slow_query_log%'

   2. 开启 set global slow_query_log=1; 重启失效

   3. 永久生效 修改 my.cnf

      1. 增加修改参数

         ```sql
         slow_query_log=1
         slow_query_log_file=/var/lib/mysql/atguigu-slow.log
         ```

      2. 系统默认会给一个缺省的文件host_name-slow.log（没有指定参数时）

      3. 重启服务

   4. 参数

      1. 查看当前阈值 SHOW [global] VARIABLES LIKE 'long_query_time%'
      2. 设置阈值 set global long_query_time=3
      3. 展示日志中有多少慢查询 show global status like '%Slow_queries%'

3. 配置

   ```sql
   slow_query_log=1
   slow_query_log_file=/var/lib/mysql/atguigu-slow.log
   long_query_time=3
   logoutput=FILE
   ```

4. 日志分析工具mysqldumpslow

   1. 选项
      1. s 是表示按照何种方式排序
      2. c 访问次数
      3. i 锁定时间
      4. r 返回记录
      5. t 查询时间
      6. al 平均锁定时间
      7. ar 平均返回记录数
      8. at 平均查询时间
      9. t 返回前面多少条数据
      10. g 搭配正则匹配 大小写不敏感

5. 函数慢查询日志

   1. 为function指定参数
      1. show varables like 'log_bin_trust_function_creators'
      2. set global log_bin_trust_function_creators=1

   2. 配置
      1. windows my.ini上log_bin_trust_function_creators=1
      2. linux my.cnf上log_bin_trust_function_creators=1


### Show Profile

1. 简介
   1. 是mysql提供可以用来分析当前会话中语句执行的资源消耗情况，可用于sql的调优的测量
   2. 默认关闭，保存最近15次运行
2. 使用
   1. 开启
      1. set profiling=on
      2. Show variables like 'profiling'
   2. 查询
      1. show profiles;
      2. show profile cpu.block io for query sql数字号;
         1. ALL 显示所有的开销信息
         2. BLOCK IO 显示块io相关开销
         3. CONTEXT SWITCHES 上下文切换相关开销
         4. CPU 显示cpu相关开销信息
         5. PIC 显示发送和接受相关开销信息
         6. MEMORY 显示内存相关开销信息
         7. PAGE FAULTS 显示页面错误相关开销信息
         8. SOURCE 显示和Source_function,source_file,Source_line相关的开销信息
         9. SWAPS 显示交换次数相关开销的信息
      3. 危险的提示
         1. converting HEAP to MyISAM 查询结果太大，内存不够用
         2. Creatingtmp table 创建临时表，用完即删除
         3. Copying to tmp table on disk 把内存中临时表复制到磁盘
         4. locked

### 全局查询日志

1. 配置启用
2. 编码启用
   1. set global general_log=1;
   2. set global log_output='TABLE';
   3. 此后所有编写的sql语句都会记录在general_log表，可以用下面的命令查看
   4. select * from mysql.general_log;
3. 永远不要在生产环境开启这个功能

## 数据库锁理论

1. 简介
   1. 锁是计算机协调多个进程或县城并发访问某一资源的机制，在数据库中，数据也是一种提供许多用户共享的资源
   2. 保证数据并发访问一致性、有效性是所有数据库必须解决的一个问题，锁从图也是影响并发访问性能的一个重要因素

2. 分类
   1. 数据操作
      1. 读锁（共享锁） 针对同一份数据，多个操作可以同时进行而不会互相影响
      2. 写锁（排它锁） 当前操作没有完成前，会阻断其他写锁和读锁
   2. 对数据操作粒度
      1. 行锁（偏写）
      2. 表锁（偏读）
      3. 页锁

3. 表锁
   1. 偏向MyISAM存储引擎，开销小，加锁快，无死锁，锁定粒度大，发生锁冲突的概率最高，并发度最低
   2. 操作
      1. 手动增加表锁
      2. lock tables 表名 read/write,表名 read/write
      3. 查看锁 show open tables [from database];
      4. 解锁 unlock tables;
   3. 读锁，不会阻塞其他进程对同一表的读请求，但会阻塞对同一表的写请求
   4. 写锁，会阻塞其他进程对同一表的读和写操作
   5. show status like 'table%'; 
      1. table_locks_waited 产生表级锁的次数，表示可以立即获取锁的查询次数，每立即获取锁值+1
      2. table_locks_immediate 出现表级锁征用而发生等待的次数，此值高说明存在严重表级锁征用情况
   6. MyISAM的读写锁调度是写优先，这也是MyISAM不适合做写为主表的引擎，因为写锁后，其他线程不能做任何操作，大量更新会使查询很难得到锁，从而造成永久阻塞

4. 行锁（偏写）
   1. InnoDB，支持事务和行级锁（由于行锁存在故支持事务）

      | 读数据一致性及允许的并发副作用隔离级别 |              读数据一致性              | 脏读 | 不可重复读 | 幻读 |
      | :------------------------------------: | :------------------------------------: | :--: | :--------: | :--: |
      |      未提交读（Read uncommitted）      | 最低级别，只能保证不读物理上损坏的数据 |  是  |     是     |  是  |
      |       已提交读（Read committed）       |                 语句级                 |  否  |     是     |  是  |
      |      可重复读（Repeatable read）       |                 事务级                 |  否  |     否     |  是  |
      |        可序列化（Serializable）        |            最高级别，事务级            |  否  |     否     |  否  |

   2. 操作

      1. set autocomit=0 关闭自动提交事务 可以用来验证
      2. varchar类型不加''，会导致行锁变表锁

   3. 间隙锁的危害

      1. 当我们用范围条件检索，并请求共享或排他锁时，InnoDB会给符合条件的已有数据记录的索引项加锁，对于键值在条件范围但并不存在的记录，叫做“间隙（GPA）”
      2. InnoDB也会对这个间隙加锁，这种锁机制就是所谓的间隙锁（Next-Key锁）

   4. 如何锁定一行

      ```mysql
      begin;
      select * from 表 where 条件 for update;
      commit;
      ```

   5. show status like 'innodb_row_lock%'

      1. Inodb_row_lock_current_waits 当前正在等待锁定的数量
      2. Inodb_row_lock_time 从系统启动到现在锁定总时间长度
      3. Inodb_row_lock_time_avg 每次等待所花平均时间
      4. Inodb_row_lock_time_max 从系统启动到现在等待最长的一次所花的时间
      5. Inodb_row_lock_waits 系统启动后到现在总共等待的次数

5. 优化建议

   1. 尽可能让所有数据检索通过索引完成，避免无索引行升级为表锁
   2. 合理设计索引，尽量缩小锁的范围
   3. 尽可能较少检索条件，避免出现间隙锁
   4. 尽量控制事务大小，减少锁定资源量和时间长度
   5. 尽可能低级别事务隔离


## 主从复制

1. 三步骤
   1. master将改变记录二进制日志（binary log） 
   2. slave将master的二进制日志事件拷贝到它的中继日志
   3. slave重做中继日志的时间，将改变应用到自己的数据库中 mysql复制是异步的且串行化的
2. 具体操作
   1. 配置相关配置文件
   2. 授权从机


## 其他操作

1. 查询命令后+ \\G 竖版打印

2. show index from 表 展示索引

3. 索引操作

   1. 创建索引

      ```sql
      CREATE [UNIQUE] INDEX indexName ON table_name (column_name)
      ```

   2. 添加索引

      ```sql
      ALTER table tableName ADD [UNIQUE] INDEX indexName (columnName)
      ```

   3. 删除索引

      ```sql
      DROP INDEX [indexName] ON mytable; 
      ```

   4. 