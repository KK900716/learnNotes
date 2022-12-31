[TOC]



# 1. NIO简介

- 三大组件简介
  - Channel
  - Selector
  - Buffer
  - ```java
    package org.example;
    
    import lombok.extern.slf4j.Slf4j;
    
    import java.io.IOException;
    import java.net.InetSocketAddress;
    import java.nio.ByteBuffer;
    import java.nio.channels.SelectionKey;
    import java.nio.channels.Selector;
    import java.nio.channels.ServerSocketChannel;
    import java.nio.channels.SocketChannel;
    import java.util.Iterator;
    import java.util.Set;
    
    @Slf4j
    public class Main {
        public static void main(String[] args) throws IOException {
            log.info("start!");
            try (Selector selector = Selector.open();
                 ServerSocketChannel serverSocketChannel = ServerSocketChannel.open()) {
                serverSocketChannel.
                        bind(new InetSocketAddress(7777)).
                        configureBlocking(false).
                        register(selector, SelectionKey.OP_ACCEPT);
                while (true) {
                    int i = 0;
                    int select = selector.select();
                    log.info("select:{},{}", select, ++i);
                    final Set<SelectionKey> selectionKeys = selector.selectedKeys();
                    log.info("selectionKeys: {}", selectionKeys.size());
                    final Iterator<SelectionKey> iterator = selectionKeys.iterator();
                    while (iterator.hasNext()) {
                        final SelectionKey next = iterator.next();
                        iterator.remove();
                        if (next.isAcceptable()) {
                            ServerSocketChannel channel = (ServerSocketChannel) next.channel();
                            SocketChannel accept = channel.accept();
                            log.info("accept!");
                            ByteBuffer allocate = ByteBuffer.allocate(4);
                            accept.configureBlocking(false).register(selector, SelectionKey.OP_READ, allocate);
                        } else if (next.isReadable()) {
                            try {
                                ByteBuffer allocate = (ByteBuffer) next.attachment();
                                SocketChannel channel = (SocketChannel) next.channel();
                                int read = channel.read(allocate);
                                log.info("read:{}", read);
                                if (read == -1) {
                                    next.cancel();
                                } else {
                                    log.info(new String(allocate.array(), 0, read));
                                    allocate.clear();
                                }
                            } catch (IOException e) {
                                e.printStackTrace();
                                next.cancel();
                            }
                        }
                    }
                }
            }
        }
    }
    ```
  

# 2. Netty

## 2.1 简介

- Netty is an asynchronous event-driven network application framework for rapid development of maintainable high performance protocol servers & clients.

- demo Server

  - ```java
    package org.example;
    
    import io.netty.bootstrap.ServerBootstrap;
    import io.netty.channel.Channel;
    import io.netty.channel.ChannelHandlerContext;
    import io.netty.channel.ChannelInboundHandlerAdapter;
    import io.netty.channel.ChannelInitializer;
    import io.netty.channel.nio.NioEventLoopGroup;
    import io.netty.channel.socket.nio.NioServerSocketChannel;
    import io.netty.handler.codec.string.StringDecoder;
    
    /**
     * @author 44380
     */
    public class Server {
      public static void main(String[] args) {
        // 启动器
        new ServerBootstrap()
            // 2. BossEventLoop,WorkerEventLoop(selector,thread),group 组
            .group(new NioEventLoopGroup())
            // 3. 选择服务器的 ServerSocketChannel 实现
            .channel(NioServerSocketChannel.class)
            // 4. boss 负责处理连接 worker(child) 负责处理读写，决定了 worker(child) 能执行哪些操作 (handler)
            .childHandler(
                // 5. channel 代表和客户端进行数据读写的通道 Initializer 初始化，负责添加别的 handler
                new ChannelInitializer<>() {
                  @Override
                  protected void initChannel(Channel ch) throws Exception {
                    // 6. 添加具体 handler
                    // 将 ByteBuf 转换为字符串
                    ch.pipeline().addLast(new StringDecoder());
                    // 自定义 Handler
                    ch.pipeline()
                        .addLast(
                            new ChannelInboundHandlerAdapter() {
                              // 读事件
                              @Override
                              public void channelRead(ChannelHandlerContext ctx, Object msg)
                                  throws Exception {
                                System.out.println(msg);
                              }
                            });
                  }
                })
            // 7. 绑定监听端口
            .bind(8888);
      }
    }
    
    ```
    

