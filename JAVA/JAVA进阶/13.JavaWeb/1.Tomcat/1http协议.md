    6.http协议
        a.请求报文
            （1）请求行
                1）请求类型
                    get、post方法
                2）url路径
                3）http/1.1 http版本
            （2）请求头
                1）Host：
                2）Cookie：
                3）Content-type：
                4）其他
            （3）空行
            （4）请求体
                1）get请求体为空
                2）post请求请求体可以为空
        b.响应报文
            （1）响应行
                1）http/1.1 http版本
                2）响应状态码 例如200成功、404找不到、403禁止、401未授权、500内部错误等
                3）响应字符串 OK
            （2）响应头
                对响应体进行一个描述
            （3）空行
            （4）响应体
                内容