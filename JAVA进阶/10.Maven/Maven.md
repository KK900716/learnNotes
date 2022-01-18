1.简介
    a.Apache Maven是专门用于管理和构建Java项目的工具，是一个项目管理和构建工具，它基于项目对象模型（POM）的概念，通过一小段描述信息来管理项目的构建、报告和文档
    b.功能
        提供一套标准化的项目结构
        提供一套标准化的构建流程（编译、测试、打包、发布）
        提供一套依赖管理机制
    c.标准化的项目结构
2.常见的项目构建工具
    Maven Gradle Ant SBT None
3.仓库
    a.本地仓库
    b.中央仓库
        由Maven团队维护的全球唯一的仓库
    c.远程仓库
        私服，一般有公司团队搭建的私有仓库
    d.先查找本地仓库后查询远程仓库，最后查询中央仓库
4.maven常用命令
    1.compile 编译
    2.clean 清理
    3.test 测试
    4.package 打包
    5.install 安装
5.maven生命周期
    a.maven构建项目生命周期描述的是一次构建过程经历了多少个事件
    b.maven对项目构建的生命周期划分为三套
        （1）clean清理工作
        （2）default核心工作
        （3）site产生报告，发布站点
6.IDEA配置Maven
    a.IDEA自带有maven插件，我们一般使用自己下载的maven进行覆写
    b.maven坐标详解
```
            <groupId>组织名称</groupId>
            <artifactId>模块名称</artifactId>
            <version>版本</version>
```
7.导入项目文件
    可以用pom.xml导入maven工程
8.依赖管理
```
    <dependencies>
        <dependency>
            <groupId>组织名称</groupId>
            <artifactId>模块名称</artifactId>
            <version>版本</version>
            <!-- 通过设置坐标的依赖范围，可以设置对应jar包的作用范围：编译环境、测试环境、运行环境 -->
            <!-- compile test provided runtime system improt -->
            <!-- 默认为compile -->
            <scope>test</scope>
        </dependency>
    </dependencies>
```