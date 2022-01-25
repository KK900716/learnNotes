1. 简介
    1. ECMA（European Computer Manufacturers Association）欧洲计算机制造商协会
    2. ECMAScript是由ECMA国际通过ECMA-262标准化的脚本程序设计语言
    3. TC39（Technical Committee 39）是推进ECMAScript发展的委员会，目前该委员会在维护ECMAScript
2. let
    1. let声明变量
    2. let不能重复声明
    3. 块级作用域
    4. 不存在变量提升
    5. 不影响作用域链
3. const
    1. const声明常量
    2. 常量不能修改
    3. 一定要赋初始值
    4. 常量一般使用大写
    5. 块级作用域
    6. 对数组和对象的元素修改，不算做对常量的修改
4. 解构赋值
    1. 数组的解构
    ```
        let x=[1,2,3,4];
        let [a,b,c,d]=x;
        console.log(a);
        console.log(b);
        console.log(c);
        console.log(d);
    ```
    2. 对象的解构
    ```
        const x={
            name:"abc",
            age:"de",
            f(){
                console.log(name+age);
            }
        };
        let {name,age,f}=x;
        f();
    ```
5. 模版字符串
    ```
        let love=`注意`;
        let str=`${love}新的声明字
                    符串形式！`;
        alert(str);
    ```
    1. 模版字符串可以直接出现换行符
    2. 模版字符串可以进行变量拼接
6. 允许在大括号里面直接写入变量和函数，作为对象的属性和方法
```
    let name=`变量`;
    let change=function(){
        console.log('abc');
    };
    const x={
        name,
        change,
        improve(){
            console.log('def');
        }
    }
```
7. 箭头函数=>
    1. 箭头函数声明
    ```
    let fn=()=>{   
    }
    ```
    2. this是静态的，始终指向函数声明时所在的作用域
    3. 不能作为构造函数实例化对象
    4. 不能使用arguments变量
    5. 简写，当形参有且只有一个时，可以省略小括号，当代码体只有一条语句时可以省略大括号，此时return语句也必须省略
    6. 箭头函数适合与this无关的回调，定时器，数组的方法回调
    7. 箭头函数不适合与this有关的回调，事件回调
8. 允许给函数参数赋初始值
    1. 具有默认值的函数一般位置要靠后
    2. 与解构赋值可以结合使用
9. ES6引入rest参数，用于获取函数的实参，用来代替arguments
    ```
        function f(a,b,...c){
            console.log(a);
            console.log(b);
            console.log(c);
        };
        f(1,2,3,4,5);
    ```
    rest参数要放在最后
10. 扩展运算符...
    1. 将数组转化为逗号分割的参数序列
    ```
        const arr=["a","b","c"];
        function f(){
            console.log(arguments);
        };
        f(arr);
    ```
    2. 数组合并
    ```
        const arr0=["a","b","c"];
        const arr1=["d","e","f"];
        const arr2=[...arr0,...arr1];
    ```
    3.数组克隆
    ```
        const arr0=["a","b","c"];
        const arr1=[...arr0];
    ```
    4.将伪数组转化为真正的数组
    ```
        const divs=document.querySelectorAll('div');
        const divArr=[...divs]
        console.log(divArr);
    ```
11. Symbol数据类型
    1.