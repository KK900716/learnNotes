1.用户管理
    a.root超级管理员
    b.权限表
        存储账户的权限信息表主要有:user db host tables_priv columns_priv procs_priv
        user
            记录允许连接到服务器的账户信息，里面的权限是全局级的
        db host
            非常重要的权限表
            db存储了用户对某个数据库的操作权限
            host存储了某个主机对数据库的操作权限
        tables_priv
            对表设置操作权限
        columns_priv
            对表的某一列设置权限
        procs_priv
            对存储过程和存储函数操作权限
2.账户创建
    CREATE USER | GRANT
    a.CREATE USER创建账户
        CREATE USER 'user'@'host'
        IDENTIFIED BY 'password'
        案例:
        create user 'rose'@'localhost' identified by 'rosepwd'; --有密码
        create user 'rose'@'localhost'; --无密码
        select user,host from mysql.user;
        新创建的用户没有权限需要grant语句赋予权限
    b.GRANT授权账户
        可以赋予权限
        GRANT privileges ON db.table TO 'user'@'host'
        案例:
        grant select,update on *.* to 'rose'@'localhost';
3.删除普通用户
    a.DROP USER user[,user]
    b.DELETE FROM mysql.user WHERE host='hostname' and user='username';
        案例:
        drop user 'rose'@'localhost';
4.权限管理
    a.使用grant赋予权限
        GRANT privileges ON db.table TO 'user'@'host'
        grant insert,select on book.* to 'rose'@'localhost';
        flush privileges;
        use book;
        show tables;
        select * from bookcategory;
    b.privileges
        insert update select delete等
        all privileges赋予所有权限
    c.查看用户授权
        SHOW GRANTS FOR 'user'@'localhost'
        show grants for 'rose'@'localhost';
        grant all privileges on book.* to 'rose'@'localhost';
    d.收回权限
        REVOKE privilege ON db.table FROM 'user'@'localhost'
        revoke insert on book.* from 'rose'@'localhost';