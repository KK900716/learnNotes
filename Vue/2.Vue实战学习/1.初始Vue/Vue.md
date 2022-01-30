1. VUe入门    
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
        1. Vue将data中的数据存在_data中，通过数据代理实现将_data中的属性直接放到vm中来方便编程
        2. _data中的数据通过数据劫持，实现视图的更新
2. 事件处理
    1. v-on:click="showInfo"
    2. 所有被Vue管理的函数最好不要用箭头函数
    ```
        <div id="app">
        <div>{{varibale}}</div>
        <button v-on:click="showInfo">点我提示信息（不传参）</button>
        <button @click="showInfo">点我提示信息</button>
        <button @click="showInfo2(66)">点我提示信息2</button>
        <button @click="showInfo3(66,$event)">点我提示信息2</button>
    </div>
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                varibale:"hello world!",
            },
            methods:{
                showInfo(event){
                    alert("hello");
                    console.log(event.target);//获得该元素
                    // this就是vm
                },
                showInfo2(number){
                    alert(number);
                },
                showInfo3(number,event){
                    alert(number);
                }
            }
        });
    </script>
    ```
    3. 事件修饰符
        ```
        <div id="app">
            <div>{{varibale}}</div>
            <a href="http://www.baidu.com" @click="showInfo">点击我</a>
            <!-- 阻止默认行为 -->
            <a href="http://www.baidu.com" @click.prevent="showInfo2">点击我</a>
        </div>
        <script>
            Vue.config.productionTip=false;
            var vm=new Vue({
                el:"#app",
                data:{
                    varibale:"hello world!",
                },
                methods:{
                    showInfo(event){
                        event.preventDefault();//阻止默认行为
                        alert("hello");
                    },
                    showInfo2(){
                        alert("hello");
                    }
                }
            });
        </script>
        ```
        1. prevent 阻止默认事件
            api event.preventDefault()
        2. stop 阻止事件冒泡 
            api event.stopPropagation()
        3. once 事件只触发一次
        4. capture 使用事件的捕获模式（默认在冒泡阶段执行事件）
        5. self 只有event.target是当前操作的元素才触发事件
        6. passive 事件的默认行为立即执行，无需等待事件回调执行完毕
            这里可以绑定@scroll和@wheel，@wheel会等到回调函数执行完毕之后才执行事件所以该事件加入passive和@scroll有类似效果
        7.时间修饰符可以连写
    4. 键盘事件
        1. 按键别名
        ```
        <div id="app">
            <input type="text" placeholder="按下回车提示输入" @keyup.enter="showInfo">
        </div>
        <script>
            Vue.config.productionTip=false;
            var vm=new Vue({
                el:"#app",
                data:{
                    varibale:"hello world!",
                },
                methods:{
                    showInfo(event){
                        // if(event.keyCode!==13)return;
                        console.log(event.target.value);
                    }
                }
            });
        </script>
        ```
        2. 常用别名
            1. 回车 enter
            2. 删除、退格 delete
            3. 退出 esc
            4. 空格 space
            5. 换行 tab
            6. 上 up
            7. 下 down
            8. 左 left
            9. 右 right
            10. tab已经绑定了事件建议绑定keydown
        3. 未提供别名的按键，可以使用按键原始的key值去绑定，但注意要转为kebab-case（短横线命名）
            1. event.keyCode按键编码
            2. event.key按键名称
            3. 例如caps-lock
        4. 系统修饰键（用法特殊）ctrl、alt、shift、meta
            1. 配合keyup使用：按下休时间的同时，再按下其他减，随后释放其他键，事件才被触发
            2. 配合keydown使用：正常触发事件
        5. 不建议使用按键编码定义事件
        6. Vue.config.keyCodes.别名=编码 可以用来自定义别名按键，也不推荐
        7. 可以指定多个按键，可以连写
3. 计算属性
    ```
    <div id="app">
        姓：<input type="text" v-model="fristName"><br>
        名：<input type="text" v-model="lastName"><br>
        姓名：<span>{{fullName}}</span>
    </div>
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                fristName:"",
                lastName:"",
            },
            computed:{
                fullName:{
                    get(){
                        return this.fristName+"-"+this.lastName
                    }，
                    set(){

                    }
            }
        });
    </script>
    ```
    1. get调用的时机
        1. 初次调用计算属性时
        2. 依赖数据发生变化时
    2. set不是必须的
        1. set调用的时机
        2. 当计算属性发生变化时
    3. 计算属性
        1. 定义：要用的属性不存在，要通过已有属性计算得来
        2. 原理：底层借助Object.defineproperty方法提供的getter和setter
        3. 优势：内部有缓存机制（复用），效率高，利于调试
        4. 计算属性最终会出现在vm上
    4. 计算属性的简写：若计算属性只读取不修改
        ```
        fullName:function(){
            return
        }
        ```
