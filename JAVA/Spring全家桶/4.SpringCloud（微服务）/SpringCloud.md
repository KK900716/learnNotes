1. 认识微服务
    1. 单体架构缺点
        1. 耦合度高
    2. 分布式架构优点
        1. 降低服务耦合
        2. 有利于服务升级拓展
    3. 分布式架构缺点
        1. 服务拆分粒度
        2. 服务集群地址维护
        3. 服务之间如何实现远程调用
        4. 服务健康状态如何感知
    4. 微服务：是一种经过良好架构设计的分布式架构方案
        1. 单一职责：微服务拆分粒度小，每一个服务都对应唯一的业务能力，做到单一职责，避免重复开发
        2. 面向服务：微服务对外暴露业务接口
        3. 自治：团队独立、技术独立、数据独立、部署独立
        4. 隔离性强：服务调用做好隔离、容错、降级，避免出现级联问题
    5. 常见的微服务架构SpringCloud、Dubbo
    6. 结构
        1. 服务网关、服务集群、注册中心、配置中心
2. Eureka注册中心
     1. 依赖
     ```
        <spring-cloud.version>Hoxton.SR10</spring-cloud.version>

        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependecies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
     ```