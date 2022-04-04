1. 简介
    1. 类加载器
    2. JVM执行引擎
        1. Interpreter解释器
        2. JIT Compiler即时编译器
        3. GC垃圾回收
    3. 本地方法接口
    4. JVM内存结构
        1. Method Area 方法区
        2. Heap堆
        3. JVM Stacks虚拟机栈
        4. PC Register程序计数器
        5. Native Method Stacks 本地方法栈
2. 程序计数器 Program Counter Register
    1. 线程私有
    2. 不会出现内存溢出
3. 虚拟机栈Java Virtual Machine Stacks
    1. 每个方法运行时需要的内存
    2. 每个栈由多个栈帧（Frame）组成，对应着每次方法调用时所占用的内存
    3. 每个线程只能有一个活动栈帧，对应着当前正在执行的那个方法
    4. 垃圾回收不会涉及栈内存
    5. -Xss size指定栈大小默认为1024KB（Windows是根据Windows的虚拟内存指定默认大小）
    6. 栈内存大小越大，则可使用的线程数越少
    7. 方法内的局部变量线程安全
    8. 栈内存溢出StackOverFlowError
        1. 栈帧过多导致栈内存溢出
        2. 栈帧大小过大
    9. 线程诊断cpu占用过高
        1. top查看进程信息
        2. ps H -el pid,tid,%cpu | grep 进程pid
        3. jstack（16进制）
    10. 排查死锁
    11. 栈帧
        1. 局部变量表 Local varialbes
            1. 定义为一个数字数组，主要用于存储方法参数和定义在方法体内的局部变量
            2. 线程私有 没有线程安全问题
            3. 编译器确定大小
            4. 变量槽 solt（非静态方法的第一个变量是this） solt可以重复利用
            5. 变量的分类
                1. 按数据类型分
                    1. 基本数据类型
                    2. 引用数据类型
                1. 按声明位置分
                    1. 成员变量 在使用前，都经历过默认初始化赋值
                        1. 类变量 连接阶段给类变量默认赋值  初始化阶段给类变量显示赋值即静态代码块赋值
                        2. 实例变量 随着对象的创建，会在堆空间中分配实例变量空间，并进行赋值
                    2. 局部变量 在使用前，必须要进行显示赋值，否则编译不通过
            6. 补充，局部变量表中的变量也是重要的垃圾回收根结点，只要被局部变量表中直接或间接引用的对象都不会被回收
        2. 操作数栈（表达式栈） 主要用于保存计算过程的中间结果，同时作为计算过程中变量临时的存储空间
            1. 栈顶缓存（Top-of-Stack Cashing）技术
                1. 由于使用栈作为操作数，零地址指令，故指令数很多，会频繁读写内存影响速度
                2. 故HotSpot JVM的设计者们提出了将栈顶元素全部缓存在物理CPU的寄存器中，以降低对内存的读写次数，提升执行效率
        3. 动态链接（指向运行时常量池的方法引用）
        4. 方法返回地址
        5. 一些附加信息
4. 本地方法栈Native Method Stacks
    1. 通过native修饰
    2. 调用C或C++编写的程序
5. 堆Heap
    1. 通过new关键字创建对象都会使用堆内存
    2. 他是线程共享的，需要考虑线程安全问题
    3. 有垃圾回收机制
    4. 堆内存溢出OutOfMemoryError
    5. -Xmx size指定堆内存大小
    6. 堆内存诊断
        1. jps工具
            1. 查看当前系统中有哪些java进程
        2. jmap工具
            1. 查看堆内存占用情况
        3. jconsole工具
            1. 图形界面的，多功能的监测工具，可以连续监测
        4. jvisualvm
6. 方法区
    1. 类加载器ClassLoader
        1. ClassWriter 生成字节码的类
            1. 创建该对象
            2. 调用visit方法，参数：版本、访问修饰符、类名、包名、父类名、接口
            3. 调用toByteArray，返回字节码数组
        2. 可以继承类加载器，使用defineClass方法加载字节码
    2. java1.8之后类加载器放在元空间中（系统内存）
    3. -XX:MaxMetaspaceSize=size设置元空间大小
    4. -XX:MaxPermSize=size设置永久代大小（java1.6之前）
