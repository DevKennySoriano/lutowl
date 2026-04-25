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
  Star,
  PlusCircle,
  Pencil,
  Bookmark,
  ThumbsUp
} from 'lucide-vue-next'

const router = useRouter()

const user = ref(null)
const loading = ref(true)
const activeTab = ref('overview')

const showProfileMenu = ref(false)

const expandedTabs = ref({ recipes: true, favorites: false })

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

const navGroups = [
  {
    label: 'Main',
    items: [
      {
        id: 'overview',
        label: 'Overview',
        icon: LayoutDashboard
      },
      {
        id: 'recipes',
        label: 'My Recipes',
        icon: BookOpen,
        children: [
          { id: 'recipes-add', label: 'Add New Recipe', icon: PlusCircle },
          { id: 'recipes-edit', label: 'Edit Recipes', icon: Pencil },
        ]
      },
      {
        id: 'favorites',
        label: 'Favorites',
        icon: Heart,
        children: [
          { id: 'favorites-saved', label: 'Saved', icon: Bookmark },
          { id: 'favorites-liked', label: 'Liked', icon: ThumbsUp },
        ]
      }
    ]
  }
]

const bottomNavTabs = [
  { id: 'overview', label: 'Overview', icon: LayoutDashboard },
  { id: 'recipes', label: 'Recipes', icon: BookOpen },
  { id: 'favorites', label: 'Favorites', icon: Heart },
]

const recentRecipes = [
  { name: 'Spicy Chicken Ramen', likes: 120, views: 430 },
  { name: 'Garlic Butter Shrimp', likes: 98, views: 301 },
  { name: 'Chocolate Lava Cake', likes: 210, views: 880 }
]

const toggleExpand = (id) => {
  expandedTabs.value[id] = !expandedTabs.value[id]
}

const selectTab = (item) => {
  if (item.children) {
    toggleExpand(item.id)
    activeTab.value = item.id
  } else {
    activeTab.value = item.id
  }
}

