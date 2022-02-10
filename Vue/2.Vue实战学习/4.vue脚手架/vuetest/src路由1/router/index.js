import VueRouter from 'vue-router'
import HelloWorld from "../pages/HelloWorld";
import HelloWorld2 from "../pages/HelloWorld2";
import H11 from "@/pages/h1.1";
import H12 from "@/pages/h1.2";
import Lists from "@/pages/Lists";
import Lists2 from "@/pages/Lists2";
import HelloWorld3 from "@/pages/HelloWorld3";
const router = new VueRouter({
    routes:[
        {
            path:'/about1',
            component:HelloWorld,
            children:[
                {
                    path:'h1',
                    component:H11
                },
                {
                    path:'h2',
                    component:H12
                }
            ]
        },
        {
            path:'/about2',
            component:HelloWorld2,
            children:[
                {
                    name:'l',
                    path:'l',
                    component:Lists
                },
                {
                    name:'l2',
                    path:'l2',
                    component: Lists2
                },
                {
                    name:'l3',
                    path:'l3/:id',
                    component: Lists2
                },
            ]
        },
        {
            name:'page3',
            path:'/about3',
            component:HelloWorld3,
            // props:{a:1,b:2}
            props:true
        }
    ]
})
export default router