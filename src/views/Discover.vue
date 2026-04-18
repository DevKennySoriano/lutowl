<script setup>
import { ref, computed } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import logo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'

const search = ref('')
const sortBy = ref('newest')
const openIngredients = ref(false)
const selectedIngredients = ref([])

const foods = ref([
  { id: 1, title: 'Chicken Adobo', description: 'Soy-vinegar chicken with garlic.', date: '2026-04-10', rating: 4.9, ingredients: ['chicken','soy sauce','garlic','vinegar'] },
  { id: 2, title: 'Sinigang na Hipon', description: 'Sour shrimp soup.', date: '2026-03-22', rating: 4.8, ingredients: ['shrimp','tamarind','tomato','vegetables'] },
  { id: 3, title: 'Lechon Kawali', description: 'Crispy pork belly.', date: '2026-02-15', rating: 4.7, ingredients: ['pork','oil','garlic','salt'] },
  { id: 4, title: 'Pancit Canton', description: 'Stir-fried noodles.', date: '2026-01-30', rating: 4.6, ingredients: ['noodles','soy sauce','vegetables','chicken'] }
])

const allIngredients = computed(() => {
  const set = new Set()
  foods.value.forEach(f => f.ingredients.forEach(i => set.add(i)))
  return Array.from(set)
})

const formatDate = (date) => new Date(date).toLocaleDateString('en-US', { year:'numeric', month:'long', day:'numeric' })

const filteredFoods = computed(() => {
  let result = foods.value.filter(food => {
    const s = search.value.toLowerCase()
    const matchesSearch = !s || food.title.toLowerCase().includes(s) || food.description.toLowerCase().includes(s)

    const matchesIngredients = selectedIngredients.value.length === 0 ||
      selectedIngredients.value.every(i => food.ingredients.includes(i))

    return matchesSearch && matchesIngredients
  })

  if (sortBy.value === 'lowest') result = [...result].sort((a,b)=> a.rating-b.rating)
  else if (sortBy.value === 'newest') result = [...result].sort((a,b)=> new Date(b.date)-new Date(a.date))
  else if (sortBy.value === 'rating_desc') result = [...result].sort((a,b)=> b.rating-a.rating)
  else if (sortBy.value === 'rating_asc') result = [...result].sort((a,b)=> a.rating-b.rating)

  return result
})
</script>
<template>
  <div class="min-h-screen bg-surface-100">
    <Navigation />

    <div class="h-44 w-full bg-brand-700 flex items-center justify-center">
      <div class="text-center text-white">
        <h1 class="text-2xl md:text-3xl font-bold">Discover Lutowl Recipes</h1>
        <p class="text-xs md:text-sm mt-1 opacity-90">Find Filipino dishes from what you have</p>
      </div>
    </div>

    <div class="sticky top-0 z-10 bg-surface-100/90 backdrop-blur border-b border-black/5">
      <div class="p-4 flex flex-col md:flex-row gap-3 md:items-center md:justify-between max-w-6xl mx-auto">

        <div class="flex items-center gap-2 bg-white border rounded-xl px-3 py-2 w-full md:max-w-md shadow-sm">
          <input v-model="search" type="text" placeholder="Search dishes" class="outline-none w-full text-sm" />
        </div>

        <div class="flex items-center gap-2">
          <button
            @click="openIngredients = true"
            class="border rounded-lg px-3 py-2 text-xs md:text-sm bg-white shadow-sm hover:bg-surface-200"
          >
            Ingredients ({{ selectedIngredients.length }})
          </button>

          <select v-model="sortBy" class="border rounded-lg px-3 py-2 text-xs md:text-sm w-44">
            <option value="lowest">Lowest</option>
            <option value="newest">Newest</option>
            <option value="rating_desc">Rating (High to Low)</option>
            <option value="rating_asc">Rating (Low to High)</option>
          </select>
        </div>
      </div>
    </div>

    <div class="p-6 grid sm:grid-cols-2 lg:grid-cols-3 gap-5 max-w-6xl mx-auto">
      <div
        v-for="food in filteredFoods"
        :key="food.id"
        class="bg-white rounded-2xl border border-black/5 shadow-sm hover:shadow-md transition flex flex-col overflow-hidden group"
      >
        <div class="h-36 w-full bg-brand-400 flex items-center justify-center text-white">
          <span class="text-xs">Filipino Dish</span>
        </div>

        <div class="p-4 flex flex-col flex-1">
          <div class="flex items-center gap-2 text-[11px] text-gray-500 mb-1">
            <img :src="logo" class="w-5 h-5 rounded-full border" />
            <span>Lutowl</span>
            <span class="ml-auto">{{ formatDate(food.date) }}</span>
          </div>

          <h2 class="text-base font-semibold text-brand-900">{{ food.title }}</h2>

          <p class="text-xs text-gray-600 mt-1 line-clamp-3">
            {{ food.description }}
          </p>

          <div class="flex flex-wrap gap-1.5 mt-3">
            <span
              v-for="ing in food.ingredients"
              :key="ing"
              class="text-[10px] bg-brand-400/90 text-white px-2 py-0.5 rounded-full"
            >
              {{ ing }}
            </span>
          </div>

          <div class="flex items-center justify-between mt-4">
            <span class="text-xs text-gray-700">Rating: {{ food.rating }}</span>
            <button class="bg-brand-500 text-white px-3 py-1 text-xs rounded-lg hover:bg-brand-700">
              View
            </button>
          </div>
        </div>
      </div>
    </div>

    <div v-if="filteredFoods.length === 0" class="text-center text-gray-500 pb-10 text-sm">
      No recipes found.
    </div>

    <div v-if="openIngredients" class="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
      <div class="bg-white w-[90%] max-w-md rounded-2xl p-5 shadow-lg">
        <div class="flex items-center justify-between mb-3">
          <h3 class="font-semibold text-brand-900">Select Ingredients</h3>
          <button @click="openIngredients=false" class="text-sm">✕</button>
        </div>

        <div class="max-h-60 overflow-y-auto grid gap-2">
          <label v-for="ing in allIngredients" :key="ing" class="flex items-center gap-2 text-sm">
            <input type="checkbox" :value="ing" v-model="selectedIngredients" />
            {{ ing }}
          </label>
        </div>

        <div class="flex justify-between mt-4">
          <button @click="selectedIngredients=[]" class="text-xs text-gray-500">Clear</button>
          <button @click="openIngredients=false" class="bg-brand-500 text-white px-3 py-1 text-xs rounded-lg">Done</button>
        </div>
      </div>
    </div>
  </div>
  <Footer />
</template>

