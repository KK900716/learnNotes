DataFormat类
```
//        DataFormat类

//        日期格式化显示

        Date date=new Date();
//        获取日期
        DateFormat dateFormat0=DateFormat.getDateInstance();
        String time0=dateFormat0.format(date);
        ---
        2022年1月13日
        ---
//        获取日期时间
        DateFormat dateFormat1=DateFormat.getDateTimeInstance();
        String time1=dateFormat1.format(date);
        ---
        2022年1月13日 下午9:22:30
        ---
```
