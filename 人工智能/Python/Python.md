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
    