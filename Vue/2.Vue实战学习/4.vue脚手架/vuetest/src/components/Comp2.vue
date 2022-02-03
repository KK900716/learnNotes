<template>
  <div class="hello">
    <h1>{{msg}}</h1>
    <button @click="sendMsg">点0我</button>
  </div>
</template>

<script>
export default {
  name: 'Comp2',
  data() {
    return {
      msg:'世界'
    }
  },
  methods: {
    sendMsg(){
      this.$emit('getSj',this.msg);
    }
  }

}
</script>

<style scoped>
.hello{
  background-color: #42b983;
  margin: 5px;
}
</style>
