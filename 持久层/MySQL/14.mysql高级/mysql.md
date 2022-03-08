1. 配置文件
    1. 二进制日志log-bin（主从赋值）
    2. 错误日志log-error
    3. 查询日志log
    4. 数据文件
        1. frm存放表结构
        2. myd存放表数据
        3. myi存放表索引
2. 逻辑架构简介
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
        ...
        ```
                主外键           事务            行表锁          缓存            表空间          关注点          默认安装
        MyISAM  不支持          不支持     表锁，不适合高并发   只缓存索引              小          性能            Y
        InnoDb  支持            支持    行锁，适合高并发  缓存索引和数据，内存影响性能   大          事务            Y
        ```   
        3. PerconaServer 为MySql数据库服务器进行了改进，在功能和性能上较Mysql有显著提升，该本本提升了在高负载情况下InnoDB的性能，为DBA提供了一些非常有用的性能诊断工具，另外有更多的参数和命令来控制服务器行为
        4. 该公司新建了一款存储引擎叫 XtraDB 完全可以替代Innodb，并且性能和并发更好
        5. 阿里大部分数据库其实是在percona的选型上加以修改（AliSql+AliRedis）
    4. File system存储层
    5. Files&logs
    6. 插件式的存储引擎架构将查询处理和其他的系统任务以及数据的存储提取相分离
3. 索引优化
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
    8. 性能分析
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
                    11. index Full Index Scan，index与all区别为index类型只遍历索引树，这通常比all快，因为索引文件通常比数据文件小3
                    12. all 全表扫描
                5. possible_keys
                6. key
                7. key_len
                8. ref
                9. rows