JDBC（Java DataBase Connectivity）Java数据库连接
1.概念
    a.使用java语言操作关系型数据库的一套API
    b.JDBC可以理解为一个接口，各数据库要想让程序员使用java操作数据库，就要实现jdbc接口的实现类，即驱动
    c.官方定义的一套操作所有关系型数据库的规则，即接口
    示例：
```
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");//可省略
        //2.获取连接
        String url="jdbc:mysql://127.0.0.1:3306/test";
        String username="root";
        String password="********";
        Connection conn=DriverManager.getConnection(url,username,password);
        //3.定义sql语句
        String sql="update book set name = 'bc' where name_id = 123";
        //4.获取执行sql的对象
        Statement stmt=conn.createStatement();
        //5.执行sql返回受影响的行数
        int count=stmt.executeUpdate(sql);
        //6.处理结果
        System.out.println(count);
        //7.释放资源
        stmt.close();
        conn.close();
```
2.JDBC API详解
    a.DriverManager驱动管理类
        （1）注册驱动
        （2）获取数据库连接
        DriverManager.registerDriver()注册驱动，由mysql静态代码块自己完成
        DriverManager.getConnection(url,username,password)
            url
                语法jdbc:mysql://127.0.0.1:3306/test