1. 简介
    1. 简介
        1. 能够在服务器端运行js的开放源代码跨平台js运行环境
        2. 采用google开发的v8引擎运行js代码，使用事件驱动非阻塞和异步I/O模型等技术来提高性能，可优化应用程序的传输量和规模
        3. Ryan Dahl是node.js之父
        4. 2015年基金会成立，2015.9 node.js和io.js合并 node 4.0发布
        5. node的特点，单线程，后台拥有一个I/O线程池
        6. 解决单线程问题是分布式服务器
    2. node.js的缺陷
        1. 没有模块化（ES5之前）
        2. 标准库较少
        3. 没有标准接口
        4. 缺乏管理系统
    3. CommonsJS规范，弥补了上述缺陷
        1. 对模块的定义
        2. 模块引用
        3. 模块定义
        4. 模块标识
2. fs模块是Node.js官方提供的、用来操作文件的模块。它提供了一系列的方法和属性，用来满足用户对文件的操作需求
    1. 导入
    ```
    // 导入
    const fs=require('fs')
    // 方法
    fs.readFile()//读文件
    fs.writeFile()//写入内容
    ```
090. 模块化
    1. 内置模块、自定义模块、第三方模块
    2. 可以使用require()方法加载（注意自定义模块需要指定路径，可以省略后缀名）
    3. 当使用require()方法加载模块时会执行加载的模块
    4. 模块作用域
    5. 每个.js自定义模块中都有一个module对象，它里面存储了和当前模块有关的信息
    6. 可以通过module.exports对象向外共享成员
    7. 使用require方法导入自定义模块时，得到的就是module.exports指向的对象
    8. exports和module.exports指向的是同一个对象
    9. CommonsJS规范
        1. 每个模块内部，module变量代表当前模块
        2. module变量是一个对象，他的exports属性（即module.eexports）是对外的接口
        3. 加载某个模块，其实是加载该模块的module.exports属性，require方法用于加载模块
090. npm与包
    1. 第三方模块又叫包
    2. npm,inc.公司 http://www.npmjs.com/ 全球最大的包共享平台
    3. 该公司提供了一个服务器共享所有的包，http://registry.npmjs.org/
    4. npm包管理工具Node Package Manager
    5. 安装包 npm install 完整的包名称 简写 npm i 完整的包名称
    6. node_modules文件夹，存放导入的包
    7. package-lock.json配置文件，记录报的下载信息
    8. 安装相同的包会覆盖上次安装，@后跟版本号
    9. 包的语义化版本规范，第一位数代表大版本，第二位数代表功能版本，第三位数代表Bug修复版本
    10. 包管理配置文件
        1. npm规定，在项目根目录中，必须提供一个叫做package.json的包管理配置文件，用来记录项目有关的一些配置信息
        2. 项目开发中，将node_modules文件夹添加到.gitignore忽略文件中
        3. 快速创建package.json npm init -y，项目目录不应包含中文和空格
        4. dependencies节点，记录安装的包
        5. 一次性安装所有包 npm i
    11. 卸载包npm uninstall 全包名
    12. devDeppendencies，如果某些包只在开发项目阶段会用到，建议包这些包记录在devDependencies节点npm i 包名 -D 是（--save-dev的简写）
    13. 如果某些包开发阶段和项目上线阶段都需要用到，建议记录到dependencies节点中