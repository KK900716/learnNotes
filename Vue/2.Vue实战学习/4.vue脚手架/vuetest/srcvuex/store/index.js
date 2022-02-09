import Vue from "vue";
import Vuex from 'vuex'
Vue.use(Vuex);
export default new Vuex.Store({
    actions:{
        jia(context,value){
            context.commit('JIA',value)
        },
        jian(context,value){
            context.commit('JIAN',value)
        }
    },
    mutations:{
        JIA(state,value){
            state.sum+=value;
        },
        JIAN(state,value){
          state.sum-=value
        }
    },
    state:{
        sum: 0
    }
})