/* 1.运算符 */
    /* a.算数运算符 */
    + - * / %
    /* 示例 */
        select category_id+1,category_id-1,category_id*2,category_id/2,category_id%1 from bookcategory2;
    /* b.比较运算符 */
        > < >= <= = 
        <> != 
        is null 
        is not null
        between ... and
        in
        not in
        like
    /* 通配符一对一 _ 一对一或多 % */
    /* c.逻辑运算符 */
        and or not
/* 2.数值函数 */
    /* 数值函数 字符函数 日期时间函数 聚合函数 信息函数 加密函数 */
    /* a.数值函数 */
        （1）ceil(x)向上取整
        select ceil(28.55);
        （2）floor(x)向下取整
        （3）round(x)四舍五入
            round(x,n)n可以为负值，表示保留的位数
        （4）truncate(x,y)截断函数,原理同上
        （5）mod(x)取模
    /* b.字符函数 */
        （1）concat(s1,s2,...,sn)字符串连接函数，如果任何一个参数为null，返回null
        （2）concat_ws(x,s1,s2,...,sn)第一个参数x是其他参数的费歌赋，如果分隔符为null，返回null
        select concat('s1','s2',null);
        select concat_ws('-','s1',null);
        select concat_ws(null,'s1','s2');
        （3）lower(str)转小写函数
        （4）upper(str)转大写函数
        （5）length(str)字符串字节长度函数
        （6）ltrim(s)删除左侧空格
        （7）rtrim(s)删除右侧空格
        （8）trim(s)删除空格
        （9）substring(s,n,len)从字符串s返回一个长度为len字符相同的子字符串，其实于位置n
            如果n是负数，则子字符串的位置起始于字符串结尾的n个字符
            select substring('hello world',1,5);
            结果:hello
            select substring('hello world',-3,2);
            结果:rl
        （10）left(s,n)返回字符串s开始的最左边n个字符
        （11）right(s,n)返回字符串s开始的最右边n个字符
        （12）replace(str,from_str,to_str)字符串替换函数
            select replace('hello world','world','mysql');
            结果:hello mysql
        （13）format(x,n)将数字x格式化，并以四舍五入方式保留小数点后n位，结果以字符串形式返回，若n为0，则返回结果不含小数部分
            select format(1234.5678,2);
            结果:1,234.57
            select format(1234.5,2);
            结果:1,234.50
            select format(1234.5678,0);
            结果:1,235
/* 3.日期时间函数 */
