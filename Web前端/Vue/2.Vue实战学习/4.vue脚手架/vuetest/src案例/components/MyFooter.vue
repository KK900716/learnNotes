<template>
  <div class="MyFooter" v-show="todos.length">
    <div class="todo-footer" >
      <label>
        <input type="checkbox" :checked="isAll" @change="checkAll"/>
      </label>
      <span>
        <span>已完成{{todosLength}}</span>/全部{{todos.length}}
      </span>
      <button class="btn btn-danger" @click="clearAll">清除已完成任务</button>
    </div>
  </div>
</template>

<script>
export  default{
  name:'MyFooter',
  props:['todos','checkal','cle'],
  computed:{
    todosLength(){
      return this.todos.reduce((pre,current)=>{
        return pre+(current.done?1:0)
      },0)
    },
    isAll(){
      return this.todosLength===this.todos.length && this.todos.length>0
    }
  },
  methods: {
    checkAll(e){
      this.checkal(e.target.checked);
    },
    clearAll(){
      this.cle();
    }
  },
}
</script>

<style scoped>
.todo-footer{
  height: 40px;
  line-height: 40px;
  padding-left: 6px;
  margin-top: 5px;
}
.todo-footer label{
  display:inline-block;
  margin-right: 20px;
  cursor: pointer;
}
.todo-footer label input{
  position: relative;
  top:-1px;
  vertical-align: middle;
  margin-right: 5px;
}
.todo-footer button{
  float: right;
  margin-top: 5px;
}
</style>