- demo Client

  - ```java
    package org.example;
    
    import io.netty.bootstrap.Bootstrap;
    import io.netty.channel.Channel;
    import io.netty.channel.ChannelInitializer;
    import io.netty.channel.nio.NioEventLoopGroup;
    import io.netty.channel.socket.nio.NioSocketChannel;
    import io.netty.handler.codec.string.StringEncoder;
    
    /**
     * @author 44380
     */
    public class Client {
      public static void main(String[] args) throws InterruptedException {
        // 1. 启动类
        new Bootstrap()
            // 2. 添加 EventLoop
            .group(new NioEventLoopGroup())
            // 3. 选择客户端 channel 实现
            .channel(NioSocketChannel.class)
            // 4. 添加处理器
            .handler(
                new ChannelInitializer<>() {
                  // 连接建立后被调用
                  @Override
                  protected void initChannel(Channel ch) throws Exception {
                    ch.pipeline().addLast(new StringEncoder());
                  }
                })
            // 6. 连接服务器
            .connect("localhost", 8888)
            .sync()
            .channel()
            // 7. 向服务器发送数据
            .writeAndFlush("hello world!");
      }
    }
    
    ```

## 2.2 组件

### 2.2.1 EventLoop

- 事件循环对象
  - EventLoop 本质是一个单线程执行器（同时维护了一个Selector），里面有run方法处理 Channel 上源源不断的
  - 继承自 j.u.cScheduledExecutorService
  - 继承自己OrderdEventExecutor
- 事件循环组
  - EventLoopGroup 是一组 EventLoop，Channel 一般会调用EventLoopGroup的register方法绑定其中一个EventLoop，后续这个Channel上的io时间都由此EventLoop来处理

### 2.2.2 Channel

- channelFuture

  - sync 同步

  - addListener 异步

  - ```java
    package org.example;
    
    import io.netty.bootstrap.Bootstrap;
    import io.netty.channel.Channel;
    import io.netty.channel.ChannelFutureListener;
    import io.netty.channel.ChannelInitializer;
    import io.netty.channel.nio.NioEventLoopGroup;
    import io.netty.channel.socket.nio.NioSocketChannel;
    import io.netty.handler.codec.string.StringEncoder;
    import java.util.Scanner;
    
    /**
     * @author 44380
     */
    public class Client {
      public static void main(String[] args) throws InterruptedException {
        NioEventLoopGroup eventExecutors = new NioEventLoopGroup();
        Channel channel =
            new Bootstrap()
                .group(eventExecutors)
                .channel(NioSocketChannel.class)
                .handler(
                    new ChannelInitializer<>() {
                      @Override
                      protected void initChannel(Channel ch) throws Exception {
                        ch.pipeline().addLast(new StringEncoder());
                      }
                    })
                .connect("localhost", 8888)
                .sync()
                .channel();
        new Thread(
                () -> {
                  Scanner scanner = new Scanner(System.in);
                  while (true) {
                    String s = scanner.nextLine();
                    if ("q".equals(s)) {
                      channel.close();
                      break;
                    }
                    channel.writeAndFlush(s);
                  }
                },
                "input")
            .start();
        channel
            .closeFuture()
            .addListener((ChannelFutureListener) future -> eventExecutors.shutdownGracefully());
      }
    }
    ```

### 2.2.3 Future & Promise

- jdk Future 只能同步等待任务结束才能得到结果
- netty Future 可以同步等待任务结束或异步方式得到结果
- netty Promise 不仅有 netty Future 的功能，而且脱离了任务独立存在，只作为两个线程间传递结果的容器
- ```java
  package org.example;
  
  import io.netty.channel.EventLoop;
  import io.netty.channel.nio.NioEventLoopGroup;
  import io.netty.util.concurrent.Future;
  import java.util.concurrent.*;
  import lombok.extern.slf4j.Slf4j;
  
  @Slf4j
  public class TestFuture {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
      NioEventLoopGroup eventExecutors = new NioEventLoopGroup();
      EventLoop next = eventExecutors.next();
      Future<Integer> submit = next.submit(() -> 1);
      submit.addListener(
          future -> {
            log.info("{}", future.getNow());
          });
    }
  }
  ```

