1.简介
    a.MyBatis是一款优秀的持久层框，用于简化JDBC开发
    b.持久层
        负责将数据到保存到数据库的那一层代码
        JavaEE三成架构：表现层、业务层、持久层
    c.框架
        框架就是一个半成品软件，是一套可复用的、通用的软件基础代码模型
        在框架的基础之上构建软件编写更佳高效、规范、通用、可扩展
2.快速入门
    a.创建表，添加数据
    b.创建模块，导入坐标
    c.编写MyBatis核心配置文件 --> 替换连接信息 解决硬编码问题
    d.编写sql映射文件 --> 统一管理sql语句，解决硬编码问题
    e.编码
        1.定义POJO类
        2.加载核心配置文件，获取SqlSessionFactory对象
        3.获取SqlSession对象，执行sql语句
        4.释放资源
```
        //1.加载mybatis核心配置文件SqlSessionFactory
        String resource = "mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //2.获取SqlSession对象，用它来执行sql
        SqlSession sqlSession=sqlSessionFactory.openSession();

        //3.执行sql语句
        List<Book> book=sqlSession.selectList("test.selectAll");

        System.out.println(book);
        //4.释放资源
        sqlSession.close();
```
3.Mapper代理开发
    a.定义与sql映射文件同名的Mapper接口，并且将Mapper接口和sql映射文件放置在同一个目录下
    b.设置sql映射文件的namespace属性为Mapper接口全限定名
    c.在Mapper接口中定义方法，方法名就是sql映射文件中sql语句的id，并保持参数类型和返回值类型一致
    d.编码
        通过sqlSession的getMapper方法获取Mapper接口的代理对象
        调用对应方法完成sql的执行
        注意在resources下创建目录要用/替换.
    e.可以在select语句中起别名则可以避免数据库表中列名和实现类中名不同
    f.可以定义sql片段来避免e中的问题过于麻烦
```
    <sql id="brand_column">
--         sql片段
    </sql>
    <include refid="brand_column">
```
```
        //mybatis代理开发
        //1.加载mybatis核心配置文件SqlSessionFactory
        String resource = "mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        //2.获取SqlSession对象，用它来执行sql
        SqlSession sqlSession=sqlSessionFactory.openSession();

        //3.执行sql语句
//        List<Book> book=sqlSession.selectList("test.selectAll");
//        3.1获取接口代理对象
        BookMapper bookMapper=sqlSession.getMapper(BookMapper.class);
        List<Book> book=bookMapper.selectAll();

        System.out.println(book);
        //4.释放资源
        sqlSession.close();
```
    g.可以使用resultmap解决e、f的问题
        id：唯一表示  type：映射的类型，支持别名
        内部有id：完成主键字段映射  result：完成一般字段的映射
        （1）定义resultMap标签
        （2）在<select>标签中，使用resultMap属性替换resultType属性
4.参数占位符
    a.#{}:会将其替换为? 为了防止sql注入
    b.${}:直接拼接参数，存在sql注入问题
        故参数传递一定要用#{}
    c.特殊字符例如大于号小于号等
        转义
        CDATA区
    d.传递参数    
        （1）散装参数 @Param("value")来注明每个参数
        （2）对象参数
        （3）map集合参数
```
    List<Brand> selectByCondition(@Param("status")int status,@Param("company_name")String company_name,@Param("brand_name")String brand_name);
    List<Brand> selectByCondition(Brand brand);
    List<Brand> selectByCondition(Map map);
```
5.动态sql（多条件查询）