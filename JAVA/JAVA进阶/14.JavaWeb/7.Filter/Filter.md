1.简介
    JavaWeb三大组件之一
    过滤器可以把对资源的请求拦截下来，从而实现一些特殊功能
    过滤器一般完成一些通用的操作，比如：权限控制、统一编码处理、敏感字符处理等等
2.快速入门
    a.定义类实现Filter接口，并重写其所有方法
    b.配置Filter拦截资源的路径：在类上定义@WebFilter注解
    c.在doFilter方法中输出一句话，并放行
```
@WebFilter("/*")
public class FilterDemo implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("Filter....");
        filterChain.doFilter();//放行
    }
    @Override
    public void destroy() {}
}
```
3.Filter执行流程
    a.放行后访问对应资源，资源访问完成后，会回到Filter中
    b.放行后会执行放行后的逻辑
    c.放行前对request进行处理
    d.放行后对response进行处理
4.Filter可以根据需求，配置不同的拦截资源路径
    a./index.jsp：只有访问index.jsp时才会被拦截
    b./user/*：访问/user下的所有资源，都会被拦截
    c.*.jsp：访问后缀名为jsp的资源，都会被拦截
    d./*：访问所有资源，都会被拦截
5.Filter链
    a.一个web应用，可以配置多个Filter，这多个过滤器称为过滤器链
    b.优先级按照过滤器类名自然排序进行执行