7. 运行时常量池
    1. 常量池中的常量只有在运行时才会创建String对象
    2. StringTable[]串池，创建的的对象会放到String串池中（1.8）
    3. 两个String类型拼接实际上是执行了StringBuiler实例对象的append方法后再toString
    4. 而两个字符串常量拼接则需要在常量池中利用哈希索引寻找若有则指向，若没有则创建对象加入运行时常量池（在编译期间已经优化）
    5. 可以使用intern，将字符串对象尝试放入串池，并返回串池中的对象引用（1.8）
    6. 1.6以下若没有会复制一个对象放入串池
    7. StringTable1.6前在永久代常量池中，1.8后在堆区，可以被垃圾回收
    8. -XX:+UserGCOverheadLimit -是关闭开关 98%的时间花在垃圾回收，只有2%被回收时，抛出异常
    9. -XX:+PrintStringTableStatistics打印字符串常量池信息
    10. -XX:+PringGCDetails打印垃圾回收信息
    11. -verbose:gc
    12. StringTable性能调优
        1. 时间上
            1. 主要是调整Hash表中筒的个数来避免碰撞
            2. -XX:StringTableSize=size
        2. 空间上
            1. 将重复较多的字符串对象存入常量池intern
8. 直接内存Direct Memory
    1. 常见于NIO操作时，用于数据缓冲区
    2. 分配回收成本较高，但读写性能高（例如ByteBuffer）
    3. 不收JVM内存回收管理
    4. java通过Unsafe类（需要通过反射获取该对象的构造方法，因为该构造方法是私有的）来手动申请和释放内存，ByteBuffer底层原理利用了这个类
    5. Cleaner（虚引用）来监测ByteBuffer对象，一旦该对象被垃圾回收，那么就会由ReferenceHandler线程通过Cleaner的clean方法调用freeMemory来释放直接内存
    6. -XX:+DisableExplicitGC 禁用显式的垃圾回收，System.gc()时，可以调用Unsafe对象的方法来释放内存
