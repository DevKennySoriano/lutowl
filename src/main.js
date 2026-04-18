import { createApp } from 'vue'
import './css/main.css'
import App from './App.vue'
import router from './Routes/router'

createApp(App).use(router).mount('#app')
