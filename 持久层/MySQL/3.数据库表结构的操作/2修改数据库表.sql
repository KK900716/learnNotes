-- 修改数据库表
    -- 1.添加列
        -- 默认在已有列之后添加
    ALTER TABLE <表名> ADD <新列名> <数据类型> [约束条件] [FIRST|AFTER已存在列名]
        -- [FIRST|AFTER已存在列名]可以指定位置

        -- 示例
    alter table reader add email varchar(30);
    desc reader;
    
    alter table reader add email2 varchar(30) after tell;
    desc reader;

    -- 2.修改列名
    ALTER TABLE <表名> CHANGE <旧列名> <新列名> <新数据类型>
        -- 示例
    alter table reader change email email_bak char(30);
    desc reader;
    
    -- 3.修改列数据类型
    ALTER TABLE <表名> MODIFY <列名> <数据类型>
        -- 示例
    alter table reader modify email2 char(30);
    desc reader;

    -- 4.修改列的排列位置
    ALTER TABLE <表名> MODIFY <列1> <数据类型> FIRST|AFTER <列2>
        -- 示例
    alter table reader modify balance decimal(7,3) after email_bak;
    desc reader;

    -- 5.删除列
    ALTER TABLE <表名> DROP <列名>
        -- 示例
    alter table reader drop email2;
    desc reader;

    -- 6.修改表名
    ALTER TABLE <旧表名> RENAME [TO] <新表名>
        -- 示例
    alter table reader rename to readerinfo;
    show tables;