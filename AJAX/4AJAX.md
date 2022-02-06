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
7. 同源策略
    1. Same-Origin Policy最早由Netscape公司提出，是浏览器的一种安全策略
    2. 同源：协议、域名、端口号必须完全相同，违背同源策略就是跨域
    3. AJAX默认遵循同源策略
8. 跨域解决方案
    1. JSONP，JSON with Padding是一个非官方的跨域解决方案，只支持get请求
    2. 借助script标签的跨域能力来发送请求
    3. CORS，Cross-Origin Resource Sharing 跨域资源共享。CORS是官方的跨域解决方案，他的特点是不需要在客户端做任何特殊的操作，完全在服务器中进行处理，支持get和post请求。跨域资源共享标准新增了一组HTTP首部字段，允许服务器声明那些源站通过浏览器有权限访问那些资源
    4. CORS通过设置一个响应头来告诉浏览器，该请求允许跨域，浏览器接收到该响应以后就会对响应放行