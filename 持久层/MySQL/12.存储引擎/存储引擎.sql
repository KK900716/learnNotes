数据库存储引擎是数据库底层软件组件，数据库管理系统使用数据引擎进行创建、查询、更新和删除数据的操作

mysql的核心就是存储引擎
    1.mysql5.7支持InnoDB MyISAM Memory
        查看支持的存储引擎
        show engines;
    2.InnoDB
        提供了具有提交、回滚和崩溃恢复能力的事务安全存储引擎
        对于处理巨大数据量的数据拥有很好的性能
        支持外键完整性约束
        被用在众多需要高性能的大型数据库站点上
    3.MyISAM
        拥有较高的插入、查询速度，但不支持事务
    4.Memory
        将表中的数据存储到内存中，为查询和引用其他表数据提供快速访问
        使用该引擎的出发点是速度，当mysql守护进程崩溃时，所有的Memory数据都会丢失

设置存储引擎
    1.设置服务器的存储引擎
        在配置文件my.ini中的[mysqld]下设置需要的存储引擎
        default-storage-engine=InnoDB
        重启mysql服务器
    2.设置客户端的存储引擎
        SET default_storage_engine=InnoDB
        mysql5.7.5前storage_engine=InnoDB
        
    3.示例
        use book;
        create table myengine(
            id int primary key,
            name varchar(10)
        )engine=MyISAM;
        show table status from book where name='myengine';

        alter table tableName engine = engineName
