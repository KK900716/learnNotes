<template>
  <div class="MyItem">
      <li>
        <label>
          <input type="checkbox" v-model="mydo.done">
          <span v-show="!mydo.isEdit" >{{mydo.title}}</span>
          <input v-show="mydo.isEdit" type="text" v-model="mydo.title" @blur="store(mydo)" ref="inp" >
        </label>
        <button class="btn btn-danger" @click="HandleDelete(mydo.id)">删除</button>
        <button class="btn btn-danger" input v-show="!mydo.isEdit" @click="handleEdit(mydo)" >编辑</button>
      </li>
  </div>
</template>

<script>
export  default{
  name:'MyItem',
  props:['mydo','deleHander'],
  methods: {
    HandleDelete(x){
      if(confirm("确定删除吗？")){
        this.deleHander(x)
      }
    },
    handleEdit(mydo){
      if (mydo.hasOwnProperty('isEdit')){
        mydo.isEdit=true;
      }else{
        this.$set(mydo,'isEdit',true)
      }
      this.$nextTick(()=>this.$refs.inp.focus())
    },
    store(mydo){
      if(mydo.title.trim()===''){
        alert('请输入内容');
      }else{
        mydo.isEdit=false
      }
    },
  },
}
</script>

<style scoped>
li{
  list-style:none;
  height:36px;
  line-height:36px;
  padding:0 5px;
  border-bottom:1px solid #ddd;
}
li label{
  float:left;
  cursor:pointer;
}
li label li input{
  vertical-align: middle;
  margin-right: 6px;
  position: relative;
  top:-1px;
}
li button{
  float:right;
  display: none;
  margin-top: 3px;
}
li:before{
  content:initial;
}
li:last-child{
  border-bottom: none;
}
li:hover{
  background-color: rgba(83, 83, 83,0.3);
}
li:hover button{
  display: block;
}
</style>
