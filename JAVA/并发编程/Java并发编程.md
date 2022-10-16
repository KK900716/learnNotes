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


# 2. Java多线程实现

## 2.1 继承Thread类，重写run方法

```java
        new Thread() {
            @Override
            public void run() {
                log.info("{}", "hello world!");
            }
        }.start();
```

## 2.2 实现Runnable接口

```java
        new Thread(() -> log.info("{}", "hello world!")).start();
```

## 2.3 实现Callable接口

```java
        FutureTask<String> futureTask = new FutureTask<>(() -> "hello world!");
        new Thread(futureTask).start();
        log.info("{}", futureTask.get());
```

## 2.4 线程池

```java
    /**
     * Creates a new {@code ThreadPoolExecutor} with the given initial
     * parameters.
     *
     * @param corePoolSize the number of threads to keep in the pool, even
     *        if they are idle, unless {@code allowCoreThreadTimeOut} is set
     * @param maximumPoolSize the maximum number of threads to allow in the
     *        pool
     * @param keepAliveTime when the number of threads is greater than
     *        the core, this is the maximum time that excess idle threads
     *        will wait for new tasks before terminating.
     * @param unit the time unit for the {@code keepAliveTime} argument
     * @param workQueue the queue to use for holding tasks before they are
     *        executed.  This queue will hold only the {@code Runnable}
     *        tasks submitted by the {@code execute} method.
     * @param threadFactory the factory to use when the executor
     *        creates a new thread
     * @param handler the handler to use when execution is blocked
     *        because the thread bounds and queue capacities are reached
     * @throws IllegalArgumentException if one of the following holds:<br>
     *         {@code corePoolSize < 0}<br>
     *         {@code keepAliveTime < 0}<br>
     *         {@code maximumPoolSize <= 0}<br>
     *         {@code maximumPoolSize < corePoolSize}
     * @throws NullPointerException if {@code workQueue}
     *         or {@code threadFactory} or {@code handler} is null
     */
    public ThreadPoolExecutor(int corePoolSize,
                              int maximumPoolSize,
                              long keepAliveTime,
                              TimeUnit unit,
                              BlockingQueue<Runnable> workQueue,
                              ThreadFactory threadFactory,
                              RejectedExecutionHandler handler)
```

## 2.5 常用API

### 2.5.1 run方法

- 通过重写run方法实现该线程的逻辑

### 2.5.2 start方法

- 用于启动这个线程
- 注意这个线程一旦运行完成，不能再次使用，不能重复调用start

### 2.5.3 Thread.sleep方法

- 休眠该线程，让出CPU使用权，单位毫秒
- TimeUnit.MINUTES.sleep 通过指定枚举类休眠该线程
- 注意当休眠结束时线程不会立刻占有CPU而是进入就绪状态同其他线程一样等待被调度

### 2.5.4 LockSupport.park、unpark(thread)方法

- 阻塞该线程，让出CPU使用权、结束该线程的阻塞状态进入就绪队列

### 2.5.5 Thread.interrupted方法

- 打断当前线程或使用线程调用该方法打断线程，使打断标记置为true
- 若线程在休眠，或在阻塞，将抛出InterruptedException异常
- 若线程处于阻塞状态被打断恢复运行时，请讲打断标记恢复为false，调用isInterrupted方法，否则下次打断无效

### 2.5.6 Thread.currentThread方法

- 获取当前线程

### 2.5.7 getState方法

- 获取当前线程状态

  ```java
      public enum State {
          /**
           * Thread state for a thread which has not yet started.
           */
          NEW,
  
          /**
           * Thread state for a runnable thread.  A thread in the runnable
           * state is executing in the Java virtual machine but it may
           * be waiting for other resources from the operating system
           * such as processor.
           */
          RUNNABLE,
  
          /**
           * Thread state for a thread blocked waiting for a monitor lock.
           * A thread in the blocked state is waiting for a monitor lock
           * to enter a synchronized block/method or
           * reenter a synchronized block/method after calling
           * {@link Object#wait() Object.wait}.
           */
          BLOCKED,
  
          /**
           * Thread state for a waiting thread.
           * A thread is in the waiting state due to calling one of the
           * following methods:
           * <ul>
           *   <li>{@link Object#wait() Object.wait} with no timeout</li>
           *   <li>{@link #join() Thread.join} with no timeout</li>
           *   <li>{@link LockSupport#park() LockSupport.park}</li>
           * </ul>
           *
           * <p>A thread in the waiting state is waiting for another thread to
           * perform a particular action.
           *
           * For example, a thread that has called {@code Object.wait()}
           * on an object is waiting for another thread to call
           * {@code Object.notify()} or {@code Object.notifyAll()} on
           * that object. A thread that has called {@code Thread.join()}
           * is waiting for a specified thread to terminate.
           */
          WAITING,
  
          /**
           * Thread state for a waiting thread with a specified waiting time.
           * A thread is in the timed waiting state due to calling one of
           * the following methods with a specified positive waiting time:
           * <ul>
           *   <li>{@link #sleep Thread.sleep}</li>
           *   <li>{@link Object#wait(long) Object.wait} with timeout</li>
           *   <li>{@link #join(long) Thread.join} with timeout</li>
           *   <li>{@link LockSupport#parkNanos LockSupport.parkNanos}</li>
           *   <li>{@link LockSupport#parkUntil LockSupport.parkUntil}</li>
           * </ul>
           */
          TIMED_WAITING,
  
          /**
           * Thread state for a terminated thread.
           * The thread has completed execution.
           */
          TERMINATED;
      }
  ```

### 2.5.8 join方法

- 主线程必须等待子线程执行完毕后在执行，原理是调用wait方法

### 2.5.9 setDaemon方法

- 设置该线程为守护线程

# 3. JVM级别锁，synchronized关键字及优化原理



# 4. JDK级别锁，Lock接口，及ReentrantLock实现类

# 5. CAS操作及原子类

# 6. 线程间通信、死锁、饥饿

# 7. AQS及JDK线程池

# 8. Java并发工具包

# 9. 新特性JDK19协程

# 10. Flink异步编程

