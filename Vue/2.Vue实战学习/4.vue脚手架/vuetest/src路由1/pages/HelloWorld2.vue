<template>
  <div>
    <span>页面2</span><br>
    <router-link to="/about2/l?lists=a">abc</router-link><br>
    <router-link :to="`/about2/l?lists=${lists[1]}`">def</router-link><br>
    <router-link :to="{path:'/about2/l',query:{lists:lists[2]}}">ghi</router-link><br>
    <router-link :to="{name:'l',query:{lists:lists[3]}}">jkl</router-link><br>
    <router-link :to="{name:'l2',params:{lists:lists[4]}}">mno</router-link><br>
    <router-link :to="`/about2/l3/${lists[5]}`">mno</router-link><br>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld2',
  data(){
    return {
      lists:['a','b','c','d','e','f']
    }
  }
}
</script>

<style>

</style>
