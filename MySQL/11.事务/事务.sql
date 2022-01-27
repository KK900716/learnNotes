事务
    1.事务由一个或多个sql语句组成的一个不可分割的整体，sql语句之间相互依赖，要么全部执行，要么全部都不执行

    2.事务必须满足的四个条件
        a.Atomicity 原子性
        b.Consistency 一致性
        c.Isolation 隔离性
        d.Durability 持久性
    3.控制事务处理
        a.roollback 回滚会结束用户的事务，并撤销正在进行的所有未提交的修改
        b.commit 会提交事务，并使已对数据库进行的所有修改成为永久性的
        c.savepoint identifier 允许在事务中创建一个保存点，一个事物中可以有多个savepoint
        d.roollback to identifier 把事务回滚到标记点

    4.mysql事务处理主要有两种方法
        a.用begin rollback commit 来实现
            （1）begin 或 start transaction 开始一个事务
            （2）rollback 事务回滚
            （3）commit 事务确认
        b.直接用set来改变mysql的自动提交模式
            （1）set autocommit=0 禁止自动提交
            （2）set autocommit=1 开启自动提交

    5.示例
        a.
        create table mytest(
            id int primary key,
            name varchar(20)
        );
        use book;

        /* 开始事务 */
        begin;
        insert into mytest values(1,'test1');
        insert into mytest values(2,'test2');
        commit;

        select * from mytest;

        /* 回滚事务 */
        begin;
        insert into mytest values(3,'test3');
        rollback;

        /* 设置保存点 */
        begin;
        insert into mytest values(4,'test4');
        savepoint s1;
        insert into mytest values(5,'test5');
        savepoint s2;
        insert into mytest values(6,'test6');
        rollback to s1;
        
        b.
        set autocommit=0;
        insert into mytest values(7,'test7');
        rollback;

        set autocommit=1;
        insert into mytest values(8,'test8');
        rollback;

    6.只有提交了事务，其他用户才能可见
    
通过InnoDB使用事务
    1.InnoDB是事务型数据库的首选引擎，支持事务安全表（ACID）
    2.mysql5.7以上InnoDB作为默认存储引擎，5.5.5前默MyISAM是默认存储引擎，当表需要事务处理时需要设置存储引擎为InnoDB
事务的并发问题
    1.对于同时运行的多个事务，当这些事务访问数据库中相同的数据时，如果没有采取必要的隔离机制，就会导致并发问题
    2.脏读
    3.不可重复读
    4.幻读
数据库事务隔离级别
    1.Mysql支持4中事务隔离级别，Mysql默认的事务的隔离级别为REPEATABLE READ
        1.read uncommitted 读未提交数据
        2.read commited 读已提交数据
        3.repeatable read 可重复读
        4.serializable 串行化
    2.select @@transaction_isolation;查看事务隔离级别
    3.set session transaction isolation level read uncommitted;更改事务的隔离级别