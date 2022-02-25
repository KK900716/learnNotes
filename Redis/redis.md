1. 下载
    1. windows下https://github.com/microsoftarchive/redis/releases/tag/
2. 数据类型
    1. string
    2. hash
    3. list
    4. set
    5. sorted_set
3. redis自身是一个map
4. 基本操作
    1. set key value
    2. get key
    3. del key
    4. integer1成功 0失败或运行结果 nil等同于null
    5. mset key1 value1 key2 value2 ...
    6. mget key1 key2 ...
    7. strlen key 获取数据字符个数（字符串长度）
    8. append key value追加信息到原始信息后部（没有则新建）
    9. string类型扩展操作
        1. 设置数值数据增加指定范围的值
            1. incr key
            2. incrby key increment
            3. incrbyfloat key increment
        2. 设置数值数据减少指定范围的值
            1. decr key
            2. decrby key increment
        3. 范围9223372036854775807，java中lang的最大值
        4. 设置一个数据指定的生命周期
            1. setex key seconds value
            2. psetex key milliseconds value
        5. string数据最大存储量512MB
        6. 命名约定
            1. 方案一
                1. key：表名:主键名:主键值:字段名
                2. value：值
            2. 方案二
                1. key：表名:列名:值
                2. value：json字符串
    10. hash
        1. 对一系列存储的数据进行编组，方便管理，典型应用存储对象信息
        2. 基本操作
            1. hset key field value
            2. hget key field
            3. hgetall key
            4. hdel key field1[field2]
            5. hmset key field1 value1 field2 value2 ...
            6. hmget key field1 field2 ...
            7. hlen key
            8. hexists key field
            9. 获取哈希表中所有的字段名或字段值
                1. hkeys key
                2. hvals key
            10. 设置指定字段的数值数据增加指定范围的值
                1. hincrby key field increment
                2. hincrby key field increment
            11. hash类型下的value只能存储字符串，不允许存储其他数据类型，不存在嵌套现象。如果数据未获取到，对应的值为nil
            12. 每个hash可以存储2^32-1个键值对
            13. hash设计初衷并不是用来存储大量对象
            14. hgetall操作内部的field过多，遍历效率会降低
    11. list
        1. lpush key value1 [value2] ...
        2. rpush key value1 [value2] ...
        3. lrange key start stop
        4. lindex key index
        5. llen key
        6. lpop key
        7. rpop key
        8. 双端队列
        9. 扩展操作
            1. 规定时间内获取并移除数据
                1. blpop key1 [key2] timeout
                2. brpop key1 [key2] timeout
            2. lrem key count value 移除指定数据
        10. list保存的都是string 容量有限2^32-1个元素
        11. 获取全部数据操作结束索引设置为-1
    12. set
        1. sadd key member1 [membeer2]
        2. smembers key
        3. srem key member1 [membeer2]
        4. sismember scard
        5. srandmember key [count]随机获取集合中指定数量的数据
        6. spop key随机获取并剔除某个数据
        7. 扩展操作
            1. 求两个集合的交、并、差集
                1. sinter key1 [key2]
                2. sunion key1 [key2]
                3. sdiff key1 [key2]
            2. 求两个集合的交、并、差集并存储到制定集合中
                1. sinterstore destination key1 [key2]
                2. sunionstore destination key1 [key2]
                3. sdiffstore destination key1 [key2]
            3. 将指定数据从原始集合中移动到目标集合
                1. smove source destination member
    13. sorted_set
        1. zadd key score1 member1 [score2 member2]
        2. zrange key start stop [WITHSCORES]
        3. zrevrange key start stop [WITHSCORES]
        4. zrem key member [member]