1. 简介
    1. Spring是分层的JavaSE/EE应用full-stack轻量级开源框架，以IOC（Inverse Of Control：反转控制）和AOP（Aspect Oriented Programming：面向切面编程）为内核。
    2. 提供了展现层SpringMVC和持久层Spring JDBCTemplate一级业务事务管理等众多的企业级应用技术，还能整合开源世界众多注明的第三方框架和类库，逐渐成为使用最多的JavaEE企业应用开源框架。
    3. 发展
       1. 1997年IBM提出了EJB的思想
       2. 1998年SUN制定开发标准规范EJB1.0
       3. ...
       4. Rod Johnson（Spring之父）
       5. ...
       6. 2017年9月发布了Spring的最新版本Spring5.0通用版（GA）
2. 优势
   1. 方便解耦简化开发
   2. AOP编程的支持
   3. 声明式事务的支持
   4. 方便程序的测试
   5. 方便集成各种优秀的框架
   6. 降低JavaEE API的使用难度
   7. Java源码是经典学习范例
3. Spring的体系结构
   1. 一
      1. Data Access/Integration 数据访问层
         1. JDBC
         2. ORM
         3. OXM
         4. JMS
         5. Transactions
      2. Web
         1. WebSocket
         2. Servlet
         3. Web
         4. Portlet
   2. 二
      1. APO 切面
      2. Aspects
      3. Instrument
      4. Messaging
   3. 三
      1. Core Container
         1. Beans 容器
         2. Core 核心
         3. Context 上下文
         4. SpEL Spring表达式语言
   4. 四
      1. Test
4. 快速入门
   1. 导入Spring开发的基本包坐标
   2. 编写Dao接口和实现类
   3. 创建Spring核心配置文件
   4. 在Spring配置文件中配置UserDaolmpl
   5. 使用Spring的API获得Bean实例
   ```
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>5.0.5.RELEASE</version>
        </dependency>
   ```
