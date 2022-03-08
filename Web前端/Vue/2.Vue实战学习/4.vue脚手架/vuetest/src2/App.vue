<template>
  <div id="app">
    <h2>你好</h2>
    <HelloWorld/>
    <Comp2/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import Comp2 from './components/Comp2'

export default {
  name: 'App',
  components: {
    HelloWorld,Comp2
  },
  methods:{

  },
}
</script>

<style>
#app{
  background-color: aqua;
}
</style>
