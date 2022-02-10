// 该文件是整个文件的入口文件
// 引入app组件，他是所有组件的父组件
import App from './App.vue'
import Vue from 'vue'
import VueRouter from 'vue-router'
import router from "@/router";
// 关闭vue生产提示
Vue.config.productionTip = false
//创建vue实例
Vue.use(VueRouter)
new Vue({
  //将app组件放入容器中
  router:router,
  render: h => h(App),
}).$mount('#app')
