1. 简介
    1. MyBatis是一款优秀的持久层框，用于简化JDBC开发
    2. 持久层
        负责将数据到保存到数据库的那一层代码
        JavaEE三成架构：表现层、业务层、持久层
    3. 框架
        框架就是一个半成品软件，是一套可复用的、通用的软件基础代码模型
        在框架的基础之上构建软件编写更佳高效、规范、通用、可扩展
2. 快速入门
    1. 创建表，添加数据
    2. 创建模块，导入坐标
    3. 编写MyBatis核心配置文件 --> 替换连接信息 解决硬编码问题
    4. 编写sql映射文件 --> 统一管理sql语句，解决硬编码问题
    5. 编码
        1. 定义POJO类
        2. 加载核心配置文件，获取SqlSessionFactory对象
        3. 获取SqlSession对象，执行sql语句
        4. 释放资源
    ```
        <dependencies>
            <!--mysql驱动-->
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>8.0.25</version>
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
            List<Book> book=sqlSession.selectList("test.selectAll");//namespace+id

            System.out.println(book);
            //4.释放资源
            sqlSession.close();
    ```
3. Mapper代理开发
    1. 定义与sql映射文件同名的Mapper接口，并且将Mapper接口和sql映射文件放置在同一个目录下
    2. 设置sql映射文件的namespace属性为Mapper接口全限定名
    3. 在Mapper接口中定义方法，方法名就是sql映射文件中sql语句的id，并保持参数类型和返回值类型一致
    4. 编码
        1. 通过sqlSession的getMapper方法获取Mapper接口的代理对象
        2. 调用对应方法完成sql的执行
        3. 注意在resources下创建目录要用/替换.
    5. 可以在select语句中起别名则可以避免数据库表中列名和实现类中名不同
    6. 可以定义sql片段来避免5中的问题过于麻烦
    ```
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE mapper
            PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
            "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="com.mapper.BrandMapper">

    
    </mapper>
    ```
    ```
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE configuration
            PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
            "http://mybatis.org/dtd/mybatis-3-config.dtd">
    <configuration>
        <!--起别名-->
        <typeAliases>
            <package name="com.pojo"/>
        </typeAliases>
        <environments default="development">
            <environment id="development">
                <transactionManager type="JDBC"/>
                <dataSource type="POOLED">
                    <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                    <property name="url" value="jdbc:mysql:///test?useServerPrepStmts=true"/>
                    <property name="username" value="root"/>
                    <property name="password" value="********"/>
                </dataSource>
            </environment>
        </environments>
        <mappers>
            <!--扫描mapper-->
            <package name="com.mapper"/>
        </mappers>
    </configuration>
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
    ```
    public class SqlSessionFactoryUtils {
        private static SqlSessionFactory sqlSessionFactory;
        static {
            String resource = "mybatis-config.xml";
            InputStream inputStream = null;
            try {
                inputStream = Resources.getResourceAsStream(resource);
            } catch (IOException e) {
                e.printStackTrace();
            }
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        }
        public static SqlSessionFactory getSqlSessionFactory(){
            return sqlSessionFactory;
        }
    }
    ```
    7. 可以使用resultmap解决e、f的问题
        id：唯一表示  type：映射的类型，支持别名
        内部有id：完成主键字段映射  result：完成一般字段的映射
        1. 定义resultMap标签
        2. 在select标签中，使用resultMap属性替换resultType属性
4. 参数占位符
    1. #{}:会将其替换为? 为了防止sql注入
    2. ${}:直接拼接参数，存在sql注入问题
        故参数传递一定要用#{变量}
    3. 特殊字符例如大于号小于号等
        转义
        CDATA区
    4. 传递参数    
        （1）散装参数 @Param("value")来注明每个参数
        （2）对象参数
        （3）map集合参数
    ```
    List<Brand> selectByCondition(@Param("status")int status,@Param("company_name")String company_name,@Param("brand_name")String brand_name);
    List<Brand> selectByCondition(Brand brand);
    List<Brand> selectByCondition(Map map);
    ```
5. 动态sql
    1. 多条件动态条件查询
        1. mybatis允许使用动态sql语句
        2. if标签，一般判断参数是否有值<if test=""></if>
            存在问题第一个条件不需要逻辑运算符
        3. where标签<where></where>避免语句格式不统一，解决b中存在的问题
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
    2. 单条件动态条件查询
        1.
        ```
        <choose>
            <when test="">
            <otherwise></otherwise>
        </choose>
        ```
        2.
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
    3. sql片段抽取
        ```
        <sql id="brand_column">
        --         sql片段
        </sql>
        <include refid="brand_column">
        ```
6. 添加
    1. 直接利用mapper代理方式添加
    2. mybatis增删改查会自动开启事务
        1. 通过openSession()默认开启事务，传递true可以关闭事务
        2. sqlSession.commit()可以提交事务
    3. 主键返回
        useGeneratedKeys="true"  keyProperty="id"可以绑定主键
7. 修改
    1. 包含动态sql修改
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
8. 删除
    1. 单个删除
    2. 批量删除，需要用动态sql
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
9. 参数传递
    1. mybatis会将多个参数封装为Map集合
    例如
    User select(String username,String password);
    封装为
        map.put("arg0",参数值1)
        map.put("param1",参数值1)
        map.put("arg1",参数值2)
        map.put("param2",参数值2)
    @param注解可以替换map的键
    2. 单个参数
        POJO类型：直接使用，属性名和参数占位符名称一致
        Map集合：直接使用，键名和参数占位符一致
        Collection：封装为Map集合 键名arg0 collection
        List：封装为Map集合 键名arg0 collection list
        Array：封装为Map集合 键名arg0 array
        其他类型：直接使用
    3. 结论，为方便开发最好用@param替换默认的arg名称，并使用arg
10. 注解完成增删改查
    1. 简单的语句可以用注解方式
    2. mybatis官方建议复杂语句还是应该配置xml
        1. @Select
        2. @Insert
        3. @Update
        4. @Delete
        5. @Result 实现结果集封装
            1. column 数据库列名
            2. property 需要装配的属性名
            3. one
            4. many
        6. @Results 可以与@Result一起使用，封装多个结果集
        ```
        @Results({
                @Result(column = "",property = ""),
                @Result(column = "",property = ""),
                @Result(column = "",property = ""),
                @Result(
                        property = "",
                        column = "",
                        javaType = User.class,
                        //查询哪个接口的方法获取值
                        one = @One(select = "com.mapper.UserMapper.find"),
                        many = @Many(select = "")
                )
        })
        ```
        7. @One 实现一对一结果集封装
        8. @Many 实现一对多结果集封装
11. 核心配置文件
    1. MyBatis核心配置文件层级关系
        1. configuration配置
            1. properties属性
            2. settings设置
            3. typeAliases类别名
            4. typeHandlers类型处理器
            5. objectFactory对象工厂
            6. plungins插件
            7. environments环境
                1. environment环境变量
                    1. transactionManager事务管理器
                    2. dataSource数据源
                    ```
                    <!-- 指定默认的环境名称 -->
                    <environments default="development">
                        <!-- 指定当前环境的名称 -->
                        <environment id="development">
                            <!-- 指定事务管理类型是JDBC -->
                            <transactionManager type="JDBC"/>
                            <!-- 指定当前数据源类型是连接池 -->
                            <dataSource type="POOLED">
                                <!-- 数据源配置的基本参数 -->
                                <property name="driver" value="com.mysql.cj.jdbc.Driver"/>
                                <property name="url" value="jdbc:mysql:///test?useServerPrepStmts=true"/>
                                <property name="username" value="root"/>
                                <property name="password" value="********"/>
                            </dataSource>
                        </environment>
                    </environments>
                    ```
            8. databaseIdprovider数据库厂商标识
            9. mappers映射器
    2. environments标签
        1. 事务管理器类型有两种
            1. JDBC这个配置就是直接使用了JDBC的提交和回滚设置，他依赖于从数据源得到的连接来管理事务作用域
            2. MANAGED这个配置几乎没错什么。他从来不提交或回滚一个连接，而是让容器来管理事务的整个生命周期。默认情况下它会关闭连接，然而一些容器不希望这样，因此需要将closeConnection属性设置为false来组人他默认关闭的行为
        2. 数据源类型有三种
            1. UNPOOLED这个数据源的实现只是每次被请求时打开或关闭连接
            2. POOLED这种数据源的实现利用“池”的概念将JDBC连接对象组织起来
            3. JNDI这个数据源的实现是为了能在如EJB或应用服务器这雷容器中使用，容器可以集中或在外部配置数据源，然后放置一个JNDI上下文的引用
    3. mapper标签
        1. 该标签的作用是加载映射的，加载方式有如下几种
        2. 使用相对于类路径的资源引用 resources属性
        3. 使用完全限定资源定位符URL url属性
        4. 使用映射器接口实现类的完全线性类名 class属性
        5. 将包内的映射器接口实现全部注册为映射器 package标签的name属性
    4. properties属性
    ```
    <properties resource="jdbc.properties"/>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="${jdbc.driver}"/>
                <property name="url" value="${jdbc.url}"/>
                <property name="username" value="${jdbc.username}"/>
                <property name="password" value="${jdbc.password}"/>
            </dataSource>
        </environment>
    </environments>
    ```
    5. typeAliases标签
        1. 类型别名是为Java类型设置一个短的名字。原来的类型名称配置需要写全限定名
        2. Mybatis已经为我们自定义了常用类型的别名
    6. tpyeHandlers标签
        1. 类型处理器
        2. 可以重写类型处理器或创建自己的类型处理器来处理不支持的非标准类型。
            1. 定义转换类继承类BaseTypeHandler<T>，或实现TypeHandler接口
            2. 覆盖4个为实现的方法，其中setNonNullParameter为java城西设置数据到数据库的回调方法，getNullableResult为查询时mysql的字符串类型转换为java的Type类型的方法
            3. 在Mybatis核心配置文件中进行注册
            4. 测试转换是否成功
            ```
            CREATE TABLE `tb_user` (
            `id` int NOT NULL AUTO_INCREMENT,
            `username` varchar(20) DEFAULT NULL,
            `password` varchar(32) DEFAULT NULL,
            `date` bigint DEFAULT NULL,
            PRIMARY KEY (`id`),
            UNIQUE KEY `username` (`username`)
            ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3
            ```
            ```
                private Integer id;
                private String username;
                private String password;
                private Date date;
            ```
            ```
            public class DateTypeHandler extends BaseTypeHandler<Date> {
                //将java类型转换为数据库类型
                @Override
                public void setNonNullParameter(PreparedStatement preparedStatement, int i, Date date, JdbcType jdbcType) throws SQLException {
                    preparedStatement.setLong(i,date.getTime());
                }
                //将数据库类型转换为java类型
                @Override
                public Date getNullableResult(ResultSet resultSet, String s) throws SQLException {
                    return new Date(resultSet.getLong(s));
                }
                @Override
                public Date getNullableResult(ResultSet resultSet, int i) throws SQLException {
                    return new Date(resultSet.getLong(i));
                }
                @Override
                public Date getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
                    return new Date(callableStatement.getLong(i));
                }
            }
            ```
            ```
            <typeHandlers>
                <package name="com.handler"/>
            </typeHandlers>
            ```
    6. plugins标签
        1. Mybatis可以使用第三方的插件来对功能进行扩展，分页助手PageHelper试讲分页的复杂操作进行封装，使用简单的方式即可获得分页的相关数据
        2. 开发步骤
            1. 导入通用PageHelper的坐标
            ```
            <dependency>
                <groupId>com.GitHub.pagehelper</groupId>
                <artifactId>pagehelper</artifactId>
                <version>3.7.5</version>
            </dependency>
            <dependency>
                <groupId>com.GitHub.jsqlparser</groupId>
                <artifactId>jsqlparser</artifactId>
                <version>0.9.1</version>
            </dependency>
            ```
            2. 在MyBatis核心配置文件中配置PageHelper插件
            ```
            <plugins>
                <plugin interceptor="com.github.pagehelper.PageHelper">
                    <property name="dialect" value="mysql"/>
                </plugin>
            </plugins>
            ```
            3. 测试分页数据获取
            ```
            //设置分页相关参数 当前页+每页显示的条数
            PageHelper.startPage(1,2);
            //获得与分页相关参数
            PageInfo<User> pageInfo=new PageInfo<User>(users);
            System.out.println("当前页"+pageInfo.getPageNum());
            System.out.println("每页显示条数"+pageInfo.getSize());
            System.out.println("总条数"+pageInfo.getTotal());
            System.out.println("总页数"+pageInfo.getPages());
            System.out.println("上一页"+pageInfo.getPrePage());
            System.out.println("下一页"+pageInfo.getNextPage());
            System.out.println("是否是第一页"+pageInfo.isIsFirstPage());
            System.out.println("是否是最后一页"+pageInfo.isIsLastPage());
            ```
12. MyBatis的多表操作
    1. 一对一查询
    ```
    <resultMap id="orderMap" type="com.domain.Order">
        <!--手动指定字段实体与属性的映射关系-->
        <id column="orders.id" property="id"/>
        <result column="ordertime" property="ordertime"/>
        <result column="total" property="total"/>
        <result column="username" property="user.username"/>
        <result column="password" property="user.password"/>
    </resultMap>
    <select id="selectAll" resultMap="orderMap">
        select orders.id id,ordertime,total,username,password from orders,tb_user where orders.id=tb_user.id
    </select>
    ```
    ```
    <resultMap id="orderMap" type="com.domain.Order">
        <!--手动指定字段实体与属性的映射关系-->
        <id column="id" property="id"/>
        <result column="ordertime" property="ordertime"/>
        <result column="total" property="total"/>
        <!--property：当前实体中属性的名称-->
        <!--javaType:当前实体的属性类型-->
        <association property="user" javaType="com.domain.User">
            <id column="id" property="id"/>
            <result column="username" property="username"/>
            <result column="password" property="password"/>
        </association>
    </resultMap>
    ```
    2. 一对多查询
    ```
        <collection property="orderList" ofType="com.domain.Order">
            <result column="ordertime" property="ordertime"/>
            <result column="total" property="total"/>
        </collection>
    ```
    3. 多对多查询
13. mybatis结合springboot
    1. 日志配置
    ```
    mybatis:
    configuration:
        log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
    ```
    2. 分页插件
    ```
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>1.4.1</version>
        </dependency>
    ```
    3. 