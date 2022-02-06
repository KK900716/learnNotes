    // 1.引入express
    const express=require('express');
    // 2.创建应用对象
    const app=express();
        // 设置响应头，设置允许跨域
    app.all('*', function(req, res, next) {
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "X-Requested-With");
        res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
        res.header("X-Powered-By",' 3.2.1')
        res.header("Content-Type", "application/json;charset=utf-8");
        next();
    });
    // 3.创建路由规则
    app.get('/serve',(request,response)=>{
        response.send('hello ajax')
    })
    // 4.监听端口启动服务
    app.listen(8000,()=>{
        console.log("服务器已经启动，8000端口监听中....");
    })