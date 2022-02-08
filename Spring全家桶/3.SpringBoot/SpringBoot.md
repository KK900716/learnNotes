1. 快速上手
    1. 简化Spring应用的初始搭建以及开发过程
    2. 可以直接使用idea中的向导联网进行创建
    3. 官网创建版https://start.spring.io/
    4. 阿里云版https://start.aliyun.com/
    5. 依赖和引导类（可供离线使用）
    ```
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.3</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    @SpringBootApplication
    public class DemoApplication {
        public static void main(String[] args) {
            SpringApplication.run(DemoApplication.class, args);
        }
    }
    ```
    6. idea中可以设置隐藏文件
    7. 解析
        1. parent
            1. 集成常用稳定包版本，不用输入版本号
            2. 所用常用坐标完全依赖boot版本
            3. 目的是减少依赖冲突
        2. starter
            1. 使用依赖传递
            2. 实现快速开发
            3. 目的是减少依赖配置
        3. 引导类
            1. 引导类运行的就是Spring的容器，即应用上下文
            2. 给引导类上加的注解@SpringBootApplication中就是Spring的配置类，该配置类默认扫描当前包及其子包
        4. 内嵌tomcat
            1. 可以将内嵌的tomcat排除掉使用其他服务器，例如jetty、undertow
    8. REST开发
        
2. 基础配置
3. 整合SSM