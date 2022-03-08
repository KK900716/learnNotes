<template>
  <div>
    <span>页面3</span>
    <span>a:{{a}}</span>
    <span>b:{{b}}</span>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld3',
  props:['a','b']
}
</script>

<style>
.yangshi{
  width:200px;
  height: 200px;
  background-color: orange;
}
</style>