5. Spring配置文件
   1. Bean标签基本配置
      1. id Bean实例在Spring容器中的唯一标识
      2. class Bean的全限定名称
         ```
            <bean id="userDao" class="com.shzu.dao.impl.UserDaoImpl"></bean>
         ```
   2. Bean标签范围配置
      1. scope指对象的作用范围，取值如下：
      2. singleton 默认值，单例的
         1. Bean实例化个数1个
         2. 加载配置文件时就创建Bean
         3. Bean生命周期：
            1. 当应用加载，创建容器时，对象就被创建
            2. 只要容器在，对象一直活着
            3. 当应用卸载，销毁容器时，对象就被销毁
      3. prototype 多例的
         1. Bean实例化个数多个
         2. 当调用getBean()方法时实例化Bean
         3. Bean的生命周期：
            1. 当使用对象时，创建新的对象实例
            2. 只要对象在使用中，就一直活着
            3. 当对象长时间不用时，被Java的垃圾回收器回收了
      4. request WEB项目中，Spring创建一个Bean的对象，将对象存入到request域中
      5. session WEB项目中，Spring创建一个Bean的对象，将对象存入到session域中
      6. global session WEB项目中，应用在Portlet环境，如果没有Portlet环境那么globalSession相当于session
   3. Bean标签生命周期配置
      1. init-method 指定类中的初始化方法名称
      2. destroy-method 指定类中销毁方法名称
   4. Bean实例化三种方式
      1. 无参构造方法
      2. 工厂静态方法
   ```
    <bean id="userDao" class="com.shzu.factory.StaticFactory" factory-method="getUserDao" scope="singleton"></bean>
   ```
      3. 工厂实例方法
   ```
    <bean id="dynamicFactory" class="com.shzu.factory.DynamicFactory"></bean>
    <bean id="userDao" factory-bean="dynamicFactory" factory-method="getUserDao" scope="singleton"></bean>
   ```
   5. Spring依赖注入（Dependency Injection）
      1. 他是Spring框架核心IOC的具体实现
      2. 在编写程序时，通过控制反转，把对象的创建交给Spring，但是代码中不可能出现没有依赖的情况
      3. IOC解耦只是降低他们的依赖关系，但不会消除。例如业务层仍会调用持久层的方法
      4. 那这种业务层和持久层的依赖关系，在使用Spring之后，就让Spring来维护了
      5. 简单的说，就是坐等框架把持久层对象传入业务层，而不用我们自己去取
   6. Bean的依赖注入方式
      1. 构造方法
   ```
         <constructor-arg name="userDao" ref="userDao"></constructor-arg>
   ```
      2. set方法
         1. property属性设置
   ```
        <property name="userDao" ref="userDao"/>
   ```
         2. p命名空间注入
            1. p命名空间
   ```
       xmlns:p="http://www.springframework.org/schema/p"
        <bean id="userService" class="com.shzu.service.Impl.UserServiceImpl" p:userDao-ref="userDao"></bean>
   ```
   7. Bean的依赖注入的数据类型
      1. 普通数据类型
      2. 引用数据类型
      3. 集合数据类型
   ```
    <bean id="userDao" class="com.shzu.dao.impl.UserDaoImpl" scope="singleton" >
        <property name="username" value="zhangsan"/>
        <property name="age" value="18"/>
        <property name="stringList">
            <list>
                <value>aaa</value>
                <value>bbb</value>
                <value>ccc</value>
                <value>ddd</value>
            </list>
        </property>
        <property name="userMap">
            <map>
                <entry key="1" value-ref="user1"/>
                <entry key="2" value-ref="user2"/>
            </map>
        </property>
        <property name="properties">
            <props>
                <prop key="p1">ppp1</prop>
                <prop key="p2">ppp2</prop>
                <prop key="p3">ppp3</prop>
            </props>
        </property>
    </bean>
    <bean id="user1" class="com.shzu.pojo.User">
        <property name="name" value="tom"/>
        <property name="add" value="beijing"/>
    </bean>
    <bean id="user2" class="com.shzu.pojo.User">
        <property name="name" value="lucky"/>
        <property name="add" value="tianjin"/>
    </bean>
   ```
   8. 引入其他配置文件（分模块开发）
   ```
    <import resource="applicationContext.xml"/>
   ```
   9. Spring相关的API
      1. ApplicationContext的继承体系
          1. Applicationcontext 接口类型，代表应用上下文，可以通过其实例获得Spinrg容器中的Bean对象
      2. ApplicationContext的实现类
          1. ClasspathXmlApplicationContext 它是从类的根路径下加载配置文件 推荐使用这种
          2. FileSystemXmlApplicationContext 它是从磁盘路径上加载配置文件，配置文件可以在磁盘的任意位置
          3. AnnotationConfigApplicationContext 当使用注解配置容器对象时，需要使用此类创建Spring容器。它用来读取注解
   10. getBean()方法
       1. 传递String通过id获得对象，需要强制转换
       2. 传递字节码文件获得对象
       3. 但通过1可以获得多个创建的bean，如果容器中声明了多个bean使用2会报错
6. Spring配置数据源
   1. 数据源（连接池）的作用
      1. 为提高程序性能而出现
      2. 实现实例化数据源，初始化部分连接资源
      3. 使用连接资源时从数据源中获取
      4. 使用完毕后将连接资源归还给数据源
      5. 常见的数据源（连接池）：DBCP、C3P0、BoneCP、Druid等
   2. 数据源的开发步骤
      1. 导入数据源的坐标和数据库驱动坐标
      2. 创建数据源对象
      3. 设置数据源的基本连接数据
      4. 归还数据源
   3. Spring配置数据源
      1. C3P0
   ```
    </dependency>
        <dependency>
            <groupId>c3p0</groupId>
            <artifactId>c3p0</artifactId>
            <version>0.9.1.2</version>
        </dependency>
    <dependency>
         ComboPooledDataSource comboPooledDataSource=new ComboPooledDataSource();
         comboPooledDataSource.setDriverClass("com.mysql.cj.jdbc.Driver");
         comboPooledDataSource.setJdbcUrl("jdbc:mysql://localhost:3306/test");
         comboPooledDataSource.setUser("root");
         comboPooledDataSource.setPassword("********");
         Connection connection=comboPooledDataSource.getConnection();
         System.out.println(connection);
         connection.close();
   ```
      2. Druid
      3. 配置文件的抽取
   ```
         //配置文件内容
         jdbc.driver=com.mysql.cj.jdbc.Driver
         jdbc.url=jdbc:mysql:///test
         jdbc.username=root
         jdbc.password=********

         ResourceBundle resourceBundle=ResourceBundle.getBundle("jdbc");
         String driver=resourceBundle.getString("jdbc.driver");
         String url=resourceBundle.getString("jdbc.url");
         String username=resourceBundle.getString("jdbc.username");
         String password=resourceBundle.getString("jdbc.password");
         ComboPooledDataSource comboPooledDataSource=new ComboPooledDataSource();
         comboPooledDataSource.setDriverClass(driver);
         comboPooledDataSource.setJdbcUrl(url);
         comboPooledDataSource.setUser(username);
         comboPooledDataSource.setPassword(password);
         Connection connection=comboPooledDataSource.getConnection();
         System.out.println(connection);
         connection.close();
   ```
      4. 既然上述操作就是创建一个类并且改变其中的属性值，不妨让Spring帮助我们创建和管理Bean，这样我们就可以将属性依赖注入配置文件完成解耦
   ```
    <context:property-placeholder location="jdbc.properties"/>
    <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="driverClass" value="${jdbc.driver}"/>
        <property name="jdbcUrl" value="${jdbc.url}"/>
        <property name="user" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
    </bean>
   ```
