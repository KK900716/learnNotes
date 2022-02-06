1. Express框架
    1. npm init --yes
    2. npm i express
    3. node 脚本名 启动脚本
    4. 
    5. 设置url参数，get请求可以用?接参数方式发送参数
    6. post请求
        1. 在send中设置
        2. 可以设置任意格式，只要服务端能够处理
2. nodemon
    1. npm install -g nodemon
    2. 运行 nodemon 脚本名
    3. 可以热更新
3. IE缓存问题
    1. 可以在url后加请求参数，可以采用t=Date.now()
    2. 这样每次请求就是针对不同的url浏览器就不会加载缓存
4. 请求超时控制和网络异常处理
5. 重复请求问题
6. axios
    1. <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/axios/0.25.0/axios.js"></script>