<template>
  <div class="MyItem">
      <li>
        <label>
          <input type="checkbox" v-model="mydo.done">
          <span>{{mydo.title}}</span>
        </label>
        <button class="btn btn-danger" @click="HandleDelete(mydo.id)">删除</button>
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
    }
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
