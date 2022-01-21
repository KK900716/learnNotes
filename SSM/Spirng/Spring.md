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