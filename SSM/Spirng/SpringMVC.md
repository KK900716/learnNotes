1. 简介
    1. SpringMVC是一种基于Java的实现MVC设计模型的请求驱动类型的轻量级Web框架，属于SpringFrameWork的后续产品，已经融合在Spring Web Flow中
    2. SpringMVC已经成为目前最主流的MVC框架之一，并且随着Spring3.0的发布，全面超越Struts2，成为最优秀的MVC框架。它通过一套注解，让一个简单的Java类成为处理请求的控制器，而无需事先任何借口。同时它还支持RESTful编程风格的要求
2. 快速入门
    1. 导入SpringMvc相关坐标
    ```
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>5.0.8.RELEASE</version>
    </dependency>
    ```
    2. 配置SpringMvc核心控制器DispathcreServlet
    ```
    <context:component-scan base-package="com.shzu.controller"/>
    ```
    ```
    <servlet>
    <servlet-name>DispatcherServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring-mvc.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
    <servlet-name>DispatcherServlet</servlet-name>
    <url-pattern>/*</url-pattern>
    </servlet-mapping>
    ```
    3. 创建Controller类和视图页面
    ```
    @Controller
    public class UserController {

        @RequestMapping("/quick")
        public String save(){
            System.out.println("Controller sav running");
            return "h1.html";
        }
    }
    ```
    4. 使用注解配置Controller类中业务方法的映射地址
    5. 配置SpringMVC核心文件spring-mvc.xml
    6. 客户端发起请求测试
    ```
    <dependencies>
  <dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
  </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>5.0.8.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-web</artifactId>
      <version>5.0.8.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-context</artifactId>
      <version>5.0.8.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>RELEASE</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>5.0.8.RELEASE</version>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>RELEASE</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>javax.servlet.jsp-api</artifactId>
      <version>2.2.1</version>
      <scope>provided</scope>
    </dependency>
  </dependencies>
    ```
    ```
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml</param-value>
    </context-param>
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    <servlet>
        <servlet-name>DispatcherServlet</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring-mvc.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
    <servlet-mapping>
        <servlet-name>DispatcherServlet</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
    ```
    ```
    @Controller
    public class UserController {

        @RequestMapping("/quick")
        public String save(){
            System.out.println("Controller save running");
            return "abc.jsp";
        }
    }
    ```
3. SpringMVC的执行流程
    1. 前端控制器DispatcherServlet
        1. 处理器映射器
            1. 请求查询Handler
            2. 返回处理器直行链HandlerExecutionChain
        2. 处理器适配器HandlerAdaptor
            1. 请求执行Handler
            2. HandlerAdaptor请求处理器Handler
            3. 原路返回响应ModelAndView
        3. 视图解析器ViewResolver
            1. 请求视图解析器
            2. 返回视图View对象
    2. 渲染视图返回视图页面jsp
    3. SpringMVC注解解析
        1. @RequsetMapping 用于建立请求URL和处理请求方法之间的对应关系 可以由类上的注解和方法上的注解共同拼接URL
            1. 方法的返回值（字符串）即资源名，从当前路径下寻找，前面加/可以从全局路径下寻找
            2. method属性，限定访问方式，值可填枚举类型RequestMethod.POST
            3. params属性，用于限定请求参数条件，它支持简单的表达式，要请求参数的key和value必须和配置的一模一样
                例如：params={"accountName"} params={"moeny!100"}
4. SpringMVC的数据响应
    1. 页面跳转
        1. 直接返回字符串
            1. 此种方式会将返回的字符串与视图解析器的前后缀拼接后跳转
            2. 通过ModelAndView对象返回
            3. redirect: forward:
    2. 回写数据
        1. 直接返回字符串
            @ResponseBody 告知SpringMVC返回的字符串不是URL而是写入字符串
        2. 返回对象或集合
            1. 在SpringMVC的各个组件中，处理器映射器、处理器适配器、视图解析器成为SpringMVC的三大组件。
            ```
            <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>2.9.0</version>
            </dependency>
            <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.0</version>
            </dependency>
            <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-annotations</artifactId>
            <version>2.9.0</version>
            </dependency>
            <mvc:annotation-driven/>
            ObjectMapper objectMapper=new ObjectMapper();
            String s=objectMapper.writeValueAsString(map);
            ```
            2. 使用上述注解自动加载RequestMappingHandleerMapping和RequestMappingHandlerAdapter，可用在spring-mvc.xml未知文件中使用替代注解处理器和适配器的配置
            3. 同时使用上述注解默认底层就会继承jackson进行对象或集合的json格式字符串的转换
        