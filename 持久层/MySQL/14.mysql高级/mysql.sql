-- 查询支持引擎
show engines;
-- 查询默认引擎和当前引擎
show variables like '%storage_engine%';
-- 建立单值索引
CREATE INDEX index_name ON user(column);
-- 建立复合索引
CREATE INDEX index_name ON user(column1,column2);
-- 显示所有索引
SHOW INDEX FROM table
-- 添加数据表索引
ALTER TABLE table ADD PRIMARY KEY(column);/*主键*/
ALTER TABLE table ADD UNIQUE index_name (column);/*唯一索引*/
ALTER TABLE table ADD INDEX index_name (column);/*普通索引*/
ALTER TABLE table ADD FULLTEXT index_name (column);/*全文索引*/