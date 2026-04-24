<script setup>
import { ref, onMounted, computed } from 'vue'
import { supabase } from '../../lib/supabase'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'

import navLogo from '../../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'
import lutowlGif from '../../assets/lutowl-gif/lutowl-gif.gif'

import {
  LayoutDashboard,
  BookOpen,
  Heart,
  Settings,
  LogOut,
  User,
  TrendingUp,
  Eye,
  ChefHat,
  Star
} from 'lucide-vue-next'

const router = useRouter()

const user = ref(null)
const loading = ref(true)
const activeTab = ref('overview')

const showProfileMenu = ref(false)

const fetchUser = async () => {
  const { data } = await supabase.auth.getUser()
  user.value = data.user
  loading.value = false
}

const displayName = computed(() =>
  user.value?.user_metadata?.full_name || user.value?.email
)

const avatar = computed(() =>
  user.value?.user_metadata?.avatar_url ||
  `https://ui-avatars.com/api/?name=${displayName.value}`
)

const verified = computed(() =>
  user.value?.email_confirmed_at ? 'Verified' : 'Not Verified'
)

const tabs = [
  { id: 'overview', label: 'Overview', icon: LayoutDashboard },
  { id: 'recipes', label: 'My Recipes', icon: BookOpen },
  { id: 'favorites', label: 'Favorites', icon: Heart }
]

const recentRecipes = [
  { name: 'Spicy Chicken Ramen', likes: 120, views: 430 },
  { name: 'Garlic Butter Shrimp', likes: 98, views: 301 },
  { name: 'Chocolate Lava Cake', likes: 210, views: 880 }
]

const logout = async () => {
  const res = await Swal.fire({
    title: 'Logout from Lutowl?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#ad49e1',
    cancelButtonColor: '#6c757d',
    confirmButtonText: 'Logout',
    reverseButtons: true
  })

  if (!res.isConfirmed) return

  await supabase.auth.signOut()
  router.push('/login')
}

const handleClickOutside = (e) => {
  const menu = document.getElementById('profile-menu')
  const button = document.getElementById('profile-btn')

  if (menu && button && !menu.contains(e.target) && !button.contains(e.target)) {
    showProfileMenu.value = false
  }
}

onMounted(() => {
  fetchUser()
  window.addEventListener('click', handleClickOutside)
})
</script>

