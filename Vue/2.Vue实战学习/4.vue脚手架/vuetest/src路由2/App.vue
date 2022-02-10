<template>
  <div>
    <div>
      <button @click="pushShow">push</button>
      <br>
      <button @click="replaceShow">replace</button>
      <br>
      <button @click="backShow">back</button>
      <br>
      <button @click="forwardShow">forward</button>
      <br>
      <button @click="goShow">go</button>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',
  methods:{
    pushShow(){
      this.$router.push({
        name:'r1',
      })
    },
    replaceShow(){
      this.$router.replace({
            name:'r2',
          }
      )
    },
    backShow(){
      this.$router.back();
    },
    forwardShow(){
      this.$router.forward();
    },
    goShow(){
      // 前进或后退几步
      this.$router.go(2);
    }
  }
}
</script>

<style>

</style>
