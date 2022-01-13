SimpleDateFormat类
```
//        字符串和日期的相互转换

//        字符串转日期
        String day="2020/01/02 22:33:44";
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date=simpleDateFormat.parse(day);
        System.out.println(date);
        ---
        Thu Jan 02 22:33:44 CST 2020
        ---

//        日期转字符串
        Date date=new Date();
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String day=simpleDateFormat.format(date);
        System.out.println(day);
        ---
        2022/01/13 21:32:23
        ---

```