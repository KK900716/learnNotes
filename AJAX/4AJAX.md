1. Express框架
    1. npm init --yes
    2. npm i express
    ```
    // 1.引入express
    const express=require('express');
    // 2.创建应用对象
    const app=express();
    // 3.创建路由规则
    app.get('/',(request,response)=>{
        // 设置响应头，设置允许跨域
        response.header('Access-Control-Allow-Origin', '*')
        response.header('Access-Control-Allow-Headers', 'Authorization,X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method' )
        response.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PATCH, PUT, DELETE')
        response.header('Allow', 'GET, POST, PATCH, OPTIONS, PUT, DELETE')
        response.send('hello ajax')
    })
    // 4.监听端口启动服务
    app.listen(8000,()=>{
        console.log("服务器已经启动，8000端口监听中....");
    })
    ```
    3. node 脚本名 启动脚本
    4. 
    ```
        const btn=document.getElementsByTagName('button')[0];
        btn.onclick=function(){
            // 1.创建对象
            const xhr=new XMLHttpRequest();
            // 2.初始化 设置请求方法和url
            xhr.open('GET','http://127.0.0.1:8000/server',true);
            // 3.发送
            xhr.send()
            // 4.事件绑定 处理服务端返回的结果
            // readystate有5个值
            // 0开始 1open方法调用完毕 2send方法调用完毕 3服务端返回部分结果 4服务端返回所有结果
            xhr.onreadystatechange=function(){
                if(xhr.readyState===4&&xhr.status>=200&&xhr.status<200){
                    // 1.响应行
                    console.log(xhr.status);//状态码
                    console.log(xhr.statusText);//状态字符串
                    console.log(xhr.getAllResponseHeaders());//响应头
                    console.log(xhr.response);//响应体
                }else{
                    console.log('失败');
                }
            }
        }
    ```
    5. 设置url参数，get请求可以用?接参数方式发送参数
    6. post请求