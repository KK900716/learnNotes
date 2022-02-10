<template>
  <div>
    <div>
      <router-link active-class="yangshi" to="/about1">11111</router-link>
      <router-link active-class="yangshi" to="/about2">22222</router-link>
      <router-link active-class="yangshi" to="/about3">22222</router-link>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',
}
</script>

<style>
.yangshi{
  width:200px;
  height: 200px;
  background-color: orange;
}
</style>
