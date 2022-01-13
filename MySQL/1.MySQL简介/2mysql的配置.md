1.mysal登录
    mysql -u用户 -p密码
2.目录结构
    a.bin：用来存储一些可执行文件，如mysql.exe等
    b.include：用于存储包含的一些头文件，如mysql.h等
    c.lib：用来存储一些库文件
    d.share目录：用于存储错误信息、字符集文件
    e.data：用于放置一些日志文件以及数据库
    f.my.ini：数据库的配置文件
3.my.ini文件
    a.有两部分组成client配置和server配置
    b.为了避免中文乱码可以修改编码格式为utf8