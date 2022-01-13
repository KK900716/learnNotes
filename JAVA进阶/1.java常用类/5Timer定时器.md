Timer定时器
1.Timer类需要和TimerTask类配合使用
```
        Timer timer=new Timer();//控制定时任务的执行方式
        TimerTask task=new TimerTask() {
            @Override
            public void run() {//定义定时任务的执行内容
                System.out.println("定时任务被执行！");
            }
        };
//        1.一段时间后执行任务
        timer.schedule(task,3000);//单位ms
//        2.固定的时间点执行任务
        timer.schedule(task,new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse("2022/01/01"));
//        3.重复执行任务
        timer.schedule(task,2000,1000);//多长时间后执行，执行频率即2s后开始执行，1s执行一次
```