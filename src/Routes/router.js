import { createRouter, createWebHistory } from 'vue-router'

import Homepage from '../views/Homepage.vue'
import Discover from '../views/Discover.vue'
import About from '../views/About.vue'
import Register from '../views/Register.vue'
import Login from '../views/Login.vue'
import Dashboard from '../views/user/Dashboard.vue'

const routes = [
  { path: '/', name: 'Homepage', component: Homepage },
  { path: '/discover', name: 'Discover', component: Discover },
  { path: '/about', name: 'About', component: About },
  { path: '/register', name: 'Register', component: Register },
  { path: '/login', name: 'Login', component: Login },
  { path: '/user/dashboard', name: 'Dashboard', component: Dashboard },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router