1.修改用户密码的命令
    mysqladmin -u用户名 -p旧密码 password
    新密码
2.显示数据库
    show databases;
        a.information_schema提供了数据库源数据的信息，例如数据库的数据、数据库的名字、数据库的表名、数据库的字段名
        b.mysql存储了用户的数据权限信息、帮助信息
        c.performance_schema数据库性能相关的数据，记录数据库服务器的性能参数
        d.sys通过这个库可以了解系统的运行信息
3.使用数据库
    use <数据库的名称>
    例如：use mysql
4.select命令
    a.此命令用来显示当前连接（选择）的信息
    b.显示当前联机的数据库
        select database();
    c.显示当前服务器版本
        select version();
    d.显示当前日期时间
        select now();
    e.显示当前用户
        select user();