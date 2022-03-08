-- 1.创建数据库
    -- 判断数据库是否存在，并设置编码格式
    CREATE DATABASE [IF NOT EXISTS] db_name [DEFAULT] CHARACTER SET [=] charset_name

    -- 基本sql语句
    -- CREATE DATABASE database_name;
    create database test1;

    create database if not exists test2 character set utf8;
-- 2.修改数据库
    -- 修改数据库的编码格式
    ALTER DATABASE db_name [DEFAULT] CHARACTER SET [=] character_name

    alter database test2 character set latin1;
    -- 查看修改结果
    use test2;
    show variables like 'character%';
-- 3.删除数据库
    DROP DATABASE [IF EXITSTS] db_name

    drop database test1;
    drop database test2;
    show databases;