<template>
  <div class="min-h-screen flex flex-col bg-surface-100 text-surface-900">

    <header class="h-14 flex items-center justify-between px-4 md:px-6 bg-brand-900 shadow-sm">
      <div class="flex items-center gap-3">
        <img :src="navLogo" class="h-7" />
        <span class="font-bold text-white hidden sm:block">Lutowl</span>
      </div>

      <div class="flex items-center gap-3 relative">
        <span class="text-white/70 text-sm hidden sm:block">{{ displayName }}</span>

        <button id="profile-btn" @click="showProfileMenu = !showProfileMenu">
          <img :src="avatar" class="h-9 w-9 rounded-full border border-white/20" />
        </button>

        <div
          v-if="showProfileMenu"
          id="profile-menu"
          class="absolute top-12 right-0 w-52 bg-white rounded-2xl shadow-lg z-50 overflow-hidden"
        >
          <div class="px-4 py-3 border-b">
            <p class="font-semibold text-brand-900">{{ displayName }}</p>
            <p class="text-xs text-gray-500">{{ verified }}</p>
          </div>

          <button class="w-full flex items-center gap-2 px-4 py-3 hover:bg-gray-100">
            <User size="16" /> Profile
          </button>

          <button class="w-full flex items-center gap-2 px-4 py-3 hover:bg-gray-100">
            <Settings size="16" /> Settings
          </button>

          <button
            @click="logout"
            class="w-full flex items-center gap-2 px-4 py-3 text-red-600 hover:bg-red-50"
          >
            <LogOut size="16" /> Logout
          </button>
        </div>
      </div>
    </header>

    <div class="flex flex-1 overflow-hidden">

      <aside class="hidden md:flex w-64 flex-col bg-brand-900">
        <nav class="p-4 space-y-2">
          <button
            v-for="tab in tabs"
            :key="tab.id"
            @click="activeTab = tab.id"
            class="w-full flex items-center gap-3 px-4 py-2 rounded-xl text-white/80 transition"
            :class="activeTab === tab.id
              ? 'bg-brand-700 text-white'
              : 'hover:bg-brand-700/40'"
          >
            <component :is="tab.icon" :size="18" />
            {{ tab.label }}
          </button>
        </nav>
      </aside>

      <main class="flex-1 overflow-y-auto">
        <div class="max-w-7xl mx-auto p-4 md:p-8 space-y-8">

          <div class="relative overflow-hidden rounded-2xl border border-gray-200 shadow-sm px-6 pt-6 pb-4 bg-white">

            <div class="absolute -top-10 -left-10 w-32 h-32 bg-purple-200 rounded-full opacity-30"></div>
            <div class="absolute -top-10 -right-10 w-36 h-36 bg-purple-300 rounded-full opacity-20"></div>
            <div class="absolute -bottom-12 -left-12 w-40 h-40 bg-purple-200 rounded-full opacity-20"></div>
            <div class="absolute -bottom-12 -right-12 w-32 h-32 bg-purple-300 rounded-full opacity-25"></div>

            <img
              :src="lutowlGif"
              class="absolute -bottom-2 left-2 sm:left-4 md:left-2
                     h-20 sm:h-24 md:h-18 lg:h-28
                     w-auto object-contain drop-shadow-sm"
            />

            <div class="flex items-end justify-between gap-6 relative z-10 pl-20 sm:pl-24 md:pl-32 lg:pl-36">

            <div class="pb-2 text-center md:text-left w-full md:w-auto">

              <h2 class="text-lg sm:text-xl md:text-2xl font-semibold text-gray-900 leading-snug">
                Welcome back, {{ displayName }}
              </h2>

              <p class="text-xs sm:text-sm text-gray-500 mt-1">
                Here's what's happening with your recipes today.
              </p>

            </div>

              <div class="flex items-center text-xs text-gray-500 pb-2">
                <span
                  class="px-3 py-1 rounded-full border text-xs font-medium whitespace-nowrap"
                  :class="verified === 'Verified'
                    ? 'bg-green-50 text-green-600 border-green-200'
                    : 'bg-red-50 text-red-600 border-red-200'"
                >
                  {{ verified }}
                </span>
              </div>

            </div>

          </div>

          <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <div class="bg-white p-6 rounded-2xl border">
              <Eye class="text-gray-500" />
              <p class="text-2xl font-bold mt-3">2.4K</p>
              <p class="text-sm text-gray-500">Total Views</p>
            </div>

            <div class="bg-white p-6 rounded-2xl border">
              <Heart class="text-red-500" />
              <p class="text-2xl font-bold mt-3">560</p>
              <p class="text-sm text-gray-500">Likes</p>
            </div>

            <div class="bg-white p-6 rounded-2xl border">
              <BookOpen class="text-brand-700" />
              <p class="text-2xl font-bold mt-3">12</p>
              <p class="text-sm text-gray-500">Recipes</p>
            </div>

            <div class="bg-white p-6 rounded-2xl border">
              <TrendingUp class="text-green-600" />
              <p class="text-2xl font-bold mt-3">+18%</p>
              <p class="text-sm text-gray-500">Growth</p>
            </div>
          </div>

          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            <div class="bg-white p-6 rounded-2xl border">
              <h2 class="font-semibold flex items-center gap-2 mb-5">
                <ChefHat /> Recent Recipes
              </h2>

              <div class="space-y-3">
                <div
                  v-for="r in recentRecipes"
                  :key="r.name"
                  class="flex justify-between text-sm border-b pb-2"
                >
                  <span>{{ r.name }}</span>
                  <span class="text-gray-500">
                    {{ r.likes }} • {{ r.views }}
                  </span>
                </div>
              </div>
            </div>

            <div class="bg-white p-6 rounded-2xl border">
              <h2 class="font-semibold flex items-center gap-2 mb-5">
                <Star /> Insights
              </h2>

              <div class="space-y-3 text-sm text-gray-600">
                <div class="p-4 border rounded-xl">
                  Recipes with images perform better.
                </div>
                <div class="p-4 border rounded-xl">
                  Evening posts get more engagement.
                </div>
                <div class="p-4 border rounded-xl">
                  Seasonal recipes trend higher.
                </div>
              </div>
            </div>

          </div>

        </div>
      </main>

    </div>
  </div>
</template>