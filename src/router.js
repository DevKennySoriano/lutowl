import { createRouter, createWebHistory } from 'vue-router'
import Homepage from './views/Homepage.vue'
import Discover from './views/Discover.vue'

const routes = [
  { path: '/', name: 'Homepage', component: Homepage },
  { path: '/discover', name: 'Discover', component: Discover },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
