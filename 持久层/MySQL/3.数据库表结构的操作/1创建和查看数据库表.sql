-- 创建和查看数据库表
    -- 1.创建数据库表
    CREATE TABLE <表名>
    (
        列名1 数据类型 [列级别约束条件] [默认值],
        列名2 数据类型 [列级别约束条件] [默认值],
        ……
        [表级别约束条件]
    );

    -- 以图书管理系统为例
    create database test1;
    use test1;

    create table reader(
        card_id char(18),
        name varchar(10),
        sex enum('男','女'),
        age tinyint,
        tell char(11),
        balance decimal(7,3)
    );
    -- 查看创建结果
    -- 可以显示book下的所有数据库表
    show tables from test1;

    -- 2.查看数据库表
        -- 查看数据库表
        SHOW TABLES [FROM db_name]
        -- 查看数据表基本结构
        SHOW COLUMNS FROM tbl_name
        或
        DESCRIBE <表名> / DESC <表名>
        -- 示例
        show columns from reader;

        describe reader;
        desc reader;
 
    -- 3.查看表详细结构语句，可以用来显示数据表的创建语句
    SHOW CREATE TABLE tbl_name;

    show create table reader;