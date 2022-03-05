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
    1. 事务
        1. multi ... exec 开启事物，执行事物
        2. discard 取消事务
        3. 正确的语句会执行，错误的语句会报错并忽略，且不会回滚
        4. 由于没有回滚功能故redis在应用中偏少
    2. 锁
        1. watch key1 [key2...]
        2. 监控属性，若key改变则事务不会执行
        3. 开启事务前进行监控
        4. unwatch 全部取消监控
    3. 分布式锁
        1. setnx lock-key value
        2. del删除锁
        3. expire lock-key second 设置锁时效性
        4. 锁时间设定推荐 最大耗时*120%+平均网络延迟*110%
11. 删除策略
    1. 数据删除策略
        1. 定时删除 CPU压力大
        2. 惰性删除 内存压力大
        3. 定期删除
            1. server.hz 每秒中执行serverCron次数
            2. 调用databasesCron轮询数据库，每秒执行server.hz次
            3. activeExpireCycle对每个expires[*]注意进行检测，每次执行1/4s /server.hz
            4. 对某个expires[*]检测时，随机挑选W个key检测
                1. 如果key超时，删除key
                2. 如果一轮中删除的key数量>w*25%，循环该过程
                3. 小于则执行下个一数据库
                4. W=ACTIVE_EXPIRE_CYCLE_LOOKUPS_PER_LOOP
            5. current_db用来记录activeExpireCycle进入哪个expires[*]执行
        4. 其实就是维护expires哈希表
    2. 数据删除策略的目标 在内存占用与CPU占用之间寻找一种平衡
    3. 逐出算法
        1. maxmemory 最大可使用内存 默认值0，表示不限制，通常设置50%以上
        2. maxmemory-samples 每次选取待删除数据的个数
        3. maxmemory-policy 删除策略
        4. 逐出策略
            1. 检测易失性数据（可能会过期的数据集server.db[i].expires）
                1. volatile-lru 最近最久未使用
                2. volatile-lfu 最近使用次数最少
                3. volatile-ttl 将要过期数据
                4. volatile-random 随机
            2. 全库数据（所有数据集server.db[i].dict）
                1. allkeys-lru
                2. allkeys-lfu
                3. allkeys-random
            3. 放弃数据逐出
                1. no-enviction（redis4.0默认策略）
12. 服务器基础配置
    1. 基础配置
        1. 设置服务器以守护进程方式运行 daemonize yse|no
        2. 绑定主机地址 bind 127.0.0.1
        3. 设置服务端口号 port 6379
        4. 设置数据库数量 databases 16
    2. 日志
        1. loglevel debug|verbose（默认）|notice|warning
        2. logfile 端口号.log
    3. 客户端
        1. 客户端最大连接数 maxclients 0
        2. 超时时长 timeout 300
    4. 多服务器快捷配置
        1. include /path/server-端口号conf
13. 高级数据类型
    1. Bitmaps
        1. setbit key index value
        2. getbit key index
        3. 本质是string默认补0
        4. 统计指定key中1的数量 bitcount key [start end]
        5. 位运算 bitop op destKey key1 [key2...]
            1. and
            2. or
            3. not
            4. xor
    2. HyperLogLog
        1. 统计不重复数据的数量 基数统计
        2. HyperLoglog算法
        3. pfadd key element [element ...] 添加数据
        4. pfcount key [key ...] 统计数据
        5. pfmerge destkey sourcekey [sourcekey...] 合并数据
        6. 估算算法 误差约0.81%
    3. GEO
        1. 坐标运算数据类型
        2. 添加坐标点 geoadd key longitude latitude member [longitude latitude member ...]
        3. 获取坐标 geopos key member [member ...]
        4. 计算坐标点距离 geodist key member1 member2 [unit]
        5. 根据坐标求范围内的数据 georadius key longitude latitude redius m|km|ft|mi [withcoord] [withdist] [withhash] [count count]
        6. 根据点求范围内数据 georadiusbymember key member radius m|km|ft|mi [withcoord] [withdist] [withhash] [count count]
        7. 获取指定点对应坐标hash值
        8. geohash key member [member ...]
        9. 估算值