4. 监视属性
    ```
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                isHot:true,
            },
            computed:{
                info:function(){
                    return this.isHot?"炎热":"凉爽";
                }
            },
            watch:{
                isHot:{
                    // 当值被修改时调用该函数
                    handler(newValue,oldValue){
                        console.log(newValue,oldValue);
                    },
                    // 当前监视是立即执行还是值修改时执行，默认false
                    immediate:true,
                },
                info:{
                    handler(x,y){
                        console.log(x,y);
                    }
                }
            }
        });
        vm.$watch('isHot',{
            handler(newValue,oldValue){
                console.log(newValue,oldValue);
            }
        })
    </script>
    ```
    1. 简单的语句可以直接放在事件属性后
    2. 当监视属性变化时，回调函数自动调用
    3. 监视属性必须存在才能监视（但没有不会报错）
    4. vm.$watch是一种简写
    5. 深度监视
        1. 监视多级需求中某个属性的变化请带引号"Numbers.a"
        2. Vue默认不会在watch中监视某个属性的子属性
        3. 如果要开启深度监视，即开启多级结构中的监视，设置属性deep为true
    6. 监视的简写，如果只需要调用handler可以直接写成该函数
    7. 计算属性依靠返回值，所以不能开启异步任务，但是监视属性不依赖返回值，能够较好的兼容异步任务
    8. 计时器中的第一个参数即回调函数，不是Vue管理的，应该使用箭头函数
    9. 即所有不被Vue管理的函数，不要使用匿名函数，应该写成箭头函数
5. Vue绑定样式
    1. class样式绑定
        1. 绑定class可以动态的给class修改值，适用于样式的类名不确定，需要动态指定
        2. 绑定class样式的值可以是数组，这样可以指定多个样式，适用于要绑定的样式个数和名字都不确定的情况
        3. 绑定class样式的值可以是对象，对象里写描述类的布尔值，来表示是否应用该样式，适用于要绑定的样式个数和名字都确定的情况
    2. style内联样式绑定（不常用）
        1. 绑定style样式的值可以是对象，例如:style="{fontSize:'40px'}"
        2. 这里要注意两单词要用驼峰命名法
        3. 绑定style样式的值可以是数组，数组里嵌套这对象，不常用
6. 条件渲染
    1. v-show:true/false
        1. 真为显示，假为隐藏
        2. 原理是调整display属性
    2. v-if
        1. 真为显示，假为隐藏
        2. 原理是直接干掉该模块，即不渲染该模块
    3. 故1的效率高，2的效率低
    4. v-else-if v-else
        1. 同分支语句相同
        2. 会使效率更高
        3. 如果使用这个结构，中间是不能被其他DOM结构打断的
    5. 用template模版包裹，可以不影响结构，但该模版只能配合v-if使用
7. 列表渲染
    ```
    <div id="app">
        <ul>
            <li v-for="person in people" :key="person.id">
                {{person.name}}:{{person.age}}
            </li>
        </ul>
        <ul>
            <li v-for="(person,index) in people" :key="index">
                {{person.name}}:{{person.age}}
            </li>
        </ul>
        <ul>
            <li v-for="(value,key) of car" :key="key">
                {{key}}:{{value}}
            </li>
        </ul>
    </div>
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                people:[
                    {id:'001',name:'张三',age:'18'},
                    {id:'002',name:'李四',age:'19'},
                    {id:'003',name:'王五',age:'20'},
                ],
                car:{
                    name:'奥迪',
                    price:'70w',
                    color:'black'
                }
            },
        });
    </script>
    ```
    1. 可以遍历数组
    2. 可以遍历对象
    3. 可以遍历字符串（不常用）
    4. 可以遍历指定次数（不常用）v-for="(value,key) in 10"
    5. 可以用v-for遍历，第一个值是value，第二个值是key
    6. 原理
        1. Vue会将数据->虚拟DOM->真是DOM
        2. Vue会对比更新前后的虚拟DOM应用虚拟DOM对比算法
        3. 算法依靠key值进行对比进行重新渲染
        4. 从上述算法可以知道，如果应用index作为key值，会降低效率
        5. 如不设置，Vue会默认将index作为key
