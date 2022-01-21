1.概念
    Listener表示监听器，是JavaWeb三大组件之一
2.监听器可以监听application、session、request三个对象的创建、销毁或者王其中添加修改删除属性时自动执行代码的功能组件
3.Listener分类：JavaWeb中提供了8个监听器
    a.SerlvetContext监听
        ServletContextListener 用于对ServletContext对象监听（创建、销毁）
        ServletContextAttributeListener 用于对ServletContext对象中的属性监听（增删改属性）
    b.Session监听
        HttpSessionListener 对Session对象的整体状态监听（创建、销毁）
        HttpSessionAttributeListener 对Session对象中的属性监听（增删改属性）
        HttpSessionBindingListener 监听Session对象的绑定和解除
        HttpSessionActivationListener 对Session数据的钝化和活化的监听
    c.Request监听
        ServletRequestListener 对Request对象进行监听（创建、销毁）
        ServletAttributeListener 对Request对象中属性的监听（增删改属性）
4.ServletContextListener使用
    a.定义类，实现ServletContextListener接口
    b.在雷伤添加@WebListener注解
        