7. Spring注解开发
   1. Spring原始注解
      1. Spring是轻代码而重配置的框架，配置比较繁重，影响开发效率，所以注解开发是一种趋势，注解代替xml配置文件可以简化配置，提高开发效率
      2. Spring原始注解主要是替代Bean的配置
         1. @Component 使用在类上用于实例化Bean
         2. @Controller 使用在web层类上用于实例化Bean（同1功能一样，拥有语义）
         3. @Service 使用在service层类上用于实例化Bean（同1功能一样，拥有语义）
         4. @Repository 使用在dao层类上用于实例化Bean（同1功能一样，拥有语义）
         5. @Autowired 使用在字段上用于根据类型依赖注入（用于依赖注入）
         6. @Qualifier 结合@Autowired一起使用用于根据名称进行依赖注入（用于依赖注入）
         7. @Resource 相当于@Autowired+@Qualifier，按照名称进行注入（用于依赖注入）
         8. @Value 注入普通属性
         9. @Scope 标注Bean的作用范围
         10. @PostConstruct 使用在方法上标注该方法是Bean的初始化方法
         11. @PreDestroy 使用在方法上标注该方法是Bean的销毁方法
      3. 注意使用注解进行开发时，需要在applicationContext.xml中配置组建扫描，作用是指定哪个包及其包下的Bean需要进行扫描以便识别使用注解配置的类、字段和方法
   ```
    <context:component-scan base-package="com.shzu"/>
   ```   
      4. 原始注解无法对非自定义Bean起作用
   2. Spring新注解
      1. @Configuration 用于指定当前类是一个Spring配置类，当创建容器是会从该类上加载注解
      2. @ComponentScan 用于指定Spring在初始化容器时要扫描的包，作用和在Spring的xml位置文件中的扫描包一样
      3. @Bean 使用在方法上，标注将该方法的返回值存储到Spring容器中
      4. @PropertySource 用于加载.properties文件中的配置
      5. @Import 用于导入其他配置类
8. Spring整合Junit
   1. 解决方案
      1. 让SpringJunti负责创建Spring容器，但是需要将配置文件的名称告诉它
      2. 将需要进行测试Bean在测试类中注入
   2. Spring继承Junit步骤
      1. 导入Spring继承Junit的坐标
   ```
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>5.0.5.RELEASE</version>
   ```
      2. 使用@Runwith注解替换原来的运行期
      3. 使用@ContextConfiguration指定配置文件或配置类
      4. 使用@Autowired注入需要测试的对象
      5. 创建测试方法进行测试
   ```
      @RunWith(SpringJUnit4ClassRunner.class)
      @ContextConfiguration("classpath:applicationContext2.xml")//数组
      //@ContextConfiguration(classes = {SpringConfiguration.class})
      public class testSpringJunit {
         @Autowired
         private UserService2 userService2;
         @Test
         public void test(){
            userService2.save();
         }
      }
   ```
      6. 注意导包问题
