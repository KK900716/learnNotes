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
    /* a.日期函数 */
        （1）curdate()
        （2）current_date()
            将当前日期按照“YYYY-MM-DD”或“YYYYMMDD”格式的值返回，具体格式根据函数在字符串或是数字语境中而定
            select curdate();
            select current_date();
            select curdate()+0;
    /* b.时间函数 */
        （1）curtime()
        （2）current_time()
            将当前时间以“HH:MM:SS”或“HHMMSS”的格式返回，具体格式根据函数在字符串或是数字语境中而定
            select curtime();
            select curtime()+0;
    /* c.获取日期时间 */
        （1）now()
        （2）sysdate()
            返回当前的日期时间值，格式为“YYYY-MM-DD HH:MM:SS”或“YYYYMMDDHHMMSS”，具体格式根据函数在字符串或数字语境中定
            select now();
            select now()+0;
    /* d.日期加运算 */
        （1）date_add(date,interval expr type)
            其中，date是一个datetime或date值，用来指定其实时间。expr是一个表达式，用来指定从起始日期添加或减去的时间间隔，type为关键词，他只是了表达式被解释的方式，如year、month、day、week、hour
            select date_add('2017-01-01',interval 5 month); 
            select date_add(date_add('2017-01-01',interval 5 month),interval 3 day) as time; 
        （2）datediff(date1,date2)计算两个日期之间的间隔天数
            select datediff((select date_add(date_add('2017-01-01',interval 5 month),interval 3 day)),(select date_add('2017-01-01',interval 5 month))) as time;
    /* e.日期格式化 */
        （1）date_format(date,format)根据format指定的格式显示date值
        （2）format取值: 
            %d 月份的缩写名称（Jan...Dec）
            %c 月份，数字形式（0...12）
            %m 月份，数字形式（00...12）
            %M 月份名称（January...December）
            %d 该月日期，数字形式（00...31）
            %e 该月日期，数字形式（0...31）
            %Y 4位形式表示年份
            %y 2位形式表示年份
            select date_format('2017-05-01',"%y%M"); 
/* 4.聚合函数 */
    a.avg()返回某列平均值
    b.count()返回某列的行数
    c.max()返回某列的最大值
    d.min()返回某列的最小值
    e.sum()返回某列值的和
/* 5.信息函数和加密函数 */
    /* a.信息函数 */
        （1）version()返回当前mysql服务器版本的版本号
        （2）connection_id()返回mysql服务器当前连接的此处，每个连接都有各自唯一的id
        （3）database()和schema()返回当前的数据库名
        （4）user()获取用户名的函数，返回当前登录的用户名称
        select version();
        select connection_id();
        select database();
        select schema();
        select user();
    /* b.加密函数 */
        （1）md5(str)信息摘要算法
            可以加密字符串，加密后的值以32位16进制数字的二进制字符串形式返回，若参数为null则返回null
            建议使用md5
            md5不可逆
        （2）password(str)密码算法
            从原明文密码计算并返回加密后的密码字符串，当参数为null时，返回null
            不可逆
            mysql8.0已经移除
        show databases;
        use book;
        create table myuser(
            username varchar(20),
            userpassword varchar(6)
        );
        alter table myuser modify userpassword varchar(64);
        insert into myuser values ('user1',md5('123456'));
        desc myuser;
        select * from myuser;
        select * from myuser where userpassword=md5('123456');
        select md5("我是一个mysql！");
        drop table myuser;
        select password('rootpwd');

        /* 需要注意的是 */
        /* mysql的用户存储在mysql这个数据库中，的user表中，用户名存储在User中，密码5.7版本之后存储在authentication_string中 */
        use mysql;
        show tables;
        desc user;
        select User,authentication_string from user;