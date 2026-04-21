<script setup>
import { ref, onMounted, computed } from 'vue'
import { supabase } from '../../lib/supabase'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'

import navLogo from '../../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'

import {
  LayoutDashboard,
  BookOpen,
  Heart,
  Settings,
  LogOut,
  User,
  Plus,
  Search,
  TrendingUp,
  Eye,
  MessageCircle,
  Activity,
  ChefHat,
  Star,
  Upload,
  Flame
} from 'lucide-vue-next'

const router = useRouter()

const user = ref(null)
const loading = ref(true)
const activeTab = ref('overview')

const mobileMenuOpen = ref(false)
const showProfileMenu = ref(false)

/* USER */
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

/* NAV */
const tabs = [
  { id: 'overview', label: 'Overview', icon: LayoutDashboard },
  { id: 'recipes', label: 'My Recipes', icon: BookOpen },
  { id: 'favorites', label: 'Favorites', icon: Heart }
]

/* MOCK DATA */
const recentRecipes = [
  { name: 'Spicy Chicken Ramen', likes: 120, views: 430 },
  { name: 'Garlic Butter Shrimp', likes: 98, views: 301 },
  { name: 'Chocolate Lava Cake', likes: 210, views: 880 }
]

const activityFeed = [
  'You liked "Creamy Carbonara"',
  'New comment on your recipe',
  '3 users saved your recipe',
  'Profile updated successfully'
]

/* LOGOUT */
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

/* OUTSIDE CLICK */
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

    <!-- TOP BAR -->
    <header class="h-14 flex items-center justify-between px-4 md:px-6 bg-brand-900 shadow-sm">
      <div class="flex items-center gap-3">
        <button class="md:hidden text-white text-xl" @click="mobileMenuOpen = true">☰</button>
        <img :src="navLogo" class="h-7" />
        <span class="font-bold text-white hidden sm:block">Lutowl</span>
      </div>

      <div class="flex items-center gap-3 relative">
        <span class="text-white/70 text-sm hidden sm:block">{{ displayName }}</span>

        <button id="profile-btn" @click="showProfileMenu = !showProfileMenu">
          <img :src="avatar" class="h-9 w-9 rounded-full border border-white/20" />
        </button>

        <!-- PROFILE MENU -->
        <div v-if="showProfileMenu"
          id="profile-menu"
          class="absolute top-12 right-0 w-52 bg-white rounded-2xl shadow-lg z-50 overflow-hidden">

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

          <button @click="logout"
            class="w-full flex items-center gap-2 px-4 py-3 text-red-600 hover:bg-red-50">
            <LogOut size="16" /> Logout
          </button>
        </div>
      </div>
    </header>

    <div class="flex flex-1 overflow-hidden">

      <!-- SIDEBAR -->
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

      <!-- MAIN -->
      <main class="flex-1 p-4 md:p-8 space-y-8 overflow-y-auto">

        <!-- PAGE HEADER -->
        <div>
          <h1 class="text-3xl font-bold text-brand-900">
            Welcome back, {{ displayName }}
          </h1>
          <p class="text-gray-600 mt-2 max-w-2xl">
            Manage your recipes, track performance, and monitor engagement from your dashboard.
          </p>
        </div>

        <!-- STATS -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">

          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <div class="flex items-center justify-between">
              <Eye class="text-gray-500" />
              <span class="text-xs text-green-600">+12%</span>
            </div>
            <p class="text-2xl font-bold mt-3">2.4K</p>
            <p class="text-sm text-gray-500">Total Views</p>
          </div>

          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <div class="flex items-center justify-between">
              <Heart class="text-red-500" />
              <span class="text-xs text-red-500">+8%</span>
            </div>
            <p class="text-2xl font-bold mt-3">560</p>
            <p class="text-sm text-gray-500">Likes</p>
          </div>

          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <div class="flex items-center justify-between">
              <BookOpen class="text-brand-700" />
              <span class="text-xs text-brand-700">+3</span>
            </div>
            <p class="text-2xl font-bold mt-3">12</p>
            <p class="text-sm text-gray-500">Recipes</p>
          </div>

          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <div class="flex items-center justify-between">
              <TrendingUp class="text-green-600" />
              <span class="text-xs text-green-600">Active</span>
            </div>
            <p class="text-2xl font-bold mt-3">+18%</p>
            <p class="text-sm text-gray-500">Growth</p>
          </div>

        </div>

        <!-- CONTENT -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

          <!-- RECENT RECIPES -->
          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h2 class="font-semibold flex items-center gap-2 mb-5">
              <ChefHat /> Recent Recipes
            </h2>

            <div class="space-y-3">
              <div
                v-for="r in recentRecipes"
                :key="r.name"
                class="flex justify-between items-center py-3 border-b last:border-b-0"
              >
                <span class="text-sm font-medium">{{ r.name }}</span>
                <span class="text-xs text-gray-500">
                  {{ r.likes }} likes • {{ r.views }} views
                </span>
              </div>
            </div>
          </div>

          <!-- INSIGHTS (REPLACES ACTIVITY) -->
          <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <h2 class="font-semibold flex items-center gap-2 mb-5">
              <Star /> Insights
            </h2>

            <div class="space-y-3 text-sm text-gray-600">

              <div class="p-4 border rounded-xl">
                Top performing recipes are those with detailed steps and images.
              </div>

              <div class="p-4 border rounded-xl">
                Engagement is higher during evening hours.
              </div>

              <div class="p-4 border rounded-xl">
                Recipes with seasonal ingredients perform better.
              </div>

            </div>
          </div>

        </div>

      </main>
    </div>
  </div>
</template>