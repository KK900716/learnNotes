<template>
    <!-- 组件的结构 -->
    <div class="demo">
        <h2>学校名称：{{schoolName}}</h2>
        <h2>学校地址：{{address}}</h2>
    </div>
</template>
<script>
    // 组件交互的相关代码
    export default{
        name:'School',
        data() {
            return {
                schoolName:'123',
                addreess:'abc'
            }
        },
    } 
</script>
<style>
    /* 组件的样式 */
    .demo{
        background: orange;
    }
</style>