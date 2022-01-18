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
                        协议://ip(域名):端口号/数据库名称/?参数值对1&参数值对2...
                    本机和默认端口可省略ip和端口
                    配置useSSL=false参数，禁用安全连接方式，解决警告提示
    b.Connection
        （1）获取执行sql对象
            createStatement()普通执行sql对象
            preparedStatement(sql)预编译sql的执行sql对象，防止sql注入
            预编译空能开启
            useServerPrepStmts=true
```
            String url="jdbc:mysql:///test?useServerPrepStmts=true";
```
            防止sql注入
                1）获取PreparedStatement对象
```
                    String name_id="123";
                    String sql="select * from book where name_id=?";
                    PreparedStatement pstmt=conn.prepareStatement(sql);
```
                2）设置参数值
```
                    pstmt.setInt(1,Integer.parseInt(name_id));
```
                3）执行语句
```
                    String url="jdbc:mysql:///test";
                    String user="root";
                    String password="********";
                    Connection conn= DriverManager.getConnection(url,user,password);
                    String name_id="123";
                    String sql="select * from book where name_id=?";
                    PreparedStatement pstmt=conn.prepareStatement(sql);
                    pstmt.setInt(1,Integer.parseInt(name_id));
                    ResultSet re= pstmt.executeQuery();
                    while(re.next()){
                        System.out.println(re.getInt(1));
                        System.out.println(re.getString(2));
                    }
                    re.close();
                    pstmt.close();
                    conn.close();
```
            prepareCall(sql)执行存储过程的对象
        （2）管理事务
            setAutoCommit(boolean autoCommit)开启事务，true为自动提交事务，false为手动提交事务，即开启事务
            commit()提交事务
            rollback()rollback回滚事务
    c.Statement
        （1）执行sql语句即DML、DDL、DQL
        （2）DML、DDL
            int executeUpdate(sql)返回值
                DML影响行数
                DDL执行结果，执行成功可能返回0
        （3）DQL
            ResultSet executeUpdate(sql)返回值
                结果集对象
    d.ResultSet结果集对象
        （1）封装了DQL结果
            指针始终指向要获取的当前行的上一行
        （2）boolean next()=true/false表示当前有没有数据并向下移动指针
        （3）xxx getXxx(参数)获取数据
            xxx 数据类型
            参数 列的名称或列的序号（从1开始）
```
        String url="jdbc:mysql:///test";
        String user="root";
        String password="********";
        Connection conn= DriverManager.getConnection(url,user,password);
        String sql="select * from book";
        Statement stat=conn.createStatement();
        ResultSet re= stat.executeQuery(sql);
        while(re.next()){
            System.out.println(re.getInt(1));
            System.out.println(re.getString(2));
        }
        re.close();
        stat.close();
        conn.close();
```