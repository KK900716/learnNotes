<template>
  <div class="hello">
   <button @click="show=!show">显示/隐藏</button>
    <transition name="animate__animated animate__bounce" enter-active-class="animate__jello" leave-active-class="animate__hinge" appear>
      <h1 v-show="show" class="a">你好</h1>
    </transition>
  </div>
</template>

<script>
import 'animate.css';
export default {
  name: 'HelloWorld3',
  data() {
    return {
      show:true
    }
  }
}
</script>

<style scoped>
  .a{
    background-color: #da4f49;
  }

</style>
