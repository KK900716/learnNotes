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
            3. float()
