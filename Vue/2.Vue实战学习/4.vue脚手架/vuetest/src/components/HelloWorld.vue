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
  name: 'HelloWorld',
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
  .na-enter-active{
    animation: dh 1s;
  }
  .na-leave-active{
    animation: db 1s reverse;
  }
  @keyframes dh {
    from{
      transform: translateX(-100%);
    }
    to{
      transform: translateX(0);
    }
  }
</style>
