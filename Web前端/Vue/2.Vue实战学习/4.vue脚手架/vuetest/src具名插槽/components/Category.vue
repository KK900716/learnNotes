<template>
  <div class="category">
    <h3>{{title}}</h3>
    <slot name="demo">
      <ul>
        <li v-for="(item,index) in listData" :key="index">{{item}}</li>
      </ul>
    </slot>
    <slot name="test"></slot>
  </div>
</template>

<script>
export default {
  name: 'Category',
  props:['title','listData']
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
img{
  width: 100%;
}
video{
  width: 100%;
}

</style>
