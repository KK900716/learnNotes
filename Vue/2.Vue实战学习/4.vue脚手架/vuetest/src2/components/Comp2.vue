<template>
  <div class="hello">
    <h1>{{msg}}</h1>
    <button>点0我</button>
  </div>
</template>

<script>
import pubsub from 'pubsub-js'
export default {
  name: 'Comp2',
  data() {
    return {
      msg:'世界'
    }
  },
  methods: {

  },
  mounted() {
    pubsub.subscribe('hello',function(name,content){
      console.log('收到');
      console.log(content);
    });
  }

}
</script>

<style scoped>
.hello{
  background-color: #42b983;
  margin: 5px;
}
</style>
