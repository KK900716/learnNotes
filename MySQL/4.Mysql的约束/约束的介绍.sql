-- 约束是一种限制，它通过对表的行或列的数据做出限制，来确保表的数据的完整性、唯一性
--     1.约束类型
--         a.非空约束 NOT NULL
--         b.主键约束 PRIMARY KEY
--         c.唯一约束 UNIQUE
--         d.默认约束 DEFAULT
--         e.外键约束 FOREIGN KEY

    -- 2.非空约束
        -- a.NULL 字段值可以为空
        -- b.NOT NULL 字段值禁止为空
        -- c.示例
            show databases;
            use test1;
            show tables;
            drop table bookinfo;
            -- c.创建表的时候添加非空约束
            create table bookinfo(
                book_id int,
                book_name varchar(20) not null
            );
            desc bookinfo;
            -- d.修改表添加非空约束
            alter table bookinfo modify book_name varchar(20) not null;
            -- e.删除非空约束
            alter table bookinfo modify book_name varchar(20) null;--null可以省略，因为默认为空

            -- 插入一条错误的语句
            insert into bookinfo(book_id) values (20110202);
            delete from bookinfo where book_id='20110202';

    -- 3.主键约束
        -- a.主键约束要求主键列的数据唯一，并且不允许为空，主键能够唯一地表示表中的一条记录
        -- b.单字段主键
        --     （1）定义列的同时制定主键
                列名 数据类型 PRIMARY KEY；
        --     （2）在列定义的后边指定主键
                [CONSTRAINT <约束名>] PRIMARY KEY (列名)
        --     （3）示例
            drop table bookinfo;
            show tables;

            create table bookinfo(
                book_id int primary key,
                book_name varchar(20) not null
            );
            desc bookinfo;

            create table bookinfo(
                book_id int,
                book_name varchar(20) not null,
                constraint pk_id primary key(book_id)
            );
        -- c.多字段联合主键
            -- （1）主键有多个字段联合组成
                PRIMARY KEY(字段1,字段2,...,字段n)
        --     （2）示例
            create table boorowinfo(
                book_id int,
                card_id char(18),
                primary key(book_id,card_id)
            );
        -- d.修改表为列添加主键
            ALTER TABLE bookinfo MODIFY book_id INT primary KEY;
            ALTER TABLE bookinfo ADD PRIMARY KEY(book_id);
            ALTER TABLE bookinfo ADD CONSTRAINT pk_id PRIMARY KEY(book_id);
        -- e.删除主键
            ALTER TABLE bookinfo DROP PRIMARY KEY;
            -- 示例
                show tables;
                alter table boorowinfo drop primary key;
                desc boorowinfo;

                alter table boorowinfo add primary key(book_id,card_id);
    -- 4.唯一约束
        -- a.唯一约束要求该列唯一，允许为空，唯一约束可以确保一列或者几列不出现重复值
        -- b.定义完列后直接指定唯一约束
            列名 数据类型 UNIQUE
        -- c.定义完所有列之后指定唯一约束
            [CONSTRAINT <约束名>] UNIQUE (<列名>)
        -- e.示例
            show tables;
            drop table bookinfo;

            create table bookinfo(
                book_id int primary key,
                book_name varchar(20) unique not null
            );
            create table bookinfo(
                book_id int primary key,
                book_name varchar(20) not null,
                constraint uk_name unique(book_name)
            );
            -- 修改表时添加唯一约束
            alter table bookinfo modify book_name varchar(20) unique;
            alter table bookinfo add unique(book_name);
            alter table bookinfo add constraint uk_name unique(book_name);
            -- 删除表的唯一约束
            -- 获得约束名称
            show create table bookinfo;

            alter table bookinfo drop index book_name;
            alter table bookinfo drop key uk_name;
            desc bookinfo;
    -- 5.默认约束
        -- a.默认约束是用来指定某列的默认值
        -- b.创建表时添加约束
            create table bookinfo(
                book_id int primary,
                press varchar(20) default '机械工业出版社'
            );
        -- c.修改表的时候添加约束
            alter table bookinfo modify press varchar(20) default '机械工业出版社';
            alter table bookinfo alter column press set default '机械工业出版社';
        -- d.删除约束
            alter table bookinfo modify press varchar(20);
            alter table bookinfo alter column press drop default;
    -- 6.外键约束
        -- a.外键用来在两个表的数据之间建立链接，他可以是一列或者多列，一个表可以有一个或多个外键
        -- b.外键对应的是参照完整性，一个表的外键可以为空值，若不为空值，则每一个外键值必须等于另一个表中主键的某个值
        -- c.语法格式
            [CONSTRAINT <外键约束名>] FOREIGN KEY (列名) REFERENCES <主表名> (主键)
        -- d.示例
            drop table bookinfo;
            show tables;
            -- 创建主表
            create table bookcategory(
                category_id int primary key,
                category varchar(20),
                parent_id int
            );
            -- 创建子表
            create table bookinfo(
                book_id int primary key,
                book_category_id int,
                constraint fk_cid foreign key(book_category_id) references bookcategory(category_id)
            );
            desc bookinfo;
            show create table bookinfo;
            -- 修改表时添加外键约束
            alter table bookinfo add foreign key(book_category_id) references book_category_id(category_id);
            -- 删除外键约束
            alter table bookinfo drop foreign key fk_cid;
        -- e.外键约束参照操作
            -- CASCADE:从父表删除或更新且自动删除或更新子表中匹配的行
            -- 实现级联删除操作
            create table bookinfo(
                book_id int primary key,
                book_category_id int,
                constraint fk_cid foreign key(book_category_id) references book_category_id(category_id) on delete cascade
            )