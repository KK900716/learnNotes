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
    <dependencies>
        <!--mysql驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.25</version>
        </dependency>
        <!--德鲁伊驱动-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.2.8</version>
        </dependency>
        <!--mybatis驱动-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.5</version>
        </dependency>
        <!--junit驱动-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13</version>
            <scope>test</scope>
        </dependency>
        <!--添加slf4j日志api-->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.20</version>
        </dependency>
        <!--添加logback-classic依赖-->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>1.2.3</version>
        </dependency>
        <!--添加logback-core依赖-->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-core</artifactId>
            <version>1.2.3</version>
        </dependency>
    </dependencies>
```
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
        故参数传递一定要用#{变量}
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
5.动态sql
    多条件动态条件查询
        a.mybatis允许使用动态sql语句
        b.if标签，一般判断参数是否有值<if test=""></if>
            存在问题第一个条件不需要逻辑运算符
        c.where标签<where></where>避免语句格式不统一，解决b中存在的问题
```
    <select id="selectByCondition" resultType="com.pojo.Brand">
        select *
        from tb_brand
        <where>
            <if test="status!=null">
                and status = #{status}
            </if>
            <if test="company_name!=null and company_name!=''">
                and company_name like #{company_name}
            </if>
            <if test="brand_name!=null and brand_name!=''">
                and brand_name like #{brand_name};
            </if>
        </where>
    </select>
```
    单条件动态条件查询
    a.<choose>
        <when test="">
        <otherwise></otherwise>
    </choose>
    b.
```
        <where>
            <choose>
                <when test="status!=null">
                    status=#{status}
                </when>
                <when test="company_name!=null and company_name!=''">
                    company_name like #{company_name}
                </when>
                <when test="brand_name!=null and brand_name!=''">
                    brand_name like #{brand_name};
                </when>
            </choose>
        </where>
```
6.添加
    a.直接利用mapper代理方式添加
    b.mybatis增删改查会自动开启事务
        （1）通过openSession()默认开启事务，传递true可以关闭事务
        （2）sqlSession.commit()可以提交事务
    c.主键返回
        useGeneratedKeys="true"  keyProperty="id"可以绑定主键
7.修改
    包含动态sql修改
```
    <update id="update">
        update tb_brand
        <set>
            <if test="brand_name!=null and brand_name!=''">
                brand_name = #{brand_name},
            </if>
            <if test="company_name!=null and company_name!=''">
                company_name = #{company_name},
            </if>
            <if test="ordered!=null">
                ordered = #{ordered},
            </if>
            <if test="description!=null and description!=''">
                description = #{description},
            </if>
            <if test="status!=null">
                status = #{status}
            </if>
        </set>
        where id=#{id};
    </update>
```
8.删除
    a.单个删除
    b.批量删除，需要用动态sql
        mybatis会将数组参数封装成一个Map集合 默认 array=数组
```
    <delete id="deleteByIds">
        delete from tb_brand
        where id in
        <foreach collection="array" item="id" separator="," open="(" close=");">
            #{id}
        </foreach>
    </delete>
```
9.参数传递
    a.mybatis会将多个参数封装为Map集合
    例如
    User select(String username,String password);
    封装为
        map.put("arg0",参数值1)
        map.put("param1",参数值1)
        map.put("arg1",参数值2)
        map.put("param2",参数值2)
    @param注解可以替换map的键
    b.单个参数
        POJO类型：直接使用，属性名和参数占位符名称一致
        Map集合：直接使用，键名和参数占位符一致
        Collection：封装为Map集合 键名arg0 collection
        List：封装为Map集合 键名arg0 collection list
        Array：封装为Map集合 键名arg0 array
        其他类型：直接使用
    c.结论，为方便开发最好用@param替换默认的arg名称，并使用arg
10.注解完成增删改查
    a.简单的语句可以用注解方式
    b.mybatis官方建议复杂语句还是应该配置xml
    @Select
    @Insert
    @Update
    @Delete