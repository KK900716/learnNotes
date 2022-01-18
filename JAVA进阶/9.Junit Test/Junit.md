1.什么是单元测试
    a.单元测试是针对最小的功能单元编写测试代码
    b.java程序最小的功能是方法
    c.单元测试就是针对单个java方法的测试
2.测试驱动开发（TDD）
    编写接口->编写测试->编写实现->运行测试->任务完成
3.单元测试优点
    a.确保单个方法运行正常
    b.如果修改了方法代码，只需确保其对应的单元测试通过
    c.测试代码本身就可以作为示例代码
    d.可以自动化运行所有测试并获得报告
4.Junit是Java事实的标准测试框架
    a.Junit的设计
        （1）TestCase 一个TestCase表示一个测试
        （2）TestSuite 一个TestSuite包含一组TestCase，表示一组测试
        （3）TestFixture 一个TestFixture表示一个测试环境
        （4）TestResult 用于收集测试结果
        （5）TestRunner 用于运行测试结果
        （6）TestListener 用于监听测试过程，收集测试数据
        （7）Assert 用于断言测试结果是否正确