8. 列表过滤
    1. 监视属性写法
    ```
    <div id="app">
        <ul>
            <li v-for="(person,index) in fil" :key="person.id">
                {{person.name}}:{{person.age}}{{person.sex}}
            </li>
        </ul>
        <input type="text" v-model="input">
    </div>
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                people:[
                    {id:'001',name:'马冬梅',age:'18',sex:'女'},
                    {id:'002',name:'周冬雨',age:'19',sex:'女'},
                    {id:'003',name:'周杰伦',age:'20',sex:'男'},
                    {id:'004',name:'温兆伦',age:'20',sex:'男'},
                ],
                input:'',
                fil:[]
            },
            watch:{
                input:{
                    immediate:true,
                    handler(value){
                        this.fil=this.people.filter((p)=>{
                            return p.name.indexOf(value)!==-1
                        })
                    }
                }
            }
        });
    </script>
    ```
    2. 计算属性写法
    ```
    <div id="app">
        <ul>
            <li v-for="(person,index) in fil" :key="person.id">
                {{person.name}}:{{person.age}}，性别：{{person.sex}}
            </li>
        </ul>
        <input type="text" v-model="input">
    </div>
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                people:[
                    {id:'001',name:'马冬梅',age:'18',sex:'女'},
                    {id:'002',name:'周冬雨',age:'19',sex:'女'},
                    {id:'003',name:'周杰伦',age:'20',sex:'男'},
                    {id:'004',name:'温兆伦',age:'20',sex:'男'},
                ],
                input:'',
            },
            computed:{
                fil(){
                    return this.people.filter((p)=>{
                        return p.name.indexOf(this.input)!==-1
                    })
                }
            }
        });
    </script>
    ```
    3. 列表排序
    ```
    <script>
        Vue.config.productionTip=false;
        var vm=new Vue({
            el:"#app",
            data:{
                people:[
                    {id:'001',name:'马冬梅',age:'19',sex:'女'},
                    {id:'002',name:'周冬雨',age:'18',sex:'女'},
                    {id:'003',name:'周杰伦',age:'20',sex:'男'},
                    {id:'004',name:'温兆伦',age:'21',sex:'男'},
                ],
                input:'',
                sortType:0
            },
            computed:{
                fil(){
                    let x = this.people.filter((p)=>{
                        return p.name.indexOf(this.input)!==-1
                    });
                    if(this.sortType){
                        x.sort((a,b)=>{
                            return this.sortType===1?a.age-b.age:b.age-a.age;
                        });
                    }
                    return x;
                }
            },
        });
    </script>
    ```
9. 更新时的问题即监视属性原理
    1. Vue通过get和set方法巧妙的通过构造函数避开无限递归去实现数据代理
    2. Vue.set方法可以将后添加数据接受Vue管理vm.$set
        Vue.set(vm.对象,属性,值)
    3. 不允许直接给vm的data域中直接加入对象
    4. Vue无法识别数组中的更改，原因是数组中没有匹配的get和set方法
    5. 但使用push pop shift unshift splice sort reverse可以让Vue监视到
    6. 原理是Vue重写了上述方法
    7. 可以调用Vue.set方法修改数组中的值使得Vue能够监测到该方法还可以写成vm.$set()
    8. 实例看1.数据监测总结
    9. 上述这种原理我们称之为数据劫持
10. 收集表单数据
    1. 实例看2.收集表单数据
    2. 若type="text"，则v-model收集的是value值，用户输入的就是value值
    2. 若type="radio"，则v-model收集的是value值，要提前配置value值
    3. 若type="checkbox"，
        1. 没有配置input的value属性，那么收集的就是checked，布尔值
        2. 配置input的value属性
            1. v-model的初始值是非数组，那么收集的就是checked，布尔值
            2. v-model的初始值是数组，那么收集的就是value组成的数组
    4. v-model修饰符
        1. lazy失去焦点再收集数据
        2. number输入字符串转为有效的数字
        3. trim输入首位空格过滤
11. 过滤器