9. 垃圾回收
    1. 引用计数法（无法解决循环引用问题）
    2. 可达性分析 和根对象通过引用链连接的对象不能被回收
    3. 引用
        1. 强引用 有强引用时，无法被回收
        2. 软引用 内存不够时，触发gc
            1. SoftReference对象，软引用对象
            2. 软引用队列ReferenceQueue，在创建软引用对象时的构造方法第二个参数，可以传入软引用队列，这样做的好处是可以释放软引用对象
            3. 通过队列的poll方法判断是否为空，并remove掉该对象，直至队列为空
        3. 弱引用 软引用和弱引用可能被回收 触发gc时被回收 软引用和弱引用引用的对象被gc时，进入引用队列，可被释放
            1. WeekReference对象，弱引用对象
        4. 虚引用 当引用的对象被gc时，进入引用队列，被线程调用Cleaner的Unsafe.freeMemory释放直接内存
        5. 终结器引用 虚引用和终结器引用必须借助引用队列 所有继承Object的finallize方法被一个终结器引用，终结器会加入引用队列，被一个优先级很低的线程所触发finallize方法（不推荐）
    4. 具体的垃圾回收算法
        1. 标记清除
            1. 标记->清除
            2. 速度快
            3. 容易产生内存碎片
        2. 标记整理
            1. 标记->整理
            2. 速度没有标记清除快
            3. 但不易产生碎片
        3. 复制
            1. 缺点是占用了双倍内存
    5. 分代垃圾回收机制
        1. 新生代 Young Gen 存放新创建的对象垃圾回收比较频繁
            1. 伊甸园Eden Space
            2. 当内存不足触发Minor GC
            3. 复制算法，复制到幸存区Suvivor Space，寿命+1
            4. 幸存区和伊甸园位置互换
            5. 当内存不足触发Minor GC
            6. 复制算法，复制到另一个幸存区，寿命+1
            7. ......
            8. 当寿命达到阈值，将该对象放入老年代
        2. 老年代 Tenured Gen 存放JVM认为生命周期比较长的对象（经过几次的Young Gen的垃圾回收后仍然存在）
            1. 老年代内存不足触发Full GC
        3. Minor GC会触发stop the world 暂停其他用户线程直到垃圾回收结束，但时间较短
        4. 寿命阈值最大是15，原因是对象头信息中有4bit用来存储寿命
    6. 相关vm参数
        1. 堆初始大小 -Xms
        2. 堆最大大小 -Xms或-XX:MaxHeapSize=size
        3. 新生代大小 Xmn或（-XX:NewSize=size+-XX:MaxNewSize=size）
        4. 幸存区比例（动态）-XX:InitialSurvivorRatio=ratio和-XX:+UseAdaptiveSizePolicy
        5. 幸存区比例-XX:SurvivorRatio=ratio（默认是8，即百分之八十是伊甸园）
        6. 晋升阈值-XX:MaxTenuringThreshold=threshold
        7. 晋升详情-XX:+PrintTenuringDistribution
        8. GC详情-XX:+PrintGCDetails -verbose:gc
        9. FullGC前MinorGc -XX:+ScavengeBeforeFullGC
        10. -XX:+UseSerialGC调整虚拟机使用的垃圾回收器（串行垃圾回收期）
    6. 大对象直接加入老年代，即当对象过大时，老年代空间充足时，会直接加入到老年代
    7. 注意，线程出现内存溢出时，不会导致其他线程结束
    8. 垃圾回收器
        1. 串行垃圾回收器
            1. 单线程
            2. 堆内存较小，适合PC
            3. -XX:+UseSerialGC=Serial+SerialOld，复制算法和标记整理算法
        2. 吞吐量优先垃圾回收器
            1. 多线程
            2. 堆内存较大，需要多核CPU支持
            3. 让单位时间内，stw的时间最短
            4. -XX:+UseParallelGC ~ -XX:+UseParallelOldGC（开启一个则默认开启另一个）
            5. 垃圾回收线程会开启多个，特点是垃圾回收发生时，CPU占用率飙升
            6. -XX:ParallelGCThreads=n 控制线程数
            7. -XX:+UseAdaptiveSizePolicy 动态调整堆区大小
            8. -XX:GCTimeRatio=ratio 尝试调整垃圾回收时间占比（原理是调整堆区大小）一般调整为0.05
            9. -XX:MaxGCpauseMillis=ms 尝试调整每次垃圾回收的时间（但与8矛盾，原因是堆区越大，单次垃圾回收时间越长）
        3. 响应时间优先垃圾回收器
            1. 多线程
            2. 堆内存较大，需要多核CPU支持
            3. 尽可能减小单次stw时间
            4. -XX:+UseConcMarkSweepGC ~ -XX:+UseParNewGC ~ SerialOld，可以部分和用户线程并发工作 工作在老年代、新生代，或在工作失败时退化为串行垃圾回收器 标记清除算法
            5. 初始标记（stw）->并发标记->重新标记（stw）->并发清理
            6. -XX:ParallelGCThreads=n ~ -XX:ConcGCThreads=threads 前一个参数同2，后一个参数一般设置为CPU线程数的1/4
            7. 垃圾回收时CPU占用并不高，但考虑到用户的线程可用于计算的线程，即吞吐量有影响
            8. -XX:CMSInitiatingOccupancyFraction=percent 控制垃圾回收的时机，预留给一些空间给浮动垃圾，早期JVM默认值为65%左右
            9. -XX:+CMSScavengeBeforeRemark在重新标记前进行一次垃圾回收
            10. 当并发失败时即标记清除算法失败时，响应时间会飙升，这也是该算法的缺点
        4. Garbage First（G1）
            1. JDK9才成为默认垃圾回收器
            2. 同时注重吞吐量和低延迟，默认在听目标是200ms
            3. 适合超大堆内存，会将堆划分为多个大小相等的Region
            4. 整体上是标记整理算法，两个区域之间是复制算法
            5. -XX:+UseG1GC
            6. -XX:G1HeapRegionSize=size
            7. -XX:MaxGCPauseMillis=time
            8. Young Collection ~ Young Collection+Concurrent Mark ~ Mixed Collection 往复进行
            9. Young Collection
                1. 触发stw 将伊甸园Eden复制算法移入Suvivor
                2. Suvivor晋升到Old或另一个Suvivor
            10. Young Collection+Concurrent Mark
                1. 初始标记（新生代GC时）
                2. 老年代占用空间达到阈值（不会STW）-XX:InitiatingHeapOccupancyPercent=percent（默认45%）
            11. Mark ~ Mixed Collection
                1. 对E、S、O进行全面的垃圾回收
                2. 最终标记和拷贝存活会STW
                3. -XX:MaxGCPauseMillis=ms调整最大暂停时间，如果老年代太大无法全部复制，G1会选择认为价值比较高的进行复制
            12. 当垃圾回收速度跟不上垃圾产生速度则才会Full GC
            13. 跨带引用问题
                1. 老年代可以细分为卡表
                2. 当老年代的卡引用新生代，就被标记为脏卡 以减少搜索范围
                3. 新生代通过Remebered Set记录脏卡 脏卡的
                4. 引用变更时通过post-write barrier+dirty card queue异步更新脏卡
            14. Remark阶段
                1. 在对象引用改变前，加入写屏障pre-write barrien+satb_mark_queue，并加入标记队列
            15. JDK8U20
                1. 字符串去重，当新生代垃圾回收时，G1并发检查是否有字符串重复，如果有会让他们引用一个相同的char[]
                2. -XX:+UseStringDeduplication 默认开启
            16. JDK8u40并发标记类卸载
                1. 所有对象都经过并发标记后，就能知道哪些类不再被使用，当一个类加载器的所有类都不再使用，则卸载它所加载的所有类
                2. -XX:ClassUnloadingWithConcurrentMark 默认开启
            17. JDK8u60回收举行对象
                1. 一个对象大于region的一半时，称之为巨型对象
                2. G1不会对巨型对象进行拷贝
                3. 回收时被优先考虑
                4. G1会跟踪老年代所有incoming引用，这样老年代引用为0的巨型对象就会被新生代垃圾回收时处理掉
            18. JDK9并发标记起始时间的调整
                1. 并发标记必须在对空间占满前完成，否则退化成FullGC
                2. JDK9之前需要使用-XX:InitiatingHeapOccupancyPercent
                3. JDK9可以动态调整
                    1. -XX:InitiatingHeapOccupancyPercent用来设置初始值
                    2. 进行数据采样并动态调整
                    3. 总会添加一个安全的空档空间
            ......
    9. 垃圾回收调优
        1. java -XX:+PrintFlagsFinal -version / findstr "GC" 查看虚拟机运行参数
        2. 调优领域
            1. 内存
            2. 锁竞争
            3. cpu占用
            4. io
        3. 垃圾回收调优目标
            1. 低延迟？高吞吐量？，选择合适的回收器
            2. 低延迟可以选择CMS，G1，ZGC（JDK9推荐使用G1）
            3. 高吞吐量ParallelGC
        4. Zing也是一个新的垃圾回收器
        5. 最快的GC是不发生GC
            1. 数据是否太多
            2. 数据表示是否太臃肿 一个对象最少占用16B，包括包装对象
            3. 是否存在内存泄露 不建议使用java实现，可以用第三方缓存实现 如果实在需要可以考虑软、弱引用
        6. 新生代调优
            1. TLAB thread-local allocation buffer 所有的new操作的内存分配非常廉价
            2. 死亡对象的回收代价是零
            3. 大部分对象用过即死亡
            4. -Xmn设置新生代的初始和最大值 oracle建议25%以上50%以下
            5. 新生代太小会导致GC频繁，太大会导致GC时间过长，所以找到一个合理的吞吐量极值是调优的目的
            6. 理想情况是 请求-响应 * 并发量 的数据
            7. 幸存区（当前活跃对象+需要晋升对象）
            8. 幸存区不足是会将寿命没有达到阈值的对象移入老年代，这样会导致老年代的对象需要Full GC才能回收
            9. 但有些对象我们需要提前移到老年代，这里可以调整最大晋升阈值-XX:MaxTenuringThreshold=threshold    -XX:+PrintTenuringDistribution
        7. 老年代调优
            1. CMS的来年代内存越大越好，避免浮动垃圾使得CMS退化成串行垃圾回收器
            2. 先尝试不做调优，如果没有Full GC则不用调优
            3. 将老年代内存预设调大-XX:CMSInitiatingOccupancyFraction=percent甚至可以设置为0，一般设置为75%~80%之间预留给浮动垃圾
