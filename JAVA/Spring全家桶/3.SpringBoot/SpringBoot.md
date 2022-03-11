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
        1. Representational State Transfer，表现形式状态转换
        2. 优点
            1. 隐藏资源的访问行为，无法通过地址得知对资源时何种操作
            2. 书写简化
        3. 查询用get请求，添加用post请求，修改用put请求，删除用delete请求
        4. 访问资源用复数形式
        5. 根据REST风格对资源进行访问成为RESTful
        6. 接受参数的选择
            1. @RequestBody 用于接受json数据
            2. @RequestParam 用于接受url地址传参或表单传参
            3. @PathVariable 用于接受路径参数
        7. 应用
            1. 后期开发中，发送请求参数超过1个时，以json格式为主，@RequsetBody应用较广
            2. 如果发送非json格式数据，选应用@RequestParam接受请求参数
            3. 采用RESTful进行开发，当参数数量较少时，例如1个，可以采用@PathVariable接受请求路径变量，通常用id传值
        8. @RestController，结合了@ResponseBody和@Controller
        9. @RequestMapping可以拆分成@Getmapping、@Postmapping，@Putmapping、@Deletmapping
2. 基础配置
    1. application.properties配置文件
    2. 属性
    ```
    #修改服务器端口配置
    server.port=80
    #修改banner
    spring.main.banner-mode=off
    #修改的banner为图片
    #spring.banner.image.location=
    #日志配置
    logging.level.root=info
    #.......
    ```
    3. 可以到spring官网查询文档
    4. boot的很多配置是默认的
    5. boot还支持yml格式（主流）和yaml格式做为配置文件
    ```
    server:
     port: 80
    spring:
     main:
      banner-mode: off
    ```
    6. 配置文件优先级properties>yml>yaml
    7. yaml格式优势
        1. 重数据轻格式
        2. 大小写敏感
        3. 多层级描述
        4. 缩进表示层级（只允许使用空格）
        5. 属性值前有空格
        6. #表示注释
        7. 多个数据使用- 描述
        8. 可以写成数组格式来缩略7
        9. 有空格的字符串需要打引号
    8. spring框架使用yaml
        1. 可以直接进行注入到字符串
        2. 引用方式${}
    9. spring封装yaml数据
        1. 创建一个数据类与yaml文件对应
        2. @Configuration注解可以读取指定值的yaml部分数据
3. 整合SSM
    1. 整合JUnit 注意如果当前测试类在引导类的包或者子包下才能正常运行，否则需要在注解中加classes=引导类属性
    2. 整合Mybatis
    3. 整合Mybatis Plus 可能需要自己导入坐标
    4. 整合Druid坐标
    5. lombok，简化pojo实体类开发
        ```
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        ```
        1. @Data增加除构造函数外的全部方法
        2. @Constructor
    6. static文件内就是web的静态资源
4. 整合redis
    1. 配置
    ```
    <!--通用池-->
            <dependency>
                <groupId>org.apache.commons</groupId>
                <artifactId>commons-pool2</artifactId>
            </dependency>
    <!--        通用mapper-->
            <dependency>
                <groupId>tk.mybatis</groupId>
                <artifactId>mapper-spring-boot-starter</artifactId>
                <version>2.1.5</version>
            </dependency>
    ```
    2. 使用
    