1.AJAX服务端作用
    a.使用HTML+AJAX替换JSP
    b.异步交互
2.快速入门
    a.编写AjaxServlet，并使用response输出字符串
    b.创建XMLHttpRequest对象，用于和服务器交换数据
    c.向服务器发送请求
    d.获取服务器相应数据
3.Axios异步框架
4.JSON和java对象转换
```
    <dependency>
      <groupId>com.alibaba</groupId>
      <artifactId>fastjson</artifactId>
      <version>1.2.62</version>
    </dependency>
```
```
        Object obj=new Object();
        String jsonStr= JSON.toJSONString(obj);
        Object obj2= JSON.parseObject(jsonStr,Object.class);
```