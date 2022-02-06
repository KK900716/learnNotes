    // 1.引入express
    const express=require('express');
    // 2.创建应用对象
    const app=express();
        // 设置响应头，设置允许跨域
    app.all('*', function(req, res, next) {//all是可以接受任意类型请求
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "*");//所有类型头信息都可以接收
        // res.header("Access-Control-Allow-Headers", "X-Requested-With");
        res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
        res.header("X-Powered-By",' 3.2.1')
        res.header("Content-Type", "application/json;charset=utf-8");
        next();
    });
    // 3.创建路由规则
    app.get('/serve',(request,response)=>{
        response.send('hello ajax')
        console.log("收到get请求");
    })
    app.post('/serve',(request,response)=>{
        response.send('hello ajax')
        console.log("收到post请求");
    })
    // 4.监听端口启动服务
    app.listen(8000,()=>{
        console.log("服务器已经启动，8000端口监听中....");
    })