1.概念
    a.Java Server Pages，java服务端页面
    b.一种动态的网页技术，其中既可以定义html、js、css等静态内容，还可以定义java代码的动态内容
    c.jsp=html+java
2.依赖
```
    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>jsp-api</artifactId>
      <version>2.2</version>
      <scope>provided</scope>
    </dependency>
```
```
<html>
<body>
<h2>Hello World!</h2>
<%
    System.out.println("hello jsp");
%>
</body>
</html>
```
3.原理
    a.jsp本质上就是servlet
4.jsp脚本
    a.<% %>内容会直接放到_jspService()方法中去
    b.<%= %>内容会放到out.print()zhong，作为out.print()的参数
    c.<%! %>内容会放到_jspService()之外，被类直接包含
5.jsp缺点
    a.书写麻烦
    b.阅读麻烦
    c.复杂度高
    d.占内存和磁盘
    e.调试困难
    f.不利于团队协作
6.jsp已经被淘汰