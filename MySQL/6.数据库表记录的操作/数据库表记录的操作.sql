/* 1.单表数据记录的插入 */
    /* a.为表的所有列插入数据 */
        /* 语法格式 */
        INSERT INTO table_name(column_list) VALUES (value_list);
        /* 示例 */
        create database book;
        show databases;
        use book;
        create table bookcategory(
                category_id int primary key,
                category varchar(20),
                parent_id int
            );
        desc bookcategory;

        insert into bookcategory(category_id,category,parent_id) values (1,'计算机',0);
        /* 列可以省略，但省略时必须为所有的列指定值 */
        insert into bookcategory values (2,'医学',0);
        select * from bookcategory;
    /* b.为表的指定列插入数据 */
        alter table bookcategory modify category varchar(20) default '机械工业出版社';
        show create table bookcategory;
        insert into bookcategory(category_id,parent_id) values (3,0);
    /* c.同时插入多条记录 */
        /* 语法格式 */
        INSERT INTO table_name(column_list) VALUES (values_list1),(values_list2),(values_list3),...,(values_listn);
        /* 示例 */
        insert into bookcategory values (4,'医学',0),(5,'医',0),(6,'学',0);
    /* d.将查询结果插入到表中 */
        /* 语法格式 */
        INSERT INTO table_name1(column_list1) SELECT (column_list2) FROM table_name2 WHERE(condition);
        /* 示例 */
        create table bookcategory2(
            category_id int primary key,
            category varchar(20),
            parent_id int
        );
        insert into bookcategory2 select * from bookcategory WHERE category_id>0;
        desc bookcategory2;
        select * from bookcategory2;
/* 2.设置自动编号 */
    /* a.语法格式 */
        列名 数据类型 AUTO_INCREMENT
        AUTO_INCREMENT约束的字段可事实任何整数类型
        /* 示例 */
        alter table bookcategory2 modify category_id int auto_increment;
        desc bookcategory2;
        /* 默认为1，可以使用 auto_increment=n 选项来指定一个自增的初始值 */
        insert into bookcategory2(category,parent_id) values ('美术',1);
        /* 创建、修改起始值 */
        create table bookcategory2(
            category_id int primary key auto_increment,
            category varchar(20),
            parent_id int
        )auto_increment=5;
        alter table bookcategory2 auto_increment=7;
        /* 去掉自增列 */
        alter table bookcategory2 modify category_id;
        /* 应当注意，在修改时一定要去掉表之间的关联关系 */
/* 3.单表数据记录的更新 */
    /* a.语法格式 */
        UPDATE table_name
        SET column_name1=value1,
        column_name2=value2,……,
        column_namen=valuen,
        WHERE(condition);
        /* 示例 */
        update bookcategory2 set category='音乐' where category_id=3;
        select * from bookcategory2;
/* 4.单表数据删除 */
    /* a.语法格式 */
        DELETE FROM table_name [where <condition>]
        /* 示例 */
        delete from bookcategory2 where category_id>=8;
    /* b.语法格式 */
        TRUNCATE TABLE table_name
        /* truncate将直接删除原来的表，并重新创建一个表，所以速度要快过delete */
        /* 示例 */
        select * from bookcategory;
        truncate table bookcategory;
/* 5.单表数据查询 */
    /* a.语法格式 */
        SELECT select_expr [,select_expr ...]
        [
            FROM table_references
            [WHERE where_condition]
            [GROUP BY {col_name|position} [ASC|DESC],...]
            [HAVING where_condition]
            [ORDER BY {col_name|expr|position} [ASC|DESC],...]
            [LIMIT {[offset,] row_count|row_count OFFSET offset}]
        ]
    /* b.查询所有列 */
        /* 使用通配符* */
    /* c.查询指定列 */
        /* 将列名写在select之后即可，用,隔开 */
    /* d.查询指定记录 */
        /* 通过where对结果进行过滤 */
    /* e.查询结果不重复 */
        /* 通过DISTINCT关键字消除重复 */
        /* 示例 */
        select * from bookcategory2;
        insert into bookcategory2(category,parent_id) values ('美术',1);
        select category from bookcategory2;
        select distinct category from bookcategory2;
    /* e.查询结果为空 */
        select * from bookcategory where category is null;
/* 6.对查询结果进行分组 */
    /* a.语法格式 */
        [GROUP BY 列名][HAVING <条件表达式>]
    /* b.通常和聚合函数一起使用 */
        /* 例如： */
        MAX() MIN() SUM() AVG() COUNT()
        /* 示例 */
        select * from bookcategory2;
        select count(*) from bookcategory2;
        select parent_id,count(*) from bookcategory2 group by parent_id;
        select parent_id,count(*) from bookcategory2 group by parent_id having count(*)>6;
/* 7.对查询结果进行排序 */
    /* a.语法格式 */
        [order by 列名][ASC|DESC]
    /* b.单列排序 */
    /* c.多列排序 */
    /* d.指定排序方向 */
/* 8.通过Limit语句先知查询记录的数量 */
    

        