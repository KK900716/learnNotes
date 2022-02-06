    // 1.引入express
    const express=require('express');
    // 2.创建应用对象
    const app=express();
    // 3.创建路由规则
    app.get('/serve',(request,response)=>{
        // 响应一个页面
        response.sendFile(__dirname+'/index.html')
    })
    app.get('/data',(request,response)=>{
        // 响应一个页面
        const data={
            name:'abc'
        };
        let str=JSON.stringify(data);
        response.end(`handle(${str})`)
    })
    // 4.监听端口启动服务
    app.listen(9000,()=>{
        console.log("服务器已经启动，9000端口监听中....");
    })