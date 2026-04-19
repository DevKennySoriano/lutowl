import { createRouter, createWebHistory } from 'vue-router'

import Homepage from '../views/Homepage.vue'
import Discover from '../views/Discover.vue'
import About from '../views/about.vue'
import Register from '../views/register.vue'

const routes = [
  { path: '/', name: 'Homepage', component: Homepage },
  { path: '/discover', name: 'Discover', component: Discover },
  { path: '/about', name: 'About', component: About },
  { path: '/register', name: 'Register', component: Register },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
