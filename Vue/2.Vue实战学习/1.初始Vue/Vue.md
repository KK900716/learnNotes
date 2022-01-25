1. 容器和Vue一一对应
2. 容器中可以放变量和表达式
```
    Vue.config.productionTip=false;//阻止在vue启动时生成提示
```
3. 模版语法
    1. {{variable}} 插值语法
        1. 功能 用于解析标签体内容
        2. 写法 {{js表达式}}
    2. 指令语法
        1. v-bind:xxx 简写为:xxx xxx为js表达式
            1. 功能 用于解析标签（包括 标签属性、标签体内容、绑定事件等）
            2. 单向绑定
        3. v-model: 双向绑定
            1. v-model:指令只能用在表单类元素，即只能用在value属性上