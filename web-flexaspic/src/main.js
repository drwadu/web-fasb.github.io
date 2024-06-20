import './assets/main.css'


import { createApp } from 'vue'
import App from './App.vue'

import { createPinia } from 'pinia';
// import { useMovesStore } from './stores/MovesStore';

const pinia = createPinia()
const app = createApp(App)
app.use(pinia)

// const movesStore = useMovesStore()

app.mount('#app')