10. 类加载
    1. 类文件结构
        1. 4B 魔数 java的魔术是CA FE BA BE
        2. 4B 版本 52 JDK8
        3. 2B 常量池长度 不记录第0项
        4. 1B 0a是方法，4B 所属类、方法名  
    2. 类加载子系统ClassLoader
        1. 加载阶段
            1. 引导类加载器（启动类加载器）（C和C++编写，通过java无法获取到）
                1. 用于加载java核心类库
                2. 不继承java的类加载器
                3. 加载扩展类和应用程序类加载器，并制定为他们的父类加载器
                4. 出于安全考虑，Bootstrap启动类加载器只加载名为java、javax、sun等开的类
            2. 扩展类加载器
                1. java语言编写
                2. 派生于ClassLoader类
                3. 从java.ext.dirs系统属性所指定的目录中加载类库，或从JDK的安装目录jre/lib/ext子目录下加载类库，如果用户创建的jar放在此目录下，也会自动由扩展类加载器加载
            3. 系统类加载器（应用程序加载器）
                1. java语言编写
                2. 派生于ClassLoader类
                3. 父类加载器为扩展类加载器
                4. 他负责加载环境变量或系统属性java.class.path指定路径下的类库
                5. 该类加载时程序中默认的类加载器，一般来说，java应用的类库都是由它来完成加载
        2. 连接阶段
            1. 验证
                1. 文件格式验证
                2. 元数据验证
                3. 字节码验证
                4. 符号引用验证
            2. 准备
                1. 为类变量分配内存并且设置该类变量的默认初始值
                2. 这里不包含用final修饰的static，因为编译时就会被分配
                3. 这里不会为实例变量分配初始化
            3. 分析（解析）
                1. 符号引用转化为直接引用
        3. 初始化阶段
            1. 初始化阶段就是执行类构造方法<clinit>()的过程
            2. 此方法不需要定义，是javac编译器自动收集类中所有类变量的赋值动作和静态代码块中的语句合并而来
            3. 它不同于类的构造器，类的构造器函数是<init>
            4.
        4. ClassLoader只负责class文件加载，能否运行则由Execution Engine决定
        5. getClassLoader可以查看是哪个类加载器加载了这个类
        6. 用户自定义类加载器
            1. 隔离加载类
            2. 修改类加载的方式
            3. 扩展加载源
            4. 防止源码泄露
        7. ClassLoader类（抽象类）
            1. loadClass
            2. findClass
            3. defindClass
            ...
        8. 拿到当前类类加载器
            1. getClassLoader通过类拿到加载器
            2. getContextClassLoader通过线程拿到加载器
            3. 通过加载器获取加载器
            ....
    3. 双亲委派机制
        1. java虚拟机对class文件采用的是按需加载的方式
        2. 加载类文件时，采用双亲委派机制，把请求交由父类处理
        3. 工作原理
            1. 如果一个类加载器收到了类加载请求，他并不会自己先去加载，而是把这个请求委托给父类的加载器执行
            2. 如果父类加载器还存在其父类加载器，则进一步向上委托，一次递归，请求最终将到达顶层的启动类加载器
            3. 如果父类加载器可以完成类加载任务，就成功返回，倘若父类加载器无法完成次加载任务，子加载器才会尝试自己去加载
        4. 作用
            1. 防止类的重复加载
            2. 保护核心类（沙箱安全机制）
        5. 判断两个class对象是否为同一个类存在的两个必要条件
            1. 类的完整类名必须一致，包括包名
            2. 加载这个类的ClassLoader（实例对象）必须相同
        6. JVM必须知道一个类型是由启动类加载器加载还是由用户类加载器加载的，JVM会将用户类加载器加载的类的这个加载器的一个引用作为类型信息的一部分保存在方法区中
        7. java程序对类的加载分为主动使用和被动使用
            1. 主动使用
                1. 创建类的实例
                2. 访问某个类或接口的静态变量，或者对该静态变量赋值
                3. 调用类的静态方法
                4. 反射
                5. 初始化一个类的子类
                6. Java虚拟机启动时被表明为启动类的类
                7. JDK7开始提供的动态语言支持
            2. 除了以上情况java类的使用都被看作是对类的被动使用都不会导致类的初始化