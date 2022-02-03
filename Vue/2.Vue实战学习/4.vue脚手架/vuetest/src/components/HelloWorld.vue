<template>
  <div class="hello">
    <h1 >{{msg}}</h1>
    <button @click="sendMsg">点我</button>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data() {
    return {
      msg:'你好'
    }
  },
  methods:{
    sendMsg(){
      this.$emit('evezdy',this.msg);
    }
  }
}
</script>

<style scoped>
.hello{
  background-color: #da4f49;
  margin: 5px;
}
</style>