9. Spring与Web环境集成
   1. 使得Spring的应用上下文只创建一次可以使用监听器
   2. 在Web项目中，可以使用ServletContextListener监听Web应用的启动，我们可以在Web应用启动时，就加载Spring的配置文件，创建应用上下文对象ApplicationContext，在将其存储到最大的域servletContext域中，这样就可以在任意位置从域中获得应用上下文ApplicationContext对象了
   ```
   <!--全局初始化参数-->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>applicationContext2.xml</param-value>
    </context-param>
   ```
   3. Spring提供获取应用上下文的工具
   ```
   <!-- web.xml配置 -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext2.xml</param-value>
    </context-param>
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
   ```
10. SpringJdbcTemplate
   1.  概述
      1. Jdbc Template是Spring框架中提供的一个对象，是对原始繁琐的JDBC API对象的简单封装。
   2. 快速入门 
      ```
      <dependency>
         <groupId>org.springframework</groupId>
         <artifactId>spring-jdbc</artifactId>
         <version>5.0.8.RELEASE</version>
      </dependency>
      <dependency>
         <groupId>org.springframework</groupId>
         <artifactId>spring-tx</artifactId>
         <version>5.0.8.RELEASE</version>
      </dependency>
      ```
      ```
      <context:property-placeholder location="classpath:c3p0.properties"/>
      <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
         <property name="driverClass" value="${jdbc.driver}"/>
         <property name="jdbcUrl" value="${jdbc.url}"/>
         <property name="user" value="${jdbc.username}"/>
         <property name="password" value="${jdbc.password}"/>
      </bean>
      <bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">
         <property name="dataSource" ref="dataSource"/>
      </bean>
      ```
      ```
      jdbc.driver=com.mysql.cj.jdbc.Driver
      jdbc.url=jdbc:mysql:///test
      jdbc.username=root
      jdbc.password=l3318668
      ```
      ```
      @RunWith(SpringJUnit4ClassRunner.class)
      @ContextConfiguration("classpath:applicationContext.xml")//数组
      public class testJDBC {
         @Autowired
         JdbcTemplate jdbcTemplate;
         @Test
         public void test1(){
            jdbcTemplate.update("insert into account values (?,?)","jack",8000);
         }
      }
      ```
      ```
      List<Account> query = jdbcTemplate.query("select * from account",new BeanPropertyRowMapper<Account>(Account.class));
      System.out.println(query);
      Account tom = jdbcTemplate.queryForObject("select * from account where name=?", new BeanPropertyRowMapper<Account>(Account.class), "tom");
      System.out.println(tom);
      Long aLong = jdbcTemplate.queryForObject("select count(*) from account", long.class);
      System.out.println(aLong);
      ```
 11. Spring的AOP
    1. 简介
        1. AOP为Aspect Oriented Programming的缩写，意思为面向切面编程，是通过预编译方式和运行期动态代理实现程序功能的统一维护的一种技术
        2. AOP是OOP的延续，是软件开发中的一个热点，也是Spring框架中的一个重要内容，是函数式编程的一种衍生范型，利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的耦合度降低，提高程序的可重用性，同时提高了开发的效率
    2. AOP的作用及其有事
        1. 在程序运行期间，在不修改源码的情况下对方法进行功能增强
        2. 减少重复代码，提高开发效率，并且便于维护
    3. AOP的底层实现
        1. 实际上，AOP的底层是通过Spring提供的动态代理技术实现的。在运行期间，Spring通过动态代理技术动态的生成代理对象，代理对象方法执行时进行增强功能的介入，在去调用目标对象的方法，从而完成功能的增强
    4. 常用的动态代理技术
        1. JDK代理 基于接口的动态代理技术
        2. cglib代理 基于父类的动态代理技术
        3. java动态代理机制中有两个重要的类和接口InvocationHandler（接口）和Proxy（类），这一个类Proxy和接口InvocationHandler是我们实现动态代理的核心
    5. AOP相关概念
        1. Target（目标对象）：代理的目标对象
        2. Proxy（代理）：一个类被AOP织入增强后，就产生一个结果代理类
        3. Joinpoint（连接点）：所谓连接点是指那些被拦截到的点。在Spring中，这些点指的是方法，因为Spring只支持方法类型的连接点
        4. Pointcut（切入点）：所谓切入点是知我们要对那些JoinPoint进行拦截的定义
        5. Advice（通知/增强）：所谓通知是指拦截到Joinpoint之后所要做的事情就是通知
        6. Aspect（切面）：是切入点和通知（引介）的结合
        7. Weaving（织入）：是指把增强应用到目标对象来创建新的代理对象的过程。Spring采用动态代理织入，而AspectJ采用编译器织入和类装载期织入
    6. AOP开发明确的事项
        1. 需要编写的内容
            1. 编写核心业务代码（目标类的目标方法）
            2. 编写切面类，切面类中有通知（增强功能方法）
            3. 在配置文件中，配置织入关系，即将那些通知与那些连接点进行结合
        2. AOP技术实现的内容
            Spring框架监控切入点方法的执行。一旦监控到切入点方法被运行，使用代理机制，动态创建目标对象的代理机制，根据通知类别，在代理对象的对应位置，将通知对应的功能织入，完成完整的代码逻辑运行
        3. AOP底层使用哪种代理方式
            在Spring中，框架会根据目标类是否实现了接口来决定采用哪种动态代理的方式
