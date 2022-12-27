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
