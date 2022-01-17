1.简介
    a.Servlet（Sserver Applet），全称Java Servlet，是用java编写的服务器端程序。其主要功能在于交互式地浏览和修改数据，生成动态Web内容。
    b.狭义的Servlet是指Java语言实现的一个接口，广义的Servlet理解为后者
    c.Servlet是JavaWeb的核心程序，是Java Web三大组件之一（Servlet Filter Listener）
    d.在HTTP请求过程中会把请求的参数存放在请求行的URL中，或者是请求体重，这个参数需要服务器来接受解析并处理，Servlet就是用来处理这个过程的
2.作用
    a.获取接受客户端发送来的请求
    b.处理请求
    c.将处理的结果通过响应发送到客户端
3.Servlet 3.0版本之后不再依赖web.xml不输描述文件，可以用注解的方式