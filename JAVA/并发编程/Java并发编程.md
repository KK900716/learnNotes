[TOC]

------

# Java并发编程

# 1. 前置知识

## 1.1 进程和线程

- 不同操作系统下进程和线程的含义可能略有不同，但大致如下

- 进程作为资源分配的单位
- 线程作为CPU调度的最小单位
- 一个进程可以有多个线程，进程间通信较为复杂，线程间通信更为简单
- 线程更轻量，不同线程间的上下文切换开销低于进程

## 1.2 并发和并行

- 并发（concurrent）一段时间能够应对多件事情的能力
- 并行（parallel）某一时刻能够同时去做多件事的能力

## 1.3 同步和异步

- 同步需要等待每条指令返回的结果到来后才能继续下条指令
- 异步不需要等待每条指令返回的结果到来就可以继续下条指令

## 1.4 I/O密集和CPU密集型应用

- 计算机需要为应用程序调度资源，其中I\O和CPU是应用程序所需的最重要的两个资源，其调度算法可参见操作系统相关书籍

- 现代操作系统几乎全部采用多处理器、分时操作系统（分时操作系统是使一台计算机采用时间片轮转的方式同时为几个、几十个甚至几百个用户服务的一种操作系统）

  ```java
  // 查看服务器核心数      
  System.out.println(Runtime.getRuntime().availableProcessors());
  ```

- I/O密集型应用期望能CPU使用率达到100%，则线程数设置

  - 理论上 核心数/（1-阻塞系数），阻塞系数=I/O等待时间/CPU占用时间+I/O等待时间，一般的I/O密集型应用阻塞系数在0.8~0.9之间
  - 经验上 核心数*2
  - 对我们的同步工具而言，就是I/O密集型应用，主要耗时在等待JDBC执行插入数据返回ACK时间
    - 所以理论上我们可以增大并发来进一步榨取CPU的能力

- CPU密集型通常设置线程数为 核心数+1

## 1.5 单体java应用实现并发的方法——多线程

- 通过Thread类创建线程，通过重写该类的run方法来执行我们编写的逻辑过程，通过Thread类的start方法启动线程

  ```java
  /* Make sure registerNatives is the first thing <clinit> does. */
      private static native void registerNatives();
      static {
          registerNatives();
      }
   /**
       * Initializes a Thread.
       *
       * @param g the Thread group
       * @param target the object whose run() method gets called
       * @param name the name of the new Thread
       * @param stackSize the desired stack size for the new thread, or
       *        zero to indicate that this parameter is to be ignored.
       * @param acc the AccessControlContext to inherit, or
       *            AccessController.getContext() if null
       * @param inheritThreadLocals if {@code true}, inherit initial values for
       *            inheritable thread-locals from the constructing thread
       */
      @SuppressWarnings("removal")
      private Thread(ThreadGroup g, Runnable target, String name,
                     long stackSize, AccessControlContext acc,
                     boolean inheritThreadLocals){...}
  
  /**
       * Causes this thread to begin execution; the Java Virtual Machine
       * calls the {@code run} method of this thread.
       * <p>
       * The result is that two threads are running concurrently: the
       * current thread (which returns from the call to the
       * {@code start} method) and the other thread (which executes its
       * {@code run} method).
       * <p>
       * It is never legal to start a thread more than once.
       * In particular, a thread may not be restarted once it has completed
       * execution.
       *
       * @throws     IllegalThreadStateException  if the thread was already started.
       * @see        #run()
       * @see        #stop()
       */
      public synchronized void start() {
          ...
              start0();
          ...
      }
  
  	private native void start0();
  ```

  ## 2. Java多线程实现

  ## 3. JVM级别锁，synchronized关键字及优化原理

  ## 4. JDK级别锁，Lock接口，及ReentrantLock实现类

  ## 5. CAS操作及原子类

  ## 6. 线程间通信、死锁、饥饿

  ## 7. AQS及JDK线程池

  ## 8. Java并发工具包

  ## 9. 新特性JDK19协程
  
  ## 10. Flink异步编程

