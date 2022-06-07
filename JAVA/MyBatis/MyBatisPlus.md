[TOC]

------



## MyBatis Plus

1. 依赖

```xml
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.1</version>
</dependency>
```

2. 其他相关依赖
2. 在Mapper层继承BaseMapper

## 使用

1. 直接进行使用
2. 日志

```yml
mybatis-plus:
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

3. BaseMapper中的方法
   1. insert
   2. delete
      1. byid，通过id
      2. bymap，map即为条件
      3. batchids，通过集合删除
   3. update
   4. select
4. id时使用雪花算法生成