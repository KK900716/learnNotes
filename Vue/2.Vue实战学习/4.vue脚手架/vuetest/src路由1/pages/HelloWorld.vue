<template>
  <div>
    <span>页面1</span>
    <router-link active-class="yangshi" to="/about1/h1">111</router-link>
    <router-link active-class="yangshi" to="/about1/h2">222</router-link>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
}
</script>

<style>
.yangshi{
  width:200px;
  height: 200px;
  background-color: orange;
}
</style>