12. 基于XML的AOP开发
    1. 快速入门
        1. 导入AOP相关坐标
        ```
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.8.4</version>
        </dependency>
        ```
        2. 创建目标接口和目标类（内部有切点）
        3. 创建切面类（内部有增强方法）
        4. 将目标类和切面类的对象创建权交给Spring
        5. 在applicationContext.xml织入关系
        6. 测试代码
        ```
        public class MyAspect {
            public void before(){
                System.out.println("before...");
            }
        }
        ```
        ```
        public class Target implements TargetInterface{
            public void save() {
                System.out.println("run....");
            }
        }
        ```
        ```
        public class Target implements TargetInterface{
            public void save() {
                System.out.println("run....");
            }
        }
        ```
        ```
        <bean id="target" class="com.shzu.Target"></bean>
        <bean id="myAspect" class="com.shzu.MyAspect"></bean>
        <!-- 配置织入，告诉Spring框架哪些方法（切点）需要进行哪些增强（前置、后置....） -->
        <aop:config>
            <!--声明切面-->
            <aop:aspect ref="myAspect">
                <!--切面：切点+通知-->
                <aop:before method="before" pointcut="execution(public void com.shzu.Target.save())"></aop:before>
            </aop:aspect>
        </aop:config>
        ```
        ```
        @RunWith(SpringJUnit4ClassRunner.class)
        @ContextConfiguration("classpath:applicationContext.xml")
        public class TestAop {
            @Autowired
            private TargetInterface target;
            @Test
            public void testAop(){
                target.save();
            }
        }
        ```
    2. 切点表达式
        1. execution([修饰符] 返回值类型 包名.类名.方法名(参数))
        2. 访问修饰符可省略
        3. 返回值类型、包名、类名、方法名可以使用*代表任意
        4. 包名与类名之间一个点.代表当前包下的类，两个点..表示当前包及其子包下的类
        5. 参数列表可以使用两个点..表示任意个数，任意类型的参数列表
    3. 通知类型
        1. <aop:通知类型 method="切面类中的方法名" pointcut="切点表达式"></aop:通知类型>
        2. aop:before 前置通知 指定增强的方法在切入点方法之前执行
        3. aop:after-returning 后置通知 指定增强的方法在切入点方法之后都执行
        4. aop:around 环绕通知 指定增强的方法在切入点方法之前和之后都执行
        5. aop:throwing 异常抛出通知 指定方法出现异常时通知
        6. aop:after 最终通知 无论增强方式执行是否有异常都会执行
        7. 参数ProceedingJoinPoint类型连接点该类型的proceed方法就是切点方法
    4. 切点表达式的抽取
        ```
            <aop:config>
                <!--声明切面-->
                <aop:aspect ref="myAspect">
                    <aop:pointcut id="myPointcut" expression="execution(public void com.shzu.Target.save())"/>
                    <!--切面：切点+通知-->
        <!--            <aop:before method="before" pointcut="execution(public void com.shzu.Target.save())"></aop:before>-->
        <!--            <aop:around method="around" pointcut="execution(public void com.shzu.Target.save())"></aop:around>-->
        <!--            <aop:after method="after" pointcut="execution(public void com.shzu.Target.save())"></aop:after>-->
                    <aop:around method="around" pointcut-ref="myPointcut"/>
                </aop:aspect>
            </aop:config>
        ```
