<template>
  <div>
    <HelloWorld></HelloWorld>
    <button @click="send">send</button>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import axios from 'axios'

export default {
  name: 'App',
  components: {
    HelloWorld
  },
  methods:{
    send(){
      axios.get('http://127.0.0.1:8080/api/serve',{

      });
    }
  }
}
</script>

<style>

</style>
