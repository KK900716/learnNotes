1.简介
    a.Servlet（Sserver Applet），全称Java Servlet，是用java编写的服务器端程序。其主要功能在于交互式地浏览和修改数据，生成动态Web内容。
    b.狭义的Servlet是指Java语言实现的一个接口，广义的Servlet理解为后者
    c.Servlet是JavaWeb的核心程序，是Java Web三大组件之一（Servlet Filter Listener）
    d.在HTTP请求过程中会把请求的参数存放在请求行的URL中，或者是请求体重，这个参数需要服务器来接受解析并处理，Servlet就是用来处理这个过程的
2.作用
    a.获取接受客户端发送来的请求
    b.处理请求
    c.将处理的结果通过响应发送到客户端
3.Servlet 3.0版本之后不再依赖web.xml描述文件，可以用注解的方式
4.servlet开发动态资源的技术
    a.demo
        （1）导入依赖
```
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>3.1.0</version>
      <scope>provided</scope>
    </dependency>
```
        （2）创建servlet实现接口并覆写方法
        （3）配置访问路径，注解方式@WebServlet("/demo")
5.Servlet的生命周期
    a.加载和实例化：默认情况下，当Servlet第一次被访问时，由容器创建Servlet对象
        @WebServlet(urlPatterns="/demo",loadOnStartup=1)
            负整数：第一次被访问时创建Servlet对象
            0或正整数：服务器启东市创建Servlet对象，数字越小优先级越高
    b.初始化：在Servlet实例化之后，容器将调用Servlet的init()方法初始化这个对象，完成一些如加载配置文件、创建连接等初始化的工作。该方法只调用一次
    c.请求处理：每次请求Servlet时，Servlet容器都会调用Servlet的service()方法对请求进行处理
    d.服务终止：当需要释放内存或者容器关闭时，容器会调用Servlet实例的destroy()方法完成资源的释放。在destroy()方法调用之后，容器会释放这个Servlet实例，该实例随后会被Java的垃圾收集器所回收
6.Servlet体系结构
    Servlet接口 -> GenericServlet抽象类 -> HttpServlet 对 http协议封装的Servlet实现类
7.urlPatterns
    a.一个Servlet可以配置多个urlPattern
    b.urlPattern配置规则
        （1）精确匹配
            /user/select匹配要完全一致
        （2）目录匹配
            /user/*
        （3）扩展名匹配
            *.do
        （4）任意匹配
            /或/*，/*优先级更高
            /会覆盖掉tomcat的内置的servlet，tomcat内置的servlet中配置了静态资源，故不建议使用
        优先级：精确匹配>目录匹配>扩展名匹配>任意匹配
8.xml方式配置servlet
```
  <servlet>
    <servlet-name>demo</servlet-name>
    <servlet-class>com.Servletdemo1</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>demo</servlet-name>
    <url-pattern>/demoa</url-pattern>
  </servlet-mapping>
```
9.Requset
    a.Request继承体系
        ServletRequest java提供的请求对象根接口
        HttpServletRequest java提供的对Http协议封装的请求对象接口
        RequestFacade Tomcat定义的实现类
        tomcat需要解析请求数据，封装为request对象，并且创建request对象传递到service方法中
    b.Request获取请求数据
        （1）获取请求行
```
        System.out.println("接收到get请求：");
        System.out.println("请求方式:"+request.getMethod());
        System.out.println("虚拟目录（项目访问路径）："+request.getContextPath());
        System.out.println("URL（统一资源定位符）："+request.getRequestURL());
        System.out.println("URI（统一资源标识符）："+request.getRequestURI());
        System.out.println("获取请求参数（get方式）："+request.getQueryString());
```
        （2）获取请求头
        String getHeader(String name)根据请求头名称，获取值
```
        Enumeration<String> headerNames=request.getHeaderNames();
        while(headerNames.hasMoreElements()){
            String s=headerNames.nextElement();
            System.out.println(s+":"+request.getHeader(s));
        }
```
        （3）获取请求体
        ServletInputStream getInputStream()获取字节输入刘
        BufferedReader getReader()获取字符输入流
    c.Request请求转发