13. 基于注解的AOP开发
    1. 快速入门
        1. 创建目标接口和目标类（内部有切点）
        2. 创建切面类（内部有增强方法）
        3. 将目标类和切面列的对象创建权交给Spring
        4. 在切面类中使用注解配置织入关系
        5. 在配置文件中开启组建扫描和AOP的自动代理
        6. 测试
        ```
        <aop:aspectj-autoproxy/>

        @Component("myAspect")
        @Aspect//标注当前类是切面
        public class MyAspect {
            @Before("execution(* com.shzu.Target.*(..))")
            public void before(){
                System.out.println("before");
            }
            @Around("execution(* com.shzu.Target.*(..))")
            public void around(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
                System.out.println("before...");
                proceedingJoinPoint.proceed();
                System.out.println("after...");
            }
        }
        ```
    2. 通知类型
        1. @Before 前置通知
        2. @AfterReturning 后置通知
        3. @Around 环绕通知
        4. @AfterThrowing 异常抛出通知
        5. @After 最终通知
    3. 切点表达式抽取
    ```
    @Pointcut("execution(* com.shzu.Target.*(..))")
    public void pointcut(){}
    @AfterReturning("pointcut()")
    public void after(){
        System.out.println("after");
    }
    ```
14. Spring声明式事务控制
    1. 编程式事务控制相关对象
        1. PlatformTransactionManager 平台事务管理器
            1. PlatformTransactionManager接口是Spring的事务管理器，他里面提供了我们常用的操作事务的方法
            2. TransactionStatus getTransaction(TransactionDefination defination) 获取事务的状态信息
            3. void commit(TransactionStatus status) 提交事务
            4. void roolback(TransactionStatus status) 回滚事务
        2. TransactionDefinition 事务定义对象
            1. int getIsolationLevel() 获得事务的隔离级别
                1. ISOLATION_DEFAULT 数据库默认
                2. ISOLATION_READ_UNCOMMITTED
                3. ISOLATION_READ_COMMITTED
                4. ISOLATION_REPEATABLE_READ
                5. ISOLATION_SERIALIZABLE
            2. int getPropogationBehavior() 获得事务的传播行为
                1. 解决业务方法在调用业务方法时的传播行为
                2. REQUIRED 如果当前没有事务就新建一个事务，如果已经存在一个事务中，加入到这个事物中。一般的选择（默认值）
                3. SUPPORTS 支持当前事务，如果当前没有事务，就以非事务方式执行（没有事务）
                4. MANDATORY 使用当前的事务，如果当前没有事务，就抛出异常
                5. REQUERS_NEW 新建事务，如果当前在事务中，把当前事务挂起
                6. NOT_SUPPORTED 以非事务方式执行操作，如果当前存在事务，就把当前事务挂起
                7. NEVER 以非事务方式运行，如果当前存在事务，抛出异常
                8. NESTED 如果当前存在事务，则在嵌套事务内执行。如果当前没有事务，则执行REQUIRED类似的操作
            3. int getTimeout() 获得超时时间
                超时时间 默认值是-1，没有超时先知，如果有，以s为单位进行设置
            4. boolean isReadOnly() 是否只读
                是否只读 建议查询时设置只读
        3. TransactionStatus 事务状态对象
            1. TransactionStatus接口提供的是事务具体的运行状态
            2. boolean hasSavepoint() 是否存储回滚点
            3. boolean isCompletde() 事务是否完成
            4. boolean isNewTransaction() 是否是新事务
            5. boolean isRollbackOnly() 事务是否回滚
    2. 基于XML的声明式事务控制
        1. Spring的声明式事务控制就是采用声明的方式来处理事务
        2. 作用
            事务管理不侵入开发组件。具体来说，业务逻辑对象就不会意识到正在事务管理之中，事实上也应该如此，因为事务管理属于系统层面的服务，而不是业务逻辑的一部分，如果想要改变事物管理策划的话，也只需在定义文件中重新配置即可
        3. 实现
            1. 明确
                1. 谁是切点
                2. 谁是通知
                3. 配置切面
