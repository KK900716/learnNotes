[TOC]

------



## Docker简介

1. 将应用和所依赖的函数库一起打包，可以跨系统使用
2. 镜像和容器
    1. 镜像（image）只读
        1. Docker将应用程序及其所需的依赖、函数库、环境、配置等文件打包在一起，成为镜像
    2. 容器（Container）
        1. 镜像中的应用程序运行后形成的进行就是容器，只是Docker会给容器做隔离，对外不可见
    3. DockerHub镜像托管平台，统称为Docker Registry
    4. Docker是一个C/S架构的程序
        1. 服务端server Docker守护进程，负责处理Docker指令，管理镜像、容器等
        2. 客户端client 通过命令或RestAPI想Docker服务端发送指令，可以在本地或向服务端发送指令
            1. docker build
            2. docker pull
            3. docker run

## 安装启动Docker

1. 通过命令启动docker
   1. systemctl start docker 启动
   2. systemctl stop docker 停止
   3. systemctl restart docker 重启
2. 配置镜像

## Docker基本操作

1. 镜像名称命名规则[repository]:[tag]

2. 镜像基本操作

   1. docker build 构建镜像
   2. docker images 查看镜像
   3. docker rmi 删除镜像
   4. docker push 推送镜像
   5. docker pull 拉去镜像
   6. docker save 保存镜像为一个压缩包
   7. docker load 加载压缩包为镜像
   8. docker [选项] --help 查看帮助文档

3. 容器相关命令

   1. docker run 运行
      1. 例如 docker run --name containerName -p 80:80 -d nginx
      2. --name 名字
      3. -p 将宿主机端口与容器端口映射
      4. -d 后台运行
      5. 镜像名称
   2. docker pause 暂停
   3. docker unpause 继续
   4. docker stop 停止
   5. docker start 开始
   6. docker logs 查看容器运行日志
   7. docker ps 查看所有运行的容器
   8. docker exec 进入容器执行命令
   9. docker rm 删除指定容器

4. 其他命令

   1. docker exec -it mn（容器名） bash 进入容器内部执行命令（不推荐）
      1. it 进入容器创建标准输入、输出终端
      2. linux 终端交互命令

5. 常用启动命令

   1. mysql -e mysql的密码（环境变量）

   ```console
   docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
   ```

   2. redis

   ```console
   docker run --name myredis1 -p 6379:6379 -d redis-server --appendonly yse
   ```
   3. a

6. 数据卷 volume 是一个虚拟目录，指向宿主机文件系统中的某个目录

   1. 数据卷操作语法 docker volume [COMMAND]
      1. create 创建一个volume
      2. inspect 显示一个或多个volume的信息
      3. ls 列出所有volume
      4. prune 删除未使用的volume
      5. rm 删除一个或多个指定的volume
   2. 挂载数据卷
      1. 通过-v参数挂载
      2. -v 数据卷名称/宿主机目录/宿主机文件:容器内目录/容器内文件

## 自定义镜像

1. 镜像结构
   1. 基础镜像（BaseImage） 应用依赖的西戎函数库、环境、配置、文件等
   2. 入口（Entrypoint） 镜像运行入口，一般是程序启动的脚本和参数
   3. 层（Layer）在BaseImage基础上添加安装包、依赖、配置等，每次操作都形成新的一层
2. Dockerfile
   1. FROM 指定基础镜像 FROM centos:6
   2. EVN 设置环境变量，可在后面指令使用 ENV key value
   3. COPY 拷贝本地文件到镜像的指定目录 COPY ./mysql-5.7.rpm /tmp
   4. RUN 执行LINUX的shell命令，一般是安装过程的命令 RUN yum install gcc
   5. EXPOSE 指定容器运行时监听的端口，是给惊险使用者看的 EXPOSE 8080
   6. ENTRYPOINT 镜像中应用的启动命令，容器运行时调用 ENTRYPOINT java -jar xx.jar
3. docker build -t javaweb:1.0 .

## Docker Compose

1. Docker Compose 可以基于Compose文件帮我们快速的部署分布式应用，无需手动一个个创建和运行容器