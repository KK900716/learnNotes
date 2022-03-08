日志
    mysql的日志记录了mysql数据库的运行情况、用户操作、错误信息等，可以为mysql管理和优化提供必要的信息
    1.错误日志
        记录mysql服务的启动、运行或停止mysql服务时出现的问题
        默认情况下，错误日志会记录到数据库的数据目录下，如果没有在配置文件中指定文件名，则文件名默认为hostname.ree
        可以修改my.ini来启动和关闭日志
        log-error="" --日志文件名称
        使用SHOW VARIABLES查询错误日志的路径;
        show variables like 'log_error';

        删除日志文件后重新创建日志文件
            服务器端执行
                mysqladmin -uroot -p flush-logs
            登录mysql执行flush logs
    2.查询日志
        记录了mysql的所有用户操作，包括启动和关闭服务、执行查询和更新语句等
    3.二进制日志
        记录所有更改数据的语句
    4.慢查询日志
        记录所有执行时间超过long_query_time的所有查询或不适用索引的查询
数据库的备份与恢复
    1.备份
        mysqldump命令，将数据库被分成一个文本文件
        （1）语法格式
            mysqldump -u user -h host -p password
            dbnaem[tbname,[tbname]] > filename.sql
        （2）案例
            服务器下
            mysqldump -uroot -p book > 路径
            mysqldump -uroot -p book bookcategory > 路径
            mysqldump -uroot -p --databases book1 book2 > 路径
            mysqldump -uroot -p --all-databases > 路径
    2.恢复
        （1）语法格式
            mysql -u user -p [dbname] < filename.sql
        （2）服务器下使用
            source filename
数据库的导出和导入
    1.导出
        mysql下
        a.语法格式
            SELECT columnlist FROM talbe WHERE condition INTO OUTFILE 'filename' [OPTIONS]
        b.OPTIONS为可选参数，比如
            FIELDS TERMINATEB BY 'value' 设置字段之间的分隔字符，可以为单个或多个字符，默认情况下为制表符'\t'
            LINES TERMINATED BY 'value' 设置每行数据结尾的字符，可以为单个或多个字符，默认值为'\n'
        c.示例
            select * from book.bookcategory into outfile '路径';
            需要注意这里的位置不能随便指定，需要在my.ini中寻找Secure File Priv.
            可是设置null不允许导出、''任意位置
    2.mysqldump导出
        服务器下
        a.语法格式
            mysqldump -T path -u user -p password [tables][OPTIONS]
        b.OPTIONS为可选参数，比如
            --fileds-terminated-by=value 设置字段之间的分隔字符，可以为单个或多个字符，默认情况下为制表符'\t'
            --lines-terminated-by=value 设置每行数据结尾的字符，可以为单个或多个字符，默认值为'\n'
    3.mysql导出
        服务器下
        a.语法格式
            mysql -u user -p --execute="SELECT语句" dbname > filename.txt
    4.导入
        mysql下
        a.语法格式
            LOAD DATA INFILE 'filename.txt' INTO TABLE tablename [OPTIONS][IGNORE number LINES]
        b.OPTIONS为可选参数，比如
            FIELDS TERMINATEB BY 'value' 设置字段之间的分隔字符，可以为单个或多个字符，默认情况下为制表符'\t'
            LINES TERMINATED BY 'value' 设置每行数据结尾的字符，可以为单个或多个字符，默认值为'\n'
    5.mysqlimport导入
        服务器下
        a.语法格式
            mysqlimport -u root -p dbname filename.txt [OPTIONS]
        b.OPTIONS为可选参数，比如
            --fileds-terminated-by=value 设置字段之间的分隔字符，可以为单个或多个字符，默认情况下为制表符'\t'
            --lines-terminated-by=value 设置每行数据结尾的字符，可以为单个或多个字符，默认值为'\n'