- ```java
  package org.example;
  
  import io.netty.channel.EventLoopGroup;
  import io.netty.channel.nio.NioEventLoopGroup;
  import io.netty.util.concurrent.DefaultPromise;
  import java.util.concurrent.*;
  import lombok.extern.slf4j.Slf4j;
  
  @Slf4j
  public class TestFuture {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
      EventLoopGroup eventExecutors = new NioEventLoopGroup();
      DefaultPromise<Integer> promise = new DefaultPromise<>(eventExecutors.next());
      new Thread(
              () -> {
                try {
                  Thread.sleep(5000);
                  promise.setSuccess(1);
                } catch (InterruptedException e) {
                  throw new RuntimeException(e);
                }
              })
          .start();
      System.out.println(promise.get());
    }
  }
  ```

### 2.2.4 Handler & Pipeline

- Handler
  - ChannelInBoundHandlerAdapter
  - ChannelOutboundHandlerAdapter
    - need to write
  - head -> h1-> tail

- EmbeddedChannel 

  - ```java
    package org.example;
    
    import io.netty.buffer.ByteBufAllocator;
    import io.netty.channel.ChannelHandlerContext;
    import io.netty.channel.ChannelInboundHandlerAdapter;
    import io.netty.channel.ChannelOutboundHandlerAdapter;
    import io.netty.channel.ChannelPromise;
    import io.netty.channel.embedded.EmbeddedChannel;
    import lombok.extern.slf4j.Slf4j;
    
    @Slf4j
    public class TestEmbeddedChannel {
      public static void main(String[] args) {
        ChannelInboundHandlerAdapter h1 =
            new ChannelInboundHandlerAdapter() {
              @Override
              public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
                log.info("1");
                super.channelRead(ctx, msg);
              }
            };
        ChannelInboundHandlerAdapter h2 =
            new ChannelInboundHandlerAdapter() {
              @Override
              public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
                log.info("2");
                super.channelRead(ctx, msg);
              }
            };
        ChannelInboundHandlerAdapter h3 =
            new ChannelInboundHandlerAdapter() {
              @Override
              public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
                log.info("3");
    
                super.channelRead(ctx, msg);
              }
            };
        ChannelOutboundHandlerAdapter h4 =
            new ChannelOutboundHandlerAdapter() {
              @Override
              public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise)
                  throws Exception {
                log.info("4");
                super.write(ctx, msg, promise);
              }
            };
        ChannelOutboundHandlerAdapter h5 =
            new ChannelOutboundHandlerAdapter() {
              @Override
              public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise)
                  throws Exception {
                log.info("5");
                super.write(ctx, msg, promise);
              }
            };
        ChannelOutboundHandlerAdapter h6 =
            new ChannelOutboundHandlerAdapter() {
              @Override
              public void write(ChannelHandlerContext ctx, Object msg, ChannelPromise promise)
                  throws Exception {
                log.info("6");
                super.write(ctx, msg, promise);
              }
            };
        EmbeddedChannel embeddedChannel = new EmbeddedChannel(h1, h2, h3, h4, h5, h6);
        embeddedChannel.writeInbound(
            ByteBufAllocator.DEFAULT.buffer().writeBytes("hello world!".getBytes()));
        embeddedChannel.writeOutbound(
            ByteBufAllocator.DEFAULT.buffer().writeBytes("hello world!".getBytes()));
      }
    }
    
    ```

## 2.3 ByteBuf

- 自动扩容

- 创建

  - ```java
        ByteBuf buffer = ByteBufAllocator.DEFAULT.buffer();
    ```

- 直接内存 vs 堆内存（默认直接内存）

- 池化（4.1之后默认使用池化技术）

  - ```bash
    -Dio.netty.allocator.type={unpooled|pooled}
    ```

    
