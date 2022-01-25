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
            2. v-model:value属性可以简写为v-model
4. el和data之间的关系
    1. 传入的对象中的el其实就是Vue实例中的$mount属性
    2. data可以写成对象式，也可以写成函数式，但函数返回的应该是对象，并且调用函数的this就是Vue实例
    3. Vue调用的函数不能使用箭头函数，因为箭头函数的this是window
5. data中的属性事实上最终会绑定在Vue实例中，Vue实例事实上就是参考部分MVVM模型构建的实例，故我们一般起名vm
6. Object.defineProperty方法
    1. Object.defineProperties(变量名,属性名,配置对象);
    2. 配置对象的
        1. value值为属性值
        2. enumerable为真则可枚举，默认为假
        3. writable为真则可以被修改，默认为假
        4. configurable为真则可以被删除，默认为假
        5. get:function(){
            //当有人读取该属性值时，get(getter)函数就会被调用，返回值就是该属性的值
            return 默认为值可修改
        }
        6. set(value){
            //当有人修改该属性值时，set(setter)函数就会被调用，会收到修改值
        }
    3. 通过此方法传入的属性默认是不可枚举类型，不参与遍历
    4. Object.keys(对象)返回值是所有属性名（不包括不可枚举类型）
7. 数据代理，通过一个对象代理对另一个对象中属性的值的操作
