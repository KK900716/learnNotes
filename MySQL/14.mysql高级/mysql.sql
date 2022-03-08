-- 查询支持引擎
show engines;
-- 查询默认引擎和当前引擎
show variables like '%storage_engine%';
-- 建立单值索引
CREATE INDEX index_name ON user(column1);
-- 建立复合索引
CREATE INDEX index_name ON user(column1,column2);