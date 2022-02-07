<template>
  <div class="container">
    <Category title="美食" :listData="foods">
      <img slot="demo" src="https://s3.ax1x.com/2021/01/16/srJlq0.jpg" alt="">
      <a slot="test" href="https://www.baidu.com">点击我</a>
    </Category>
    <Category title="游戏" :listData="games"></Category>
    <Category title="电影" :listData="films">
      <video slot="demo" controls src="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"></video>
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
  data(){
    return{
      foods:['火锅','烧烤','小龙虾','牛排'],
      games:['红色警戒','穿越火线','反恐精英','英雄联盟'],
      films:['《教父》','《流浪地球》','《长津湖》','《水门桥》'],
    }
  }
}
</script>

<style>
.container{
  display: flex;
  justify-content: space-around;
}
a{
  display: block;
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
}
</style>
