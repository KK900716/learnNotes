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
        5. 按条件获取数据
            1. zrangebyscore key min max [WITHSCORES] [LIMIT]
            2. zrevrangebyscore key min max [WITHSCORES] [LIMIT]
        6. 按条件删除数据
            1. zremrangebyrank key start stop
            2. zremrangebyscore key min max
        7. 获取集合数据总量
            1. zcard key
            2. zcount key min max
        8. 集合交、并操作
            1. zinterstore destination numkeys key [key ...]
            2. zunionstore destination numkeys key [key ...]
        9. 扩展操作
            1. 获取数据对应索引
                zrank key member
                zrevrank key member
            2. score值获取与修改
                zscore key member
                zincrby key increment member
        10. 注意事项
            1. score保存的数据存储空间时64b，可以存浮点数
            2. 基于set结构，数据不能存储
5. key基本操作
    1. del key删除指定key
    2. exists key获取key是否存在
    3. type key获取key的类型
    4. 扩展操作
        1. 时效性控制
            1. 为指定key设置有效期
                1. expire key seconds
                2. pexpire key milliseconds
                3. expireat key timestamp
                4. pexpireat key milliseconds-timestamp
            2. 获取key的有效时间
                1. ttl key
                2. pttl key
            3. 切换key从时效性转换为永久性persist key
        2. 查询key
            1. keys pattern
            2. *查询所有
            3. ？配合一个任意符号
            4. []匹配一个指定符号
        3. 其他
            1. 改名
                1. rename key newekey
                2. renamenx key newkey
            2. 对所有key排序sort
            3. 其他key通用操作
                1. help @generic
6. 数据库通用指令
    1. reis为每个服务提供有16个数据库
    2. select index切换数据库
    3. quit ping echo
    4. move key db 数据移动
    5. dbsize
    6. flushdb flushall清楚数据
7. Jedis
    1. 坐标
    ```
        <dependency>
            <groupId>redis.clients</groupId>
            <artifactId>jedis</artifactId>
            <version>2.9.0</version>
        </dependency>
    ```
    2. 案例
    ```
        Jedis jedis = new Jedis("127.0.0.1", 6379);
        System.out.println(jedis.set("abc", "def"));
        jedis.close();
    ```
    3. JedisUtil
        1. 数据库连接池
        2. JedisPool
            1. poolConfig
            2. host
            3. port
            ```
            public class JedisUtil {
                private static JedisPool  jedisPool;
                static {
                    ResourceBundle resourceBundle=ResourceBundle.getBundle("redis");
                    JedisPoolConfig jedisPoolConfig=new JedisPoolConfig();
                    jedisPoolConfig.setMaxTotal(Integer.parseInt(resourceBundle.getString("redis.maxTotal")));
                    jedisPoolConfig.setMaxIdle(Integer.parseInt(resourceBundle.getString("redis.maxIdle")));
                    jedisPool=new JedisPool(jedisPoolConfig,resourceBundle.getString("redis.host"),Integer.parseInt(resourceBundle.getString("redis.port")));
                }
                public static Jedis getJedis(){
                    return jedisPool.getResource();
                }
            }
            ```
8. redis高级
    1. linux下使用redis
        1. 先使用make编译
        2. 进入src执行./redis-server
        3. 进入src执行./redis-cli
    2. ./redis-server --port 端口号
    3. ./redis-cli -p 端口号
    4. redis.conf配置文件 cat redis.conf | grep -v "#" | grep -v "^$"
        1. daemonize no 守护进程，用来处理日志信息
        2. logfile "" 日志文件
        3. dir ./ 生成日志文件位置
        4. redis-server 配置文件名
        5. ps -ef | grep redis-查看链接状态
        6. 可以将配置文件提取出来，进而可以启动多个服务
9. 持久化
    1. 简介
        1. 利用永久性存储介质将数据进行保存，在特定的时间将保存的数据进行恢复的工作机制成为持久化
        2. 防止数据的意外丢失，确保数据安全性
    2. 数据持久化的方案
        1. 快照RDB
            1. save保存当前快照信息
            2. dbfilename 设置本地数据文件名，通常设置dump-端口号.rdb
            3. dir 设置存储.rdb文件的路径 通常设置成存储空间较大的目录中，目录名称data
            4. rdbcompression yes 设置存储至本地数据库时是否压缩数据，默认为yes，采用LZF压缩 通常默认为开启状态，如果设置为no，可以节省CPU运行时间，但会使存储的文件变大（巨大）
            5. rdbchecksum yes 设置是否进行RDB文件格式校验，该校验过程在写文件和读文件过程均进行 通常默认为开启，如果设置为no，可以节约读写性过程约10%时间消耗，但时存在一定的数据损坏风险
            6. redis启动时会自动加载数据
            7. 工作原理
                1. 单线程工作时，阻塞io进行备份，会降低效率
                2. bgsave，后台执行save 用于解决1的问题（建议线上使用）
            8. 自动执行快照指令(bgsave模式)
                1. save second changes满足限定时间范围内key的变化数量达到制定数量即进行持久化
                2. second：监控时间范围
                3. changes：监控key的变化量
            9. debug reload 服务器运行中重启
            10. shutdown save 关闭服务器保存数据
        2. 日志AOF
            1. 写数据的三重策略（appendfsync）
                1. always每次
                2. everysec每秒 默认配置
                3. no系统控制 操作系统操作，不可控
            2. appendonly yse|no 开启对AOF支持
            3. appendfsync 开启策略
            4. AOF重写
                1. 作用
                    1. 降低磁盘占用率，提高磁盘利用率
                    2. 提高持久化效率，降低持久化写时间，提高IO性能
                    3. 降低数据恢复用时，提高数据恢复效率
                2. aof重写原则
                    1. 进程超时数据不再写入文件
                    2. 忽略无效指令
                    3. 对同一数据多条写命令合并为一条命令
                3. 命令 
                    1. bgrewriteaof手动重写（后台重写）
                    2. 自动重写
                        1. 自动重写触发条件设置
                            1. auto-aof-rewrite-min-size size
                            2. auto-aof-rewrite-percentage percent
                        2. 自动重写触发比对参数（运行指令info Persistence获取具体信息）
                            1. aof_current_size
                            2. aof_base_size
                        3. 自动重写触发条件
                            1. aof_current_size>auto-aof-rewrite-min-size
                            2. aof_current_size-aof_base_size / aof_base_size >= auto-aof-rewrite-percentage
        3. RDB和AOF对比
        ```
        持久化方式      占用存储空间        存储速度        恢复速度        数据安全性      资源消耗        启动优先级
        RDB           小（数据级：压缩）      慢            快           会丢失数据      高/重量级          低
        AOF           大（指令级：重写）      快            慢           依策略决定      低/轻量级          高
        ```
    3. 根据业务场景选择RDB和AOF
10. 事务
    1. multi ... exec 开启事物，执行事物
    2. discard 取消事务