14. redis集群
    1. 主从复制
        1. 互联网“三高”架构 高并发 高性能 高可用
        2. 业界可用性目标5个9，99.999%，即服务器年宕机时长低于315秒，约5.25分钟
        3. 为了避免单点Redis服务器故障，准备多台服务器，互相联通。将数据复制多个副本保存在不同的服务器上，连接在一起，并保证数据是同步的。即使有其中一台服务器宕机，其他服务器依然可以继续提供服务，实现Redis的高可用，同时实现数据冗余备份
            1. 提供数据方 master
                1. 写数据
                2. 执行写操作时，将出现变化的数据自动同步到slave
                3. 读数据（可忽略）
            2. 接收数据方 slave
                1. 读数据
                2. 写数据（禁止）
            3. 解决数据同步问题
        4. 主从复制即将master中的数据即使、有效的复制到slave中
        5. 一个master可以拥有多个slave，一个slave只对应一个master
        6. 作用
            1. 读写分离
            2. 负载均衡
            3. 故障恢复
            4. 数据冗余
            5. 高可用基石
    2. 工作流程
        1. 建立连接阶段
            1. 流程
                1. slave发送指令 slaveof ip port
                2. master接收到指令相应对方
                3. slave保存master的ip与端口 masterhost masterport
                4. slave根据保存的信息创建连接master的socket
                5. slave周期性发送命令ping
                6. master响应pong
                7. slave发送指令 auth password
                8. master验证授权
                9. slave发送指令 replconf listening-port<port-number>
                10. master保存slave的端口号
            2. 实现
                1. 方式一 客户端发送命令 slaveof <masterip> <masterport>
                2. 方式二 启动服务器参数 redis-server -slaveof <masterip> <masterport>
                3. 方式三 服务器配置 slaveof <masterip> <masterport>
                4. slaveof no one断开主从复制
            3. 授权访问
                1. master配置文件设置密码 requirepass <password>
                2. master客户端发送命令设置密码 config set requirepass <password>、config get requirepass
                3. slave客户端发送命令设置密码 auth <password>
                4. slave配置文件设置密码 masterauth <password>
                5. 启动客户端设置密码 redis-cli -a <password>
        2. 数据同步阶段
            1. 流程
                1. slave请求数据同步
                2. mastere创建RDB同步数据
                3. slave恢复RDB同步数据
                4. slave请求部分同步数据
                5. slave恢复部分同步数据
                6. 即全量复制和部分复制
            2. 详细实现
                1. slave发送指令 psync2
                2. master执行 bgsave
                3. master接受第一个slave连接时，创建命令缓冲区
                4. master生成RDB文件，通过socket发送给slave
                5. slave接受RDB，清空数据，执行RDB文件恢复过程
                6. slave发送命令告知RDB恢复已经完成
                7. master发送复制缓冲区信息
                8. slave接受信息，执行bgrewriteaof复制数据
            3. 注意
                1. 避免高峰期同步
                2. 避免复制缓冲区溢出，避免全量复制周期太长或增大缓冲区，否则会导致slave继续进行全量复制陷入死循环 repl-backlog-size 1mb（默认）
                3. master单机内存占用主机内存的比例不应过大，建议使用50%~70%，留下30%~50%的内存用于执行bgsave命令和创建复制缓冲区
                4. 为了米面slave进行全量复制、部分复制时服务器相应阻塞或数据不同步，建议关闭此期间的对外服务 slave-serve-stale-data yse|no
                5. 多个slave请求数据同步会占用大量带宽，故要适量错峰
        3. 命令传播阶段
            1. 命令传布阶段出现断网现象
                1. 短时间网络总段，部分复制
                2. 长时间网络中断，全量复制
            2. 部分复制的三个核心要素
                1. 服务器的运行id（run id）
                    1. 身份识别，多次运行多个id
                    2. 时一个随机的十六进制40位字符
                2. 主服务器的复制积压缓冲区
                    1. 队列
                    2. slave和master都记录偏移量offset
                    3. 服务器启动时，如果开启有AOF或被连接成为master节点，即创建复制缓冲区
                3. 主从服务器的复制偏移量
            3. 数据同步+命令传播工作流程
                1. slave发送指令 psync2 ? -1 （run id和offset）
                2. master执行bgsave生成RDB文件记录当前复制偏移量
                3. master发送+FULLRESYNC runid offset 通过socket发送REB文件给slave
                4. slave收到 +FULLRESYNC保存master的runid和offset清空当前全部数据，通过socket接受RDB文件，恢复RDB数据（到此进行完全量复制）
                5. slave发送 psync2 sunid offset
                6. master接受命令，判定runid是否匹配，判定offset是否在赋值缓冲区中
                7. master如果runid或offset有一个不满足（不符合runid或超出缓冲区），执行全量复制；如果runid或offset校验通过，前次offset和本次相同，忽略；如果前次offset和本次不同，发送+CONTINUE offset通过socket发送复制缓冲区中前次offset到本次offset的数据
                8. master收到+continul 保存master到offset接受信息后，执行bgrewriteaof，恢复数据（部分复制流程）
            4. 心跳机制
                1. slave心跳任务
                    1. 指令 REPLCONF ACK {offset}
                    2. 周期 1s
                    3. 作用1 汇报slave自己的赋值偏移量，获取最新的数据变更指令
                    4. 作用2 判断master是否在线
                2. master心跳
                    1. 指令 PING
                    2. 周期 由repl-ping-slave-period决定，默认10s
                    3. 作用 判断slave是否在线
                    4. 查询 INFO replication 获取slave最后一次连接时间间隔，lag项维持在0或1视为正常
                3. 注意事项
                    1. 当slave多数掉线，或延迟过高时，master为保障数据稳定性，将拒绝所有信息同步操作
                    2. min-slaves-to-write 2
                    3. min-slaves-max-lag 8
                    4. 当slave数量少于2个，或者所有slave的延迟都大于等于10s时，强制关闭master写功能，停止数据同步
                    5. slave数量由slave发送REPLCONF ACK命令做确认
                    6. slave延迟由slave发送REPLCONF ACK命令做确认
    3. 注意事项
        1. master内部创建master_replid变量，使用runid相同的策略生成，长度41位，并发送给所有slave
        2. 在master关闭时执行命令shutdown save，进行RDB持久化，将runid与offset保存到RDB文件中
            1. repl-id repl-offset
            2. 通过redis-check-rdb命令可以查看该信息
        3. master重启后加载RDB文件，回复数据
            1. 重启后，将RDB文件保存的repl-id与repl-offset加载到内存中
            2. master_repl_id=repl master_repl_offset=repl_offset
            3. 通过info命令可以查看该信息
        4. 作用 本机保存上次runid，重启后恢复该值，使所有slave认为还是之前的master
    4. 哨兵模式
        1. master宕机时将宕机的master下线，找一个slave作为master，通知所有的slave连接心得master，启动心得master与slave
        2. 配置哨兵
            1. 配置哨兵（参看sentinel.conf）
                1. port 26379 配置端口号
                2. dir /tmp 相关日志信息存放目录
                3. sentinel montor mymaster 127.0.0.1 6379 2，有几个哨兵认定master挂了则认定挂了 通常设定为 哨兵/2+1
                4. sentinel down-after-milliseconds mymaster 30000 判断连接时长单位ms
                5. sentinel parallel-syncs mymaster 1 一次有多少个服务器开始同步
                6. failover-timeout mymaster 180000 认定同步超时
            2. 启动哨兵 redis-sentinel sentinel-端口号.conf
        3. 工作原理
            1. 主要任务：主从切换
            2. 阶段一 监控
                1. 同步各个节点的状态信息 通过ping获取各个sentinel的状态（是否在线）
                2. 获取master的状态
                    1. runid
                    2. role：master
                    3. 各个slave的详细信息
                3. 获取所有slave的信息
                    1. runid
                    2. role
                    3. master_host、master_port
                    4. offset
                    ...
            2. 阶段二 通知阶段
            3. 阶段三 故障转移阶段
    5. 集群
        1. 集群就是使用网络将若干台计算机联通起来，并提供统一的管理方式，使其对外呈现单击的服务效果
        2. 集群作用
            1. 分散单台服务器的访问压力，实现负载均衡
            2. 分散单台服务器的存储压力，实现可扩展性
            3. 降低单台服务器宕机带来的业务灾难
        3. Redis集群机构设计
            1. 通过算法设计，计算出key应该保存的位置
            2. 将所有的存储空间计划切割成16384份（槽），每台主机保存一部分
        4. 集群内部通讯设计
        5. cluster-enabled yes 设置集群节点
        6. cluster-config-file node-6379.conf 设置启动配置文件
        7. cluster-node-timeout  单位ms 设置超时时间
        8. redis-trib.rb create --replicas 1(master的数量) 127.0.0.1:6379(master)（需要ruby版本支持）
        9. redis-cli -c启动客户端
        10. cluster nodes查看节点信息
    6. 缓存预热
    7. 缓存雪崩
    8. 缓存击穿
    9. 缓存穿透
    10. 性能指标监控
        1. 性能
            1. latency Redis 响应一个请求时间
            2. instantaneous_ops_per_sec 平均每秒处理请求总数
            3. hit rate（calculated） 缓存命中率（计算出来的）
        2. 内存
            1. used_memory 已使用内存
            2. mem_fragmentation_ratio 内存碎片率
            3. evicted_keys 由于最大内存限制被移除的key的数量
            4. blocked_clients 由于BLPOP,BRPOP,or BRPOPLPUSH而备阻塞的客户端
        3. 基本活动指标
            1. connected_clients 客户端连接数
            2. connected_slaves slave数量
            3. master_last_io_seconds_ago 最近一次主从交互之后的秒数
            4. keyspace 数据库中的key值总数
        4. 持久性指标
            1. rdb_last_save_time 最后一次持久化保存到磁盘的时间戳
            2. rdb_changes_since_last_save 自最后一次持久化以来数据库的更改数
        5. 错误指标
            1. rejected_connections 由于达到maxclient限制而备拒绝的连接数
            2. keyspace_misses key值查找失败（没有命中）次数
            3. master_link_down_since_seconds 主从断开的持续时间（以秒为单位）
        6. 工具
        7. 命令