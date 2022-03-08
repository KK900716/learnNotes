自定义函数可以对mysql的函数进行扩展
    1.函数（存储函数）
        a.需要有返回值
        b.可以指定0~n个参数
    2.创建自定义函数
        a.语法格式
        CREATE FUNCTION function_name([func_parameter])
        RETURNS type
        [characteristics...] toutine_body
        b.characteristics存储函数的特性
            （1）SQL SECURITY{DEFINER|INVOKER}指明谁有权限来执行
            （2）DEFINER表示只有定义者才能执行
            （3）INVOKER表示拥有权限的调用者才可以执行，默认情况下，系统指定为DEFINER
            （4）COMMENT'string'注释信息，可以用来描述存储函数
        c.函数体
            函数体由sql代码构成
            函数体如果为复合结构需要使用BEGIN...END语句
            复合结构可以包含声明、流程控制
        示例:
        /* 开启 bin-log 后必须制定函数是否是
            1 DETERMINISTIC 不确定的
            2 NO SQL 没有SQl语句，当然也不会修改数据
            3 READS SQL DATA 只是读取数据，当然也不会修改数据
            4 MODIFIES SQL DATA 要修改数据
            5 CONTAINS SQL 包含了SQL语句
            解决办法1:
                执行:
                SET GLOBAL log_bin_trust_function_creators = 1;
                不过 重启了 就失效了
                注意:有主从复制的时候 从机必须要设置 不然会导致主从同步失败
                解决办法2:
                在my.cnf里面设置
                log-bin-trust-function-creators=1
                不过这个需要重启服务 */

        create function functest() returns varchar(5) return 'abc';

        /* 由于需要更改语句结束符，需要设置下列语句更改结束符 */
        delimiter //
        create function function_test1(mydate date)
        returns varchar(15)
        begin
        return date_format(mydate,'%Y-%m');
        end//
        delimiter ;
        /* 查询函数 */
        SHOW FUNCTION STATUS;      
        select functest();
    2.删除自定义函数
        语法格式
        DROP FUNCTION [IF EXISTS] func_name;
        drop function functest;
        drop function function_test1;
    3.流程控制使用
        a.变量定义
            DECLARE var_name[,varname]...date_type[DEFAULT value]
            例
            DECLARE num INT DEFAULT 10;
        b.赋值
            SET var_name=expr [,var_name=expr]...
            SELECT col_name[,...] INTO var_name[,...] table_expr
            例
            set num=100;
            select store into num from bookinfo;
        c.流程控制语句
            if 语句
                IF condition THEN
                    ...
                [ELSEIF condition THEN]
                    ...
                [ELSE]
                    ...
                END IF;
            case 语句
                CASE case_expr
                    WHEN when_value THEN statement_list
                    [WHEN when_value THEN statement_list]...
                    [ELSE statement_list]
                END CASE
            while 循环语句
                [while_label:]WHILE condition DO
                ...
                END WHILE[while_label]
            loop 循环语句
                该循环没有内置循环条件，可以通过leave语句退出循环
                [loop_label:]loop
                    statement_list
                END LOOP [loop_label]

                LEAVE label
            repeat 循环语句
                直到型循环
                [repeat_label:]REPEAT
                    ...
                UNTIL expr_condition
                END REPEAT [repeat_label]