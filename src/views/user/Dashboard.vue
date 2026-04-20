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
  User
} from 'lucide-vue-next'

const router = useRouter()

const user = ref(null)
const loading = ref(true)

const activeTab = ref('overview')

/* UI STATE */
const mobileMenuOpen = ref(false)
const showProfileMenu = ref(false)

/* FETCH USER */
const fetchUser = async () => {
  const { data } = await supabase.auth.getUser()
  user.value = data.user
  loading.value = false
}

/* PROFILE */
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

/* TABS */
const tabs = [
  { id: 'overview', label: 'Overview', icon: LayoutDashboard },
  { id: 'recipes', label: 'My Recipes', icon: BookOpen },
  { id: 'favorites', label: 'Favorites', icon: Heart }
]

/* LOGOUT */
const logout = async () => {

  const res = await Swal.fire({
    title: 'Logout from Lutowl?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#ad49e1',
    cancelButtonColor: '#6c757d',
    confirmButtonText: 'Yes, Logout',
    cancelButtonText: 'Cancel',
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

    <!-- ================= TOP NAV (BLENDED, NO BORDER LINE) ================= -->
    <header class="h-14 flex items-center justify-between px-4 md:px-6 bg-brand-900">

      <div class="flex items-center gap-3">
        <button class="md:hidden text-white text-xl" @click="mobileMenuOpen = true">
          ☰
        </button>

        <img :src="navLogo" class="h-7" />
        <span class="font-bold text-white hidden sm:block">Lutowl</span>
      </div>

      <div class="flex items-center gap-3 relative">

        <span class="text-white/70 text-sm hidden sm:block">
          {{ displayName }}
        </span>

        <!-- PROFILE BUTTON -->
        <button
          id="profile-btn"
          @click="showProfileMenu = !showProfileMenu"
          class="flex items-center"
        >
          <img :src="avatar" class="h-9 w-9 rounded-full border border-white/20" />
        </button>

        <!-- PROFILE POPUP -->
        <div
          v-if="showProfileMenu"
          id="profile-menu"
          class="absolute top-12 right-0 w-52 bg-white text-surface-900 rounded-2xl shadow-[0_2px_12px_rgba(38,38,38,0.08)] overflow-hidden z-50 animate-fadeIn"
        >

          <div class="px-4 py-3 border-b border-gray-200 bg-surface-50">
            <p class="font-semibold text-brand-900">{{ displayName }}</p>
            <p class="text-xs text-surface-900/60">{{ verified }}</p>
          </div>

          <button class="w-full flex items-center gap-2 px-4 py-3 hover:bg-surface-200 text-surface-900">
            <User :size="16" />
            Profile
          </button>

          <button class="w-full flex items-center gap-2 px-4 py-3 hover:bg-surface-200 text-surface-900">
            <Settings :size="16" />
            Settings
          </button>

          <button
            @click="logout"
            class="w-full flex items-center gap-2 px-4 py-3 text-red-600 hover:bg-red-50 font-semibold"
          >
            <LogOut :size="16" />
            Logout
          </button>

        </div>

      </div>

    </header>

    <!-- ================= BODY ================= -->
    <div class="flex flex-1 overflow-hidden">

      <!-- ================= SIDEBAR (NO BORDER LINE, BLENDED) ================= -->
      <aside class="hidden md:flex w-64 flex-col bg-brand-900">

        <nav class="p-4 space-y-2">

          <button
            v-for="tab in tabs"
            :key="tab.id"
            @click="activeTab = tab.id"
            class="w-full flex items-center gap-3 px-4 py-2 rounded-xl transition text-white/80 font-semibold"
            :class="activeTab === tab.id ? 'bg-brand-700 text-white' : 'hover:bg-brand-700/40'"
          >
            <component :is="tab.icon" :size="18" />
            {{ tab.label }}
          </button>

        </nav>

      </aside>

      <!-- ================= MOBILE DRAWER ================= -->
      <div
        v-if="mobileMenuOpen"
        class="fixed inset-0 bg-black/50 z-50 md:hidden"
        @click="mobileMenuOpen = false"
      >
        <div class="w-64 h-full bg-brand-900 p-4" @click.stop>

          <div class="flex items-center gap-3 mb-6">
            <img :src="navLogo" class="h-8" />
            <span class="font-bold text-white">Lutowl</span>
          </div>

          <nav class="space-y-2">
            <button
              v-for="tab in tabs"
              :key="tab.id"
              @click="activeTab = tab.id; mobileMenuOpen = false"
              class="w-full flex items-center gap-3 px-4 py-2 rounded-xl text-white/80"
              :class="activeTab === tab.id ? 'bg-brand-700 text-white' : 'hover:bg-brand-700/40'"
            >
              <component :is="tab.icon" :size="18" />
              {{ tab.label }}
            </button>
          </nav>

        </div>
      </div>

      <!-- ================= MAIN ================= -->
      <main class="flex-1 p-4 md:p-6 overflow-y-auto bg-surface-100 text-surface-900 rounded-tl-2xl">

        <div v-if="loading" class="text-center text-surface-900/60">
          Loading dashboard...
        </div>

        <div v-else class="max-w-6xl mx-auto space-y-6">

          <h1 class="text-3xl md:text-4xl font-bold tracking-tight text-brand-900">
            {{ activeTab.charAt(0).toUpperCase() + activeTab.slice(1) }}
          </h1>

          <div v-if="activeTab === 'overview'" class="grid md:grid-cols-3 gap-4">
            <div class="bg-white p-6 rounded-2xl shadow-[0_2px_12px_rgba(38,38,38,0.08)] text-surface-900">
              <span class="block text-lg font-semibold text-brand-700 mb-2">Welcome</span>
              <span class="block text-xl font-bold">{{ displayName }}</span>
            </div>
            <div class="bg-white p-6 rounded-2xl shadow-[0_2px_12px_rgba(38,38,38,0.08)] text-surface-900">
              <span class="block text-sm text-surface-900/70 mb-1">Email</span>
              <span class="block font-semibold">{{ user?.email }}</span>
            </div>
            <div class="bg-white p-6 rounded-2xl shadow-[0_2px_12px_rgba(38,38,38,0.08)] text-surface-900">
              <span class="block text-sm text-surface-900/70 mb-1">Status</span>
              <span class="block font-semibold">{{ verified }}</span>
            </div>
          </div>

        </div>

      </main>

    </div>

  </div>
</template>

<style scoped>
.animate-fadeIn {
  animation: fadeIn 0.15s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(8px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>