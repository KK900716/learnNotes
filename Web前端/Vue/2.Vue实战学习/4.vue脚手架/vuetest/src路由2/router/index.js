import VueRouter from 'vue-router'
import HelloWorld from "@/pages/HelloWorld";
import HelloWorld2 from "@/pages/HelloWorld2";
const router = new VueRouter({
    routes:[
        {
            name:'r1',
            path:'/r1',
            component:HelloWorld
        },
        {
            name:'r2',
            path:'/r2',
            component:HelloWorld2
        }
    ]
})
// 全局前置路由守卫
// 每次路由切换之前或初始化时调用
router.beforeEach((to,from,next)=>{
//    to目标路由 from从哪里来 next放行
//    path路径
//    可以为路由加一个标识放在meta中（路由源信息）｛isAuth:false｝
    next()
})
// 全局后置路由守卫
// 每次路由切换之后或初始化时调用
router.afterEach((to,from)=>{
//    to目标路由 from从哪里来
//    可以用来改变一些信息例如title

})
export default router