<template>
  <div class="category">
    <h3>{{title}}</h3>
    <slot :shiwu="foods"></slot>
  </div>
</template>

<script>
export default {
  name: 'Category',
  props:['title'],
  data(){
    return{
      foods:['火锅','烧烤','小龙虾','牛排'],
    }
  }
}
</script>

<style scoped>
.category{
  background-color: rgb(98, 175, 161);
  width: 200px;
  height: 300px;
  position: relative;
}
h3{
  text-align: center;
  background-color: orange;
}
</style>
