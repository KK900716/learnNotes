1. 保留字
    1. 代码
    ```
    import keyword
    print(keyword.kwlist)
    ```
    2. 保留字['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']
2. 数据类型
    1. id() type()
    2. 多次赋值地址发生变化
    3. 数据类型
        1. int
            1. 0b 二进制
            2. 0o 八进制
            3. 0x 十六进制
        2. float
            1. 浮点数存储不精确
            2. 解决方案decimal
            ```
            from decimal import Decimal
            print(Decimal('1.1') + Decimal('2.2'))
            ```
        3. bool True False
            1. 默认True=1
            2. False=0
        4. str
            1. 单引号、双引号不能换行
            2. 三引号可以换行
        5. 数据类型转换
            1. str()
            2. int()
            3. float() 整数转换后会加.0
3. 注释
    1. #开头 单行注释
    2. 三引号之间的代码可以被视为多行注释
    3. #coding:utf-8 #coding:gbk可以标注中文编码声明注释
4. 运算符
    1. input()函数 返回输入值
    2. 运算符
        1. 算数运算符
            1. 标准运算符
                1. +
                2. -
                3. *
                4. / 除
                5. // 整除
            2. 取余运算符 %
            3. 幂运算符 **
        2. 赋值运算符
            1. 执行顺序从右到左
            2. 支持+= ...
            3. 支持系列解包赋值 a,b,c=1,2,3
        3. 比较运算符
            1. 常规的>等
            2. is is not 对对象的id进行比较
            3. ==对value进行比较
        4. 布尔运算符
            1. and or not in not in
        5. 位运算符
            1. 与&
            2. 或|
            3. <<左移
            4. >>右移
5. 控制结构
    1. Python一切皆对象使用bool()获取对象的布尔值
    2. if elif else
    3. pass语句可以置空语句占位
    4. 内置函数range()创建并返回一个序列
        1. range(stop)创建一个[0,stop)之间的整数序列，步长为1
        2. range(start,stop)创建一个[start,stop)之间的整数序列，步长为1
        3. range(start,stop,step)创建一个[start,stop)之间的整数序列，步长为step
        4. 优点，当用到range函数时才会计算序列中的相关元素
    5. while 循环
    6. for-in 循环 for x in range(10): for _ in range(10):
    7. break 语句结束循环
    8. continue 结束当前循环进入下一次
    9. else 可以搭配 while和for进行，即循环正常执行完成即会执行else
