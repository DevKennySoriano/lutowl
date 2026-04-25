<template>
  <nav class="sticky top-0 z-[100] w-full border-b border-[rgba(46,7,63,0.14)] bg-[rgba(247,247,247,0.96)] shadow-[0_8px_20px_rgba(38,38,38,0.06)] backdrop-blur-md">

    <div class="px-4 py-3 sm:px-6 lg:px-8">


      <div class="flex flex-wrap items-center justify-between gap-y-3">

        <div class="flex items-center gap-3">
          <img
            :src="navLogo"
            alt="Lutowl logo"
            class="h-10 w-auto rounded-[10px] border border-[rgba(46,7,63,0.25)] bg-white shadow-[0_6px_14px_rgba(38,38,38,0.08)]"
          />
          <span class="text-2xl font-bold text-brand-700 tracking-wide select-none">
            Lutowl
          </span>
        </div>

  
        <ul
          class="order-3 w-full flex justify-center gap-6 mt-2
                 lg:order-none lg:w-auto lg:mt-0 lg:flex-1"
        >
          <li>
            <router-link to="/" class="nav-link" active-class="nav-active">
              Home
            </router-link>
          </li>

          <li>
            <router-link to="/discover" class="nav-link" active-class="nav-active">
              Discover
            </router-link>
          </li>

          <li>
            <router-link to="/about" class="nav-link" active-class="nav-active">
              About
            </router-link>
          </li>
        </ul>


        <div class="flex items-center gap-3 relative">

  
          <div v-if="!user" class="flex gap-2">
            <router-link to="/login" class="auth-btn-outline">
              Log In
            </router-link>

            <router-link to="/register" class="auth-btn">
              Register
            </router-link>
          </div>


          <div v-else class="relative">

  
            <button @click="toggleMenu" class="flex items-center gap-2">
              <img v-if="avatar" :src="avatar" class="w-9 h-9 rounded-full border" />

              <div
                v-else
                class="w-9 h-9 rounded-full bg-brand-700 text-white flex items-center justify-center text-sm"
              >
                {{ userEmail?.[0]?.toUpperCase() }}
              </div>
            </button>

            <!-- DROPDOWN -->
            <div
              v-if="menuOpen"
              class="absolute right-0 mt-2 w-44 bg-white shadow-lg rounded-lg border py-2"
            >
              <div class="px-3 py-2 text-xs text-gray-500 border-b">
                {{ userEmail }}
              </div>

              <router-link
                to="/user/dashboard"
                class="block px-3 py-2 text-sm hover:bg-gray-100"
                @click="menuOpen = false"
              >
                Dashboard
              </router-link>

              <button
                @click="logout"
                class="w-full text-left px-3 py-2 text-sm text-red-500 hover:bg-gray-100"
              >
                Logout
              </button>
            </div>

          </div>

        </div>

      </div>
    </div>

  </nav>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '../lib/supabase'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'
import navLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'

const router = useRouter()

const user = ref(null)
const userEmail = ref('')
const avatar = ref('')
const menuOpen = ref(false)

const toggleMenu = () => {
  menuOpen.value = !menuOpen.value
}


onMounted(async () => {
  const { data } = await supabase.auth.getUser()

  if (data?.user) {
    user.value = data.user
    userEmail.value = data.user.email

    avatar.value =
      data.user.user_metadata?.avatar_url ||
      data.user.user_metadata?.picture ||
      ''
  }

  supabase.auth.onAuthStateChange((_event, session) => {
    user.value = session?.user || null
    userEmail.value = session?.user?.email || ''

    avatar.value =
      session?.user?.user_metadata?.avatar_url ||
      session?.user?.user_metadata?.picture ||
      ''
  })
})


const logout = async () => {
  const result = await Swal.fire({
    title: 'Logout?',
    text: 'You will be signed out of your account.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes, Logout',
    cancelButtonText: 'Cancel',
    reverseButtons: true,
    confirmButtonColor: '#dc2626',
    cancelButtonColor: '#6b7280'
  })

  if (!result.isConfirmed) return


  Swal.fire({
    title: 'Signing out...',
    text: 'Please wait',
    allowOutsideClick: false,
    allowEscapeKey: false,
    showConfirmButton: false,
    didOpen: () => {
      Swal.showLoading()
    }
  })


  await supabase.auth.signOut()

  user.value = null
  menuOpen.value = false


  setTimeout(() => {
    Swal.close()
    router.push('/login')
  }, 800)
}
</script>

<style scoped>
.nav-link {
  border-bottom: 2px solid transparent;
  padding: 0.5rem 0;
  font-size: 0.875rem;
  font-weight: 600;
  color: #2e073f;
  transition: 0.2s;
}

.nav-link:hover {
  border-color: #7c3aed;
  color: #6d28d9;
}

.nav-active {
  border-color: #7c3aed !important;
  color: #7c3aed !important;
}

.auth-btn {
  border-radius: 12px;
  background: #6d28d9;
  padding: 0.5rem 1.25rem;
  font-size: 0.875rem;
  font-weight: 600;
  color: white;
}

.auth-btn:hover {
  background: #2e073f;
}

.auth-btn-outline {
  border-radius: 12px;
  border: 1px solid #6d28d9;
  padding: 0.5rem 1.25rem;
  font-size: 0.875rem;
  font-weight: 600;
  color: #6d28d9;
}

.auth-btn-outline:hover {
  background: #6d28d9;
  color: white;
}
</style>