存储过程
    存储过程是sql语句和流程控制语句的预编译的集合，并以一个名称存储并作为一个单元进行处理
    执行效率比select语句要高
    a.语法结构
        （1）CREATE PROCEDURE proc_name([proc_parameter]) [characteristics...] routine_body
        （2）proc_parameter指定存储过程的参数列表，形式如下
            [IN | OUT | INOUT] param_name type
            默认为in输入参数
        （3）characteristics存储特性同定义函数相同
    b.过程体
        过程体由合法的sql语句构成
        过程体如果为复合结构则使用BEGIN...END语句
        复合结构可以包含声明，流程控制语句
    c.例
        创建一个查询图书的编号、书名、价格和库存的存储过程

        create procedure selectproc()
        select 'abc' t;

        call selectproc();

        drop procedure selectproc;