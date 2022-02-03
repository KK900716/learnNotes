<template>
  <div id="app">
    <h2>你好</h2>
    <HelloWorld v-on:evezdy="demo"/>
    <Comp2 ref="Comp2"/>
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
    demo(x){
      alert(x)
    },
    f(x){
      alert(x)
    }
  },
  mounted() {
    this.$refs.Comp2.$on('getSj',this.f)
  }
}
</script>

<style>
#app{
  background-color: aqua;
}
</style>