6. 集合
    1. 列表（数组）
        1. type list
        2. list()创建或直接[]创建
        3. index()可以获取目标值索引，只返回第一个，可以添加参数start、stop，在指定区间查找
        4. 切片list[start:stop:step]步长默认为1，start默认0，stop默认size，步长为负数则倒叙
        5. 判断是否在列表中存在采用 in 、 not in
        6. 列表元素操作
            1. 添加
                1. append 增加一个元素
                2. extend 增加至少一个元素
                3. insert 任意位置添加元素
                4. 切片，在列表的任意位置添加至少一个元素
            2. 删除
                1. remove 移除第一个指定的元素，不存在会抛异常
                2. pop 删除一个指定索引位置上的元素，无参则弹出最后一个元素
                3. 若不想改变对象指针，可以用切片赋值空列表
                4. clear清除全部
                5. del删除对象
            3. 改
                1. 直接赋值
                2. 指定切片赋新值
            4. 排序sort(reverse=True)默认升序
            5. sorted排序会产生新列表
        7. 产生一个集合 list1 = [i for i in range(1, 10)]
    2. 字典
        1. 字典是一个无序的拥有键值对的序列
        2. key必须是不可变即str
        3. 字典创建 {键=值,键=值} dict(键=值,键=值) 注意内置函数方式键不用加引号
        4. 获取数据可以使用[]或get
            1. 查找失败会导致异常
            2. 查找失败会返回None，可以指定一个参数，当失败时返回指定参数
        5. 字典常用操作
            1. del、clear
            2. 新增可以直接赋值，修改可以直接修改
        6. 获取所有key keys 数据类型dict_keys
        7. 获取字典所有value values 数据类型dict_values
        8. 获取字典中所有key、value items 转换list后的元素是元组
        9. list将所有的key组成的视图转成列表
        10. 迭代字典的值是键
        11. 获取可以用get或直接[]
        12. 字典生成式
            1. zip()
            2. {key:value for key,value in zip(keys,values)} 若keys和values大小不等则取小
            3. .upper() 转换大写
    3. 元组
        1. 不可变序列
        2. 用小括号定义的
        3. 没有增删改查操作
        4. 创建方式
            1. ()
            2. tuple(())
        5. 需要注意如果元组只有一个元素，逗号不能省略
        6. 空元组的创建方式同空字典或空列表
        7. 元组的遍历
            1. 使用索引
            2. for in遍历
    4. 集合
        1. 可变类型
        2. 没有value的字典，类似于set，不允许重复且无序
        3. 创建{a,b} set()
        4. 新增
            1. add()
            2. update()至少添加一个
        5. 删除
            1. remove()失败抛出异常
            2. discard()失败不会抛出异常
            3. pop()删除一个任意元素
            4. clear()清空
    5. 集合运算
        1. == != 元素相同即相等
        2. issubset() 判断是否是子集
        3. issuperset() 判断是否是超集
        4. isdisjoint() 两个集合是否含有交集
        5. 运算
            1. 交集intersection() 、 &
            2. 并集union() 、 |
            3. 差集difference() 、 -
            4. 对称差集symmetric_different() 、 ^
        6. 集合生成式
            1. [{i*i for i in range(1,10)}]
    6. 串
        1. 不可变
        2. 字符串驻留机制 仅保存一份字符串在内存中
            1. 0或1长度的字符串
            2. 含有标识符的字符串，字母数字下划线
            3. 字符串只在编译时进行驻留，而非运行时
            4. [-5，256]之间的整数数字
            5. sys中的intern方法强制2个字符串指向同一个对象
            6. Pycharm会对字符串进行优化
        3. 查询方法
            1. index 查找子串第一次出现的位置 不存在抛出异常
            2. rindex 查找子串最后一次出现的位置 不存在抛出异常
            3. find 查找子串第一次出现的位置 不存在返回-1
            4. rfind 查找子串最后一次出现的位置 不存在返回-1
        4. 大小写转换
            1. upper
            2. lower
            3. swapcase 所有大写转小写，所有小写转大写
            4. capitalize 把第一个字符转大写，其余小写
            5. titel 每个单词第一个字符转大写，其余转小写
        5. 对齐操作
            1. center 居中对齐 第一个参数指定宽度，第二个参数指定填充符（可选），如果小于实际宽度则返回原字符串
            2. ljust 左对齐 第一个参数指定宽度，第二个参数指定填充符（可选），如果小于实际宽度则返回原字符串
            3. rjust 右对齐 第一个参数指定宽度，第二个参数指定填充符（可选），如果小于实际宽度则返回原字符串
            4. zfill 右对齐，左边用0填充 参数为字符串宽度，如果小于实际宽度则返回原字符串
        6. 字符串劈分操作
            1. split 默认空格字符 返回一个列表 sep指定劈分符，maxsplit指定最大劈分次数
            2. rsplit 从右边开始劈分
        7. 判断方法
            1. isidentifier 判断指定的字符串是不是合法的标识符
            2. isspace 判断指定的字符串是否全部由空白符组成（回车、换行、水平制表符）
            3. isalpha 判断指定的字符串是否全部由字母组成
            4. isdecimal 判断指定字符串是否全部由十进制的数字组成
            5. isnumeric 判断指定的字符串是否全部由数字组成
            6. isalnum 判断指定字符串是否全部由字母和数字组成
        8. 字符串常用操作
            1. replace 第一个参数指定替换的字符串，第二个参数指定替换子串第字符串，第三个参数指定最大替换次数
            2. join将列表或元组中的字符串合并成一个字符串
        9. 字符串比较可以直接采用比较符号比较
        10. 字符串切片操作与列表类似，但不能进行增删改
        11. 格式化字符串
            1. 例如 print('%s,%d' % (name,age))  %s字符串 %d %i整数 %f浮点数，其他情况类似C语言
            2. '{0}{1}'.format(name,age)
            3. f'{name}{age}'
