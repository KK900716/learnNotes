数据库存储引擎是数据库底层软件组件，数据库管理系统使用数据引擎进行创建、查询、更新和删除数据的操作

mysql的核心就是存储引擎
    1.mysql5.7支持InnoDB MyISAM Memory
        查看支持的存储引擎
        show engines;
    2.InnoDB提供了具有提交、回滚和崩溃恢复能力的事务安全存储引擎