const isParentActive = (item) => {
  if (activeTab.value === item.id) return true
  if (item.children) return item.children.some(c => c.id === activeTab.value)
  return false
}

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

    <!-- HEADER -->
    <header class="h-14 flex items-center justify-between px-4 md:px-6 bg-brand-900 shadow-sm">
      <div class="flex items-center gap-3">
        <img :src="navLogo" class="h-7" />
        <span class="font-bold text-white hidden sm:block">Lutowl</span>
      </div>

      <div class="flex items-center gap-3 relative">
        <div class="hidden sm:flex flex-col items-end leading-tight">
          <span class="text-white/80 text-sm">{{ displayName }}</span>
          <span
            class="text-xs font-medium"
            :class="verified === 'Verified' ? 'text-green-300' : 'text-red-300'"
          >
            {{ verified }}
          </span>
        </div>

        <button id="profile-btn" @click="showProfileMenu = !showProfileMenu" class="focus:outline-none">
          <img :src="avatar" class="h-9 w-9 rounded-full border border-white/20 hover:border-white/50 transition" />
        </button>

        <div
          v-if="showProfileMenu"
          id="profile-menu"
          class="absolute top-12 right-0 w-52 bg-white rounded-2xl shadow-lg z-50 overflow-hidden border border-gray-100"
        >
          <div class="px-4 py-3 border-b border-gray-100 bg-gray-50">
            <p class="font-semibold text-brand-900 text-sm truncate">{{ displayName }}</p>
            <p class="text-xs mt-0.5" :class="verified === 'Verified' ? 'text-green-600' : 'text-red-500'">
              {{ verified }}
            </p>
          </div>

          <button class="w-full flex items-center gap-2 px-4 py-2.5 hover:bg-gray-50 text-sm text-gray-700 transition">
            <User :size="15" class="text-gray-400" /> Profile
          </button>

          <button class="w-full flex items-center gap-2 px-4 py-2.5 hover:bg-gray-50 text-sm text-gray-700 transition">
            <Settings :size="15" class="text-gray-400" /> Settings
          </button>

          <div class="border-t border-gray-100">
            <button
              @click="logout"
              class="w-full flex items-center gap-2 px-4 py-2.5 text-sm text-red-500 hover:bg-red-50 transition"
            >
              <LogOut :size="15" /> Logout
            </button>
          </div>
        </div>
      </div>
    </header>

    <div class="flex flex-1 overflow-hidden">

      <!-- SIDEBAR (desktop only) -->
      <aside class="hidden md:flex w-64 flex-col bg-brand-900">
        <nav class="p-4 flex-1 space-y-4 overflow-y-auto">
          <div v-for="group in navGroups" :key="group.label">
            <p class="text-[10px] font-semibold uppercase tracking-widest text-white/30 px-2 mb-2">
              {{ group.label }}
            </p>

            <div class="space-y-0.5">
              <template v-for="item in group.items" :key="item.id">

                <button
                  @click="selectTab(item)"
                  class="w-full flex items-center justify-between px-3 py-2.5 rounded-xl text-sm transition"
                  :class="isParentActive(item)
                    ? 'bg-brand-700 text-white font-medium'
                    : 'text-white/70 hover:bg-brand-700/40 hover:text-white'"
                >
                  <div class="flex items-center gap-3">
                    <component :is="item.icon" :size="16" />
                    {{ item.label }}
                  </div>
                  <svg
                    v-if="item.children"
                    :class="expandedTabs[item.id] ? 'rotate-180' : ''"
                    class="w-3.5 h-3.5 text-white/40 transition-transform duration-200"
                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                  >
                    <polyline points="6 9 12 15 18 9" />
                  </svg>
                </button>

                <div
                  v-if="item.children && expandedTabs[item.id]"
                  class="ml-4 mt-0.5 space-y-0.5 border-l border-white/10 pl-3"
                >
                  <button
                    v-for="child in item.children"
                    :key="child.id"
                    @click="activeTab = child.id"
                    class="w-full flex items-center gap-2.5 px-3 py-2 rounded-xl text-xs transition"
                    :class="activeTab === child.id
                      ? 'bg-white/10 text-white font-medium'
                      : 'text-white/50 hover:bg-white/10 hover:text-white/80'"
                  >
                    <component :is="child.icon" :size="13" />
                    {{ child.label }}
                  </button>
                </div>

              </template>
            </div>
          </div>
        </nav>
      </aside>

      <!-- MAIN -->
      <main class="flex-1 overflow-y-auto pb-20 md:pb-0">
        <div class="max-w-7xl mx-auto p-4 md:p-8 space-y-8">

          <!-- WELCOME BANNER -->
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
                  Welcome back, {{ displayName }} 👋
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

          <!-- STATS -->
          <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <div class="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition">
              <div class="flex items-center justify-between mb-3">
                <div class="p-2 rounded-xl bg-purple-50">
                  <Eye :size="15" class="text-brand-700" />
                </div>
                <span class="text-xs text-green-500 font-medium">+12%</span>
              </div>
              <p class="text-2xl font-bold text-gray-900">2.4K</p>
              <p class="text-sm text-gray-400 mt-0.5">Total Views</p>
            </div>

            <div class="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition">
              <div class="flex items-center justify-between mb-3">
                <div class="p-2 rounded-xl bg-red-50">
                  <Heart :size="15" class="text-red-400" />
                </div>
                <span class="text-xs text-green-500 font-medium">+8%</span>
              </div>
              <p class="text-2xl font-bold text-gray-900">560</p>
              <p class="text-sm text-gray-400 mt-0.5">Likes</p>
            </div>

            <div class="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition">
              <div class="flex items-center justify-between mb-3">
                <div class="p-2 rounded-xl bg-purple-50">
                  <BookOpen :size="15" class="text-brand-700" />
                </div>
                <span class="text-xs text-gray-400 font-medium">2 drafts</span>
              </div>
              <p class="text-2xl font-bold text-gray-900">12</p>
              <p class="text-sm text-gray-400 mt-0.5">Recipes</p>
            </div>

            <div class="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition">
              <div class="flex items-center justify-between mb-3">
                <div class="p-2 rounded-xl bg-green-50">
                  <TrendingUp :size="15" class="text-green-500" />
                </div>
                <span class="text-xs text-green-500 font-medium">↑ month</span>
              </div>
              <p class="text-2xl font-bold text-gray-900">+18%</p>
              <p class="text-sm text-gray-400 mt-0.5">Growth</p>
            </div>
          </div>

          <!-- BOTTOM CARDS -->
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

            <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
              <h2 class="font-semibold flex items-center gap-2 mb-4 text-gray-800">
                <div class="p-1.5 rounded-lg bg-purple-50">
                  <ChefHat :size="14" class="text-brand-700" />
                </div>
                Recent Recipes
              </h2>

              <div class="space-y-1">
                <div
                  v-for="r in recentRecipes"
                  :key="r.name"
                  class="flex items-center justify-between py-2.5 px-3 rounded-xl hover:bg-gray-50 transition group"
                >
                  <div class="flex items-center gap-2.5">
                    <div class="w-1.5 h-1.5 rounded-full bg-brand-400 shrink-0"></div>
                    <span class="text-sm text-gray-700 group-hover:text-brand-900 transition">{{ r.name }}</span>
                  </div>
                  <div class="flex items-center gap-3 text-xs text-gray-400">
                    <span class="flex items-center gap-1">
                      <Heart :size="10" class="text-red-300" /> {{ r.likes }}
                    </span>
                    <span class="flex items-center gap-1">
                      <Eye :size="10" class="text-gray-300" /> {{ r.views }}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
              <h2 class="font-semibold flex items-center gap-2 mb-4 text-gray-800">
                <div class="p-1.5 rounded-lg bg-yellow-50">
                  <Star :size="14" class="text-yellow-500" />
                </div>
                Insights
              </h2>

              <div class="space-y-2 text-sm text-gray-600">
                <div class="flex items-start gap-3 p-3 rounded-xl bg-gray-50 border border-gray-100">
                  <div class="w-1.5 h-1.5 rounded-full bg-purple-400 mt-1.5 shrink-0"></div>
                  <p class="leading-relaxed">Recipes with images perform <span class="font-medium text-gray-800">3x better</span> than those without.</p>
                </div>
                <div class="flex items-start gap-3 p-3 rounded-xl bg-gray-50 border border-gray-100">
                  <div class="w-1.5 h-1.5 rounded-full bg-purple-400 mt-1.5 shrink-0"></div>
                  <p class="leading-relaxed">Evening posts <span class="font-medium text-gray-800">(6–9 PM)</span> get the most engagement.</p>
                </div>
                <div class="flex items-start gap-3 p-3 rounded-xl bg-gray-50 border border-gray-100">
                  <div class="w-1.5 h-1.5 rounded-full bg-purple-400 mt-1.5 shrink-0"></div>
                  <p class="leading-relaxed">Seasonal recipes <span class="font-medium text-gray-800">trend higher</span> during holidays.</p>
                </div>
              </div>
            </div>

          </div>

        </div>
      </main>

    </div>

    <!-- BOTTOM NAV (mobile/tablet only) -->
    <nav class="md:hidden fixed bottom-0 left-0 right-0 z-40 bg-brand-900 border-t border-white/10 flex items-center">
      <button
        v-for="tab in bottomNavTabs"
        :key="tab.id"
        @click="activeTab = tab.id"
        class="flex-1 flex flex-col items-center justify-center py-2.5 gap-1 transition"
        :class="activeTab === tab.id ? 'text-white' : 'text-white/40'"
      >
        <div
          class="w-8 h-0.5 rounded-full mb-1 transition-all"
          :class="activeTab === tab.id ? 'bg-white' : 'bg-transparent'"
        ></div>
        <component :is="tab.icon" :size="20" />
        <span class="text-[10px] font-medium">{{ tab.label }}</span>
      </button>
    </nav>

  </div>
</template>