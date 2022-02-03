<template>
  <div id="app">
    <div class="todo-container">
      <div class="todo-wrap">
        <MyHeader :receive="receive"/>
        <MyList :todos="todos" :deleHander="deleHander"/>
        <MyFooter :todos="todos" :checkal="checkal" :cle="cle"/>
      </div>
    </div>
  </div>
</template>

<script>
import MyFooter from './components/MyFooter.vue'
import MyHeader from './components/MyHeader.vue'
import MyList from './components/MyList.vue'

export default {
  name: 'App',
  components: {
    MyFooter,MyHeader,MyList
  },
  data() {
    return {
      todos:[
        {id:'0001',title:'吃饭',done:true},
        {id:'0002',title:'睡觉',done:false},
        {id:'0003',title:'开车',done:true}
      ]
    }
  },
  methods: {
    receive(x){
      this.todos.unshift(x);
    },
    deleHander(id){
      this.todos=this.todos.filter((todo)=>{
        return todo.id!==id
      })
    },
    checkal(done){
      for(let i=0;i<this.todos.length;i++){
        this.todos[i].done=done;
      }
    },
    cle(){
      this.todos=this.todos.filter(todo=>!todo.done)
    }
  },
}
</script>

<style>
body{
  background: #fff;
}
.btn{
  display: inline-block;
  padding: 4px 12px;
  margin-bottom: 0;
  font-size: 14px;
  line-height:20px;
  text-align: center;
  vertical-align: center;
  cursor: pointer;
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.2),0 1px 2px rgba(0, 0, 0, 0.6);
  border-radius:4px;
}
.btn-danger{
  color:#fff;
  background-color: #da4f49;
  border:1px solid #bd362f
}
.btn-danger:hover{
  color: #fff;
  background-color: #bd362f;
}
.btn:focus{
  outline:none;
}
.todo-container{
  width:600px;
  margin: 0 auto;
}
.todo-container .todo-wrap{
  padding:10px;
  border:1px solid #ddd;
  border-radius: 5px;
}


</style>
