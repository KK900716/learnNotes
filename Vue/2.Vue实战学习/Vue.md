1. Vue2    
    1. Vue核心
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
                3. trim输入空格过滤
        11. 过滤器
            1. 比较有用的第三方开源库BootCDN
            2. 处理时间：moment.js，轻量化解决方案：dayjs
            3. 定义 对要显示的数据进行特定格式化后再显示（适用于一些简单逻辑的处理）
            4. 过滤器可以串联，可以接受额外的参数
            5. 并没有改变原本的数据，是产生新的对应的数据
            ```
            <div id="app">
                {{fmtTime}}<br>
                {{getFmtime()}}<br>
                {{time|timeFormater('YYYY-MM-DD HH:mm:ss')}}<br>
                {{time|timeFormater('YYYY-MM-DD HH:mm:ss')|mySlice}}<br>
            </div>
            <div id="app2">
                {{variation|mySlice}}
            </div>
            <script>
                Vue.config.productionTip=false;
                Vue.filter('mySlice',function(value){
                    return value.slice(0,4)
                });
                var vm=new Vue({
                    el:"#app",
                    data:{
                        time:Date.now(),
                    },
                    computed:{
                        fmtTime(){
                            return dayjs(this.time).format('YYYY-MM-DD HH:mm:ss')
                        }
                    },
                    methods: {
                        getFmtime(){
                            return dayjs(this.time).format('YYYY-MM-DD HH:mm:ss')
                        }
                    },
                    filters:{
                        timeFormater(time,s){
                            return dayjs(time).format(s)
                        },
                    }
                });
                var vm=new Vue({
                    el:"#app2",
                    data:{
                        variation:'Hello world!'
                    },
                });
            </script>
            ```
        12. 内置指令
            1. v-text，将文字覆盖掉坐在元素的内容
            2. v-html，与1相比支持标签
            3. v-html存在安全性问题
                1. 在网站上动态渲染任意HTML是非常危险的，容易导致xss攻击
                2. 一定要在可信的内容上使用v-html，永远不要用在用户提交内容上
            4. v-cloak配合属性选择器可以控制未编译内容不再渲染到网页中，当Vue介入时会删除该属性
            5. v-once只渲染一次变量
            6. v-pre跳过内容解析，以增快速度
        13. 自定义指令
            1. 自定义指令的函数调用时机
                1. 指令与元素成功绑定时
                2. 指令所在的模版被重新解析时
            2. 自定义指令的对象内容和调用时机（一般用于拿到父元素、获取焦点等特殊需求）
                1. bind 指令与元素成功绑定时
                2. inserted 指令所在元素被插入页面时
                3. update 指令所在的模版被重新解析时
            3. 传参类型
                1. element所在元素对象
                2. binding传入的参数对象
                    1. value传入参数的值
            4. 多个单词用-作分割，原因是html不区分大小写，可以用原生''来定义该指令
            5. 自定义指令里的this是window
            6. 指令是局部指令
            7. 定义全局可以同过滤器
            ```
            <div id="app">
                <span>{{n}}</span>
                <span v-big="n"></span>
                <button @click="n++">点我n++</button>
                <input type="text" v-fbind:value="n">
            </div>
            <script>
                Vue.config.productionTip=false;
                var vm=new Vue({
                    el:"#app",
                    data:{
                        n:0,
                    },
                    directives:{
                        big(element,binding){
                            element.innerText=binding.value*10
                        },
                        fbind:{
                            bind(){

                            },
                            insereted(){

                            },
                            updated() {
                                
                            },
                        }
                    }
                });
            </script>
            ```
        14. 生命周期回调函数（生命周期函数、生命周期、生命周期钩子）
            ```
            // 在实例初始化之后，数据观测（data observer）和event/watcher事件配置之前被调用
            beforeCreate:function(){
                console.log('beforeCreate');
            },
            // 在实例创建完成后被立即调用
            // 在这一步实例已完成一下的配置：数据观测（data observer），属性和方法的运算，watch/event事件回调
            // 然而，挂在阶段还没开始，$el属性目前不可见
            created:function(){
                console.log('created');
            },
            // 在挂载开始之前被调用：相关的渲染函数首次被调用
            beforeMount:function(){
                console.log('beforeMount');
            },
            // el被新创建的vm.$el替换，挂载成功
            mounted:function(){
                console.log('mounted')
            },
            // 数据更新时调用
            beforeUpdate:function(){
                console.log('beforeUpdate')
            },
            // 组件DOM已经更新，组件更新完毕
            updated:function(){
                console.log('updated')
            },
            ```
            1. this的指向是vm
            2. debugger 断点
            3. template属性，模版，模版内只能有一个根标签节点，不能用template标签做跟标签，且会直接替换掉vue的根结点
            4. vm.$destroy() 销毁vm，完全销毁一个实例，清理它与其他实例的连接，解绑它的全部指令及事件监听器
            5. beforeDestroy 一般在此阶段关闭定时器、取消订阅消息、解绑自定义事件等收尾操作 不再会触发对数据的修改
            6. 常用的生命周期钩子有两个
                1. mounted，发送AJAX请求、启动定时器、绑定自定义事件、订阅消息等初始化操作
                2. beforeDestroy，清除定时器、解绑自定义事件、取消订阅消息等收尾工作
            7. 关于销毁Vue实例
                1. 销毁后借助Vue开发者工具开不到任何信息
                2. 销毁后自定义事件会失效，但原生DOM事件依然有效
                3. 一般不会在beforeDestroy操作数据，因为即使操作数据，也不会再触发更新流程了
    2. 组件化编程
        1. 传统方式编写应用
            1. 依赖关系混乱，不好维护
            2. 代码复用率不高
        2. 组件：实现应用中局部功能代码和资源的集合
        3. 单文件组件 一个文件中包含多个组件
            ```
            <div id="app">
                <!-- 3. 编写组件标签 -->
                <school></school>
                <hr>
                <student></student>
            </div>
            <script>
                Vue.config.productionTip=false;
                // 1.创建组件
                const school = Vue.extend({
                    template:`<h2>{{name}}{{type}}</h2>`,
                    data(){
                        return {
                            name:'组件1',
                            type:'shzu'
                        };
                    }
                });
                var vm = new Vue({

                });
                const student = Vue.extend({
                    template:`<h2>{{name}}{{type}}</h2>`,
                    data(){
                        return {
                            name:'组件1',
                            type:'student'
                        };
                    }
                });

                var vm = new Vue({
                    el:'#app',
                    // 2.注册组件
                    components:{
                        school:school,
                        student
                    }
                });
            </script>
            ```
            1. 注意data必须写成函数式
            2. 可以进行全局注册
            3. 几个注意点
                1. 组件名首字母应大写（不用刻意，会自动转化）
                2. 组件命名方式，多单词
                    1. 短横做链接 kebab-case
                    2. 首字母全大写（脚手架环境） CamelCase
                3. name可以指定组件在开发者工具中的名字
                4. 当写自闭和标签时，不在脚手架环境可能会导致只显示一个自闭和标签
                5. 简写方式：直接在定义组件时定义配置对象
            4. 组件嵌套 开发中常用vm管理app，app管理下面所有的组件
            5. VueComponent（vc）
                1. 其实就是组建的构造函数，当写到该标签Vue会根据该构造函数创建一个实例
                2. 所以每次调用extend方法，Vue会创建一个全新组件
                3. 故又可以得出组件中的那些this指向的是VueComponent实例
                4. $childen中管理者下级组件
            6. 一个重要的内置关系
                1. VueComponent.prototype.__proto__===Vue.prototype
                2. 则组件实例对象（vc）可以访问到Vue原型上的属性和方法
        4. 单文件组件 一个文件中只有一个组件
            1. Vue脚手架（Vue CLI（command line interfac 命令行接口工具））
                1. npm config set registry https://registry.npm.taobao.org
                2. npm install -g @vue/cli
                3. set-ExecutionPolicy RemoteSigned
                4. vue create vuetest
                5. cd vuetest
                6. npm run serve
                7. render配置项是防止vue中没有模版解析器
                8. vue=vue核心+vue模版解析器
            2. 脚手架的配置
                1. vue inspect > output.js 查看配置
                2. 同目录下创建vue.config.js参考官网文档进行配置
                3. lintOnSave语法检查
                ```
                lintOnSave:false
                ```
            3. ref
                1. vue中替代id的标签属性
                ```
                <template>
                <div>
                <h1 v-text="msg" ref="title"></h1>
                <button @click="showDOM">点我输出上方元素</button>
                <School/>
                </div>
                </template>

                <script>
                import School from './components/School.vue'

                export default {
                name: 'App',
                components: {
                    School
                },
                data() {
                    return {
                    msg:'继续',

                    }
                },
                methods: {
                    showDOM(){
                    console.log(this.$refs.title)
                    }
                },
                }
                </script>
                ```
                2. 如果给组件指定ref，则指向的是组件实例对象
                3. 被用来给元素或子组件注册引用信息
            4. props
                1. 需要在组件标签属性中写入，建议加入数据绑定:
                2. 在被注册的组件中写入props，可以写成数组和对象形式，对象形式中值可以限制数据类型
                3. 可以写成对象中每个变量都是对象的形式，type指类型、required指是否必须传，default指默认值
                4. 收到的数据无法在组件内修改
                ```
                <School address='看看'/>
                props:['address']

                ```
            5. mixin混入
                1. 两个组件共享一个配置
                ```
                export const mixin={
                    methods: {
                        show(){
                            alert(this.name);
                        }
                    },
                }
                import {mixin} from './mixin'
                mixins:[mixin]
                ```
                2. 数据冲突遵循原混合
                3. 生命周期钩子则都执行
                3. 局部混合和全局混合
                    1. 上述是局部混合
                    2. 全局混合Vue.mixin()
                4. 功能把共有属性抽取出来实现代码复用
            6. 插件（本质是包含install的对象）
                ```
                export default{
                    install(){

                    }
                }
                import plugins from './plugins'
                Vue.use(plugins)
                ```
                1. 用于增强vue，传入的第一个参数是Vue的原型对象，后续也可以传入其他参数
            7. style的scoped会在渲染时添加一个属性随机生成值，这样用属性选择器和该类选择器的交集可以避免命名空间冲突问题
            8. style的lang可以指定语言，要注意版本兼容性问题 例如安装less-loader
                1. npm view webpack versions
                2. npm view less-loader versions（8、9为webpack5服务）
                3. npm i less-loader@7
        5. 组件化编码流程
            1. 实现静态组件：抽取组件，使用组件实现静态页面效果
            2. 展示动态数据：
                1. 数据的类型、名称是什么
                2. 数据保存在哪个组件
            3. 交互 从绑定事件监听开始
        6. 浏览器本地存储
            1. localStorage 除了操作API或清空缓存，一般不会丢失
                1. 保存数据
                    1. localStorage.setItem(键,值) 必须都是字符串
                    2. 不是字符串可以用JSON存即JSON.stringify
                2. 读数据
                    1. localStorage.getItem(键) 
                    2. 同样可以用JSON.parse解析
                    3. 没有数据就是null
                3. 删除数据localStorage.removeItem(键)
                4. 清空数据localStorage.clear()
            2. sessionStorage API同上 浏览器关闭就会消失
            3. 统称为webStorage，存储大小约5M（不同浏览器不同）
        7. 组件的自定义事件
            1. 子给父传递数据的方法
                1. 父定义一个方法传给子
                2. 父定义一个自定义事件由子触发
                ```
                    this.$emit('evezdy',this.msg);//第一个参数是自定义事件名，第二个传输为传递参数
                ```
                3. 通过ref方法this.$refs.student拿到子
                    ```
                        this.$refs.Comp2.$on('getSj',this.f)
                    ```
                    1. 和2类似但更灵活
                    2. 可以在生命周期钩子中设置定时器等
                    3. once可以只触发一次
                    4. 注意这种写法的函数要么写成箭头函数，要么调用methods中的方法，原因是该回调this指向子组件
            2. 解绑自定义事件
                1. 解绑一个自定义事件
                ```
                this.$off('evezdy');
                ```
                2. 解绑多个自定义事件
                ```
                this.$off(['evezdy','事件2']);
                ```
                3. 解绑全部事件
                ```
                this.$off();
                ```
            3. .nativ修饰符可以告诉vue这是原生的事件
        8. 全局事件总线
            ```
            beforeCreate() {
                Vue.prototype.$bus=this //安装全局事件总线
            }
            ```
            1. GolbalEventBus，一种组件间通信的方式
            2. 最好再beforeDestroy钩子中，用$off去解绑当前组件所用到的事件
        9. 消息订阅与发布（第三方库）
            1. 订阅消息：消息名
            2. 发布消息：消息内容
            3. pubsub-js库
            4. 安装 npm i pubsub-js
            ```
            import pubsub from 'pubsub-js'
                this.pubID=pubsub.subscribe('hello',(name,content)=>{
                    console.log('收到');
                    console.log(content);
                });

                pubsub.publish('hello',this.msg)

                pubsub.unsubscribe(this.pubID)
            ```
            5. _可以做实参占位符使用
            6. this.$nextTick(()=>this.$refs.inp.focus())在下一次DOM更新结束后执行其指定的回调
        10. 过渡与动画
            1. 动画
                1. <transition>标签用来添加过渡
                ```
                .a{
                    background-color: #da4f49;
                }
                .v-enter-active{
                    animation: dh 1s;
                }
                .v-leave-active{
                    animation: dh 1s reverse;
                }
                @keyframes dh {
                    from{
                    transform: translateX(-100%);
                    }to{
                    transform: translateX(0px);
                    }
                }
                ```
                2. v为默认name名，可以在transition的name标签指定动画名
                3. appear为刚出现则有效果
            2. 过渡
                1. 
                ```
                .na-enter,.na-leave-to{
                /*  进入的起点*/
                    transform: translateX(-100%);
                }
                .na-enter-to,.na-leave{
                /*  进入的终点*/
                    transform: translateX(0);
                }
                .na-enter-active,.na-leave-active{
                    transition: 0.5s;
                }
                ```
                2. transition只能使用在一个标签上，多个标签请使用transition-group标签
                3. 并且必须给定:key值
            3. 集成第三方动画
                1. animate.css库https://animate.style/
                2. <transition name="animate__animated animate__bounce" enter-active-class="animate__jello" leave-active-class="animate__hinge" appear>
            4. 总结
                1. 作用 在插入、更新或移除DOM元素时 在合适的时候给元素添加样式类名
    3. AJAX跨域问题
        1. 引入axios npm i axios
        2. 代理服务器解决跨域问题
            1. nginx反向代理
            2. vue-cli
                ```
                devServer:{
                    proxy:'http://localhost:8000'
                }
                ```
                1. 上述配置缺点
                    1. 只能配置一个代理，不够灵活
                    2. 已有的静态资源无法请求
                2. 故可以有以下配置
                ```
                devServer:{
                    proxy:{
                        '/api':{//请求前缀
                            target:'http://localhost:8000',
                            pathRewrite:{'^/api':''},//重命名路径
                            ws:true,//用于支持websocket，默认为真
                            changeOrigin:true//用于控制请求头中的post值，默认为真
                        },
                        // '/foo':{
                        //     target:'http://localhost:8000'
                        // }
                    }
                }
                ```
        3. 在js中引入css会严格检查语法，这是可以选择在public文件下的页面中直接引入css
        4. vue-resource插件发送ajax请求
            1. npm i vue-resource
            2. 和axios风格相同$http调用即可
            3. 维护不够频繁，vue1.0时期常用的插件
    4. slot插槽
        1. 让父组件向子组件指定位置插入html结构，也是一种组件通信方式 <slot></slot>
        2. 默认插槽
        3. 具名插槽
            1. 给插槽指定name，在要插入的内容中指定slot属性名字是指定插槽名
            2. 可以用template标签包裹，此事不适用slot命名，而使用v-slot: 命名 无引号
        4. 作用域插槽
            1. 子组件用插槽向父组件传递data中的数据
            2. 即数据由组件定，结构由使用者定
            3. 传递直接写在插槽，接受必须用template标签 标签属性可以用slot-scope或scope，可以用es6结构赋值简化书写
    5. Vuex
        1. 概念：专门在Vue中实现集中式状态（数据）管理的一个Vue插件，对vue应用中多个组件的共享状态进行集中式的管理（读/写），也是一种组件间通信的方式，且适用于任意组件间通信
        2. 什么时候使用（共享）
            1. 多个组件依赖于同一状态
            2. 来自不同组件的行为需要变更同一状态
        3. Vue Components --(Dispatch)--> Actions --(Commit)--> Mutations --(Mutate)--> State --(Render)--> Vue Componeents
            1. Vue允许组件可以直接调用Commit
            2. Actions可以用来向服务器发送数据接收参数后再提交
            3. Actions也可以用来写一些业务逻辑
            4. store用来管理Vuex
        4. npm i --legacy-peer-deps npm i vuex

2. Vue3
    1. 对比Vue2
        1. 速度更快
        2. 源码升级
            1. 使用Proxy代替defineProperty实现响应式
            2. 重写虚拟DOM的实现和Tree-Shaking
        3. 拥抱TypeScript
        4. 新特性
    2. 创建vue-cli
        1. 使用cli创建，要求cli在4.5.0以上
        2. 使用vite创建
            1. vite是新一代前端构建工具
            2. 优势，开发环境中，无需打包操作，可快速冷启动
            3. 轻量快速的热重载（HMR）
            4. 真正的按需编译，不再等待整个应用编译完成
        3. 
