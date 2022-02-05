<template>
  <div class="hello">
   <button @click="show=!show">显示/隐藏</button>
    <transition name="na" appear>
      <h1 v-show="show" class="a">你好</h1>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld2',
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
  .na-enter,.na-leave-to{
  /*  进入的起点*/
    transform: translateX(-100%);
  }
  .na-enter-to,.na-leave{
  /*  进入的终点*/
    transform: translateX(0);
  }
  .na-enter-active,.na-leave-active{
    transition: 0.5s;
  }

</style>
