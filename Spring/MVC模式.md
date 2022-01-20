1.简介
    a.MVC是一种分层开发的模式，其中
    b.M Model 业务模型，处理业务
    c.V View 视图 界面展示
    d.C Controller 控制器，处理骑牛，调用模型和视图
2.优点
    a.职责单一，互不影响
    b.有利于分工协作
    c.有利于组建重用
3.三层架构
    a.表现层
        接受请求，封装数据，调用业务逻辑层，响应数据
        包名一般为web/controller
        主流框架Spring MVC
    b.业务逻辑层
        对业务逻辑进行封装，组合数据访问层层中基本功能，形成复杂的业务逻辑功能
        包名一般为service
        主流框架Spring
    c.数据访问层（持久层）
        对数据库的CRUD的基本操作
        包名一般为dao/mapper
        主流框架Mybatis