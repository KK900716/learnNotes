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