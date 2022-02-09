<template>
  <div>
    <h1>当前求和为：{{$store.state.sum}}</h1>
    <select v-model.number="n">
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
    </select>
    <button @click="increment">+</button>
    <button @click="decrement">-</button>
    <button @click="odd">当前求和为奇数再加</button>
    <button @click="incrementWait">等一等再加</button>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data(){
    return {
      n:1
    }
  },
  methods:{
    increment(){
      this.$store.dispatch('jia',this.n);
    },
    decrement() {
      this.$store.dispatch('jian',this.n);
    },
    odd() {

    },
    incrementWait(){

    }

  },
}
</script>

<style scoped>
button{
  margin-left: 5px;
}
</style>
