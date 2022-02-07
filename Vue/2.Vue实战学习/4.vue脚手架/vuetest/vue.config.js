module.exports = {
    lintOnSave:false,
    // 1.方式一
    // devServer:{
    //     proxy:'http://localhost:8000'
    // }
    // 2.方式二
    // devServer:{
    //     proxy:{
    //         '/api':{//请求前缀
    //             target:'http://localhost:8000',
    //             pathRewrite:{'^/api':''},//重命名路径
    //             ws:true,//用于支持websocket，默认为真
    //             changeOrigin:true//用于控制请求头中的post值，默认为真
    //         },
            // '/foo':{
            //     target:'http://localhost:8000'
            // }
    //     }
    // }
  }