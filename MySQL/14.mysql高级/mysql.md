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
    3. 索引