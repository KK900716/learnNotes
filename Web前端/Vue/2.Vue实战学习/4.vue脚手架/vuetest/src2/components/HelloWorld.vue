<template>
  <div class="hello">
    <h1 >{{msg}}</h1>
    <button @click="sendMsg">点我传递消息</button>
  </div>
</template>

<script>
import pubsub from 'pubsub-js'
export default {
  name: 'HelloWorld',
  data() {
    return {
      msg:'你好'
    }
  },
  methods: {
    sendMsg(){
      pubsub.publish('hello',this.msg)
    }
  },
}
</script>

<style scoped>
.hello{
  background-color: #da4f49;
  margin: 5px;
}
</style>
