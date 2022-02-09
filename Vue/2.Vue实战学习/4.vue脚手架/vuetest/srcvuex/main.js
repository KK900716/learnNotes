// 该文件是整个文件的入口文件
// 引入app组件，他是所有组件的父组件
import App from './App.vue'
import Vue from 'vue'
import store from './store'
// 关闭vue生产提示
Vue.config.productionTip = false
//创建vue实例
new Vue({
  //将app组件放入容器中
  store,
  render: h => h(App),
}).$mount('#app')
