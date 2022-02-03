<template>
<div class="school">
  <h2 @click="show">学生名称：{{name}}</h2>
</div>
</template>

<script>
import {mixin} from './mixin'

export default {
  name: 'School',
  data() {
    return {
      name:'学生',
    }
  },
  mixins:[mixin]
}
</script>

<style scoped>

</style>
