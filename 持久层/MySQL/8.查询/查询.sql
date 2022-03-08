/* 1.子查询是指嵌套在其他sql语句内的查询语句 */
/* 2.多表连接 */
    /* a.语法结构 */
    table_reference [INNER] JOIN | {LEFT|RIGHT} [OUTER] JOIN table_reference ON conditional_expr
    show tables;
    desc bookcategory;
    desc bookcategory2;
    select * from bookcategory;
    select * from bookcategory2;
    insert into bookcategory select * from bookcategory2;
    select * from bookcategory inner join bookcategory2 on bookcategory.category_id=bookcategory2.category_id;
    /* b.内连接 */
        （1）根据连接条件从多个表中查询选择数据，显示这些表中与连接条件相匹配的数据行，组成新纪录
        （2）语法结构
            SELECT column_list from t1 [INNER] JOIN t2 ON join_condition1 [INNER JOIN t3 ON join_condition2...] WHERE where_conditions
            案例:
            由于图书借阅统计的需要，想查询未归还图书的图书编号，图书名称，身份证号，姓名，电话，归还日期，是否归还
            上述需求共需要三张表，图书信息表，读着信息表，借阅信息表
            select borrowinfo.book_id,book_name,borrowinfo.card_id,name,tel,return_date,status
            from borrowinfo 
                inner join bookinfo on borrowinfo.book_id=bookinfo.book_id
                inner join readerinfo on borrowinfo.card_id=readerinfo.card_id
            where borrowinfo.status='否';
            可以起别名和省略inner
            select t1.book_id,book_name,t1.card_id,name,tel,return_date,status
            from borrowinfo t1 
                join bookinfo t2 on t1.book_id=t2.book_id
                join readerinfo t3 on t1.card_id=t3.card_id
            where t1.status='否';
    /* c.外连接 */
        （1）外连接将查询多个表中相关联的行
        （2）外连接分为左外连接LEFT [OUTER] JOIN、右外连接RIGHT [OUTER] JOIN
        （3）左外连接显示左表中的全部记录，右表满足连接条件的记录，右外连接类似
        （4）语法结构
            SELECT column_list FROM t1 LEFT|RIGHT [OUTER] JOIN t2 on join_condition1
            案例:
            根据业务需要，我们需要查看图书类别表中的所有类别下都有哪些图书
            select book_id,book_name,category
            from bookcategory
                left join bookinfo on bookcategory.category_id=bookinfo.book_category_id;
    /* d.自连接 */
        （1）如果在一个连接查询中，设计的两个表都是同一个表，这种查询成为自连接查询
/* 3.多表更新 */
    /* 语法结构 */
    UPDATE table1 {[INNER] JOIN | {LEFT|RIGHT} [OUTER] JOIN} table2
    ON conditional_expr
    SET col1={expr1 | DEFAULT} [,COL2={expr2 | DEFAULT}]... 
    [WHERE where_conditon]
/* 4.多表删除 */
    /* 语法结构 */
    DELEATE table1[.*],table2[.*]
    FROM table1 {[INNER] JOIN | {LEFT|RIGHT} [OUTER] JOIN} table2
    ON conditional_expr
    [WHERE where_conditon]