<template>
  <div class="container">
    <Category title="美食">
      <template scope="name">
        <ul>
          <li v-for="(item,index) in name.shiwu" :key="index">{{item}}</li>
        </ul>
      </template>
    </Category>
    <Category title="美食">
      <template scope="name">
        <ul>
          <li v-for="(item,index) in name.shiwu" :key="index">{{item}}</li>
        </ul>
      </template>
    </Category>
    <Category title="美食">
      <template scope="{shiwu}">
        <ul>
          <li v-for="(item,index) in shiwu" :key="index">{{item}}</li>
        </ul>
      </template>
    </Category>
  </div>
</template>

<script>
import Category from './components/Category'

export default {
  name: 'App',
  components: {
    Category
  },
}
</script>

<style>
.container{
  display: flex;
  justify-content: space-around;
}
</style>
