# Merge into syntax

- sql：2003 standard

  ```sql
  MERGE INTO table_table [AS t_alias]
  USING source_table [AS s_alias]
  		ON (condition)
      WHEN MATCHED THEN
      	UPDATE SET ...
      WHEN NOT MATCHED THEN
      	INSERT ...
  ```

  