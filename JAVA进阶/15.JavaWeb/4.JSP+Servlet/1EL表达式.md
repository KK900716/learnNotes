1.简介
    a.EL表达式Expression Languange表达式，用于简化JSP页面内的java代码
    b.主要功能：获取数据
    c.语法${expression}获取域中存储的key为brands的数据
2.使用
    需要插入<%@page isELIgnored="false" %>
3.JavaWeb中的四大域对象
    a.page：当前页面有效
    b.request：当前请求有效
    c.session：当前会话有效
    d.application：当前应用有效
4.JSTL标签
    a.JSP标准标签库（Jsp Standarded Tag Library），使用标签取代JSP页面上的JAVA代码
    b.引入依赖
```
    <dependency>
      <groupId>jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>
    <dependency>
      <groupId>taglibs</groupId>
      <artifactId>standard</artifactId>
      <version>1.1.2</version>
    </dependency>
```
    c.引入标签
```
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

```
    d.使用标签
```
    <c:if test="true">
        <h1>true</h1>
    </c:if>
    <c:forEach items="" var="" varStatus="">
        <!-- varStatus是编号 -->
    </c:forEach>
    <c:foreEach begin="0" end="10" step="1" var="i"></c:foreEach>
```
