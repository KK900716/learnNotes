-- 删除数据库表
    -- 1.删除表
    DROP TABLE [IF EXISTS] 表1，表2...表n;

        -- 示例
    use test1;
    show tables;
    create table t1(
        name char(5)
    );
    create table t2(
        name char(5)
    );
    create table t3(
        name char(5)
    );
    create table t4(
        name char(5)
    );

    drop table t1,t2;

    -- 隐藏错误信息
    drop table if exists t2,t3;

    -- 2.表分区
        -- a.当创建的表需要承载大量数据时，就要考虑性能问题。其中一种方式就是表分区
        -- b.表分区就是把一张表的数据分成多个区块，这些区块可以在同一个磁盘上，也可以在不同的磁盘上，但所有的数据还在一个表中
        -- c.需要查看数据库是否支持表分区，执行:
        use test1;
        show plugins;
        -- 如果包含partition项则可以支持表分区
        -- d.一般分为水平分区、垂直分区，水平分区是将表的数据按行分割，垂直分区是将表的数据按列分割
        -- e.以水平分区中范围分区为例
            -- 在创建表时使用partition by 类型（字段）
            -- RANGE分区：
            --     根据指定某列的范围值进行分区
            --     使用values less than操作符定义分区
        -- 示例
        
