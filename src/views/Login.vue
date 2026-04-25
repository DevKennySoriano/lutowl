<template>
<div class="min-h-screen flex flex-col login-bg-pattern">
    <Navigation />

    <div class="flex-1 flex items-center justify-center px-4 py-16">
      <div class="w-full max-w-md bg-white rounded-2xl shadow px-6 py-14 flex flex-col items-center">

        <!-- HEADER -->
        <div class="flex flex-col items-center gap-2 mb-8 text-center">
          <div class="flex items-center gap-2">
            <User class="text-brand-700 w-6 h-6" />
            <h1 class="text-2xl font-bold text-brand-900">
              Login to your account
            </h1>
          </div>

          <p class="text-sm text-gray-500">
            Don't have an account?
            <router-link to="/register" class="text-brand-900 underline ml-1 font-medium">
              Create one
            </router-link>
          </p>
        </div>

        <!-- FORM -->
        <form class="w-full flex flex-col gap-4" @submit.prevent="handleLogin">

          <!-- EMAIL -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Email</label>

            <div class="relative">
              <Mail class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-4 h-4" />
              <input
                v-model="email"
                type="email"
                placeholder="you@email.com"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition"
              />
            </div>
          </div>

          <!-- PASSWORD -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Password</label>

            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-4 h-4" />
              <input
                v-model="password"
                type="password"
                placeholder="Password"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition"
              />
            </div>

            <!-- OPTIONS ROW -->
            <div class="flex items-center justify-between mt-3">

              <!-- REMEMBER ME -->
              <label class="flex items-center gap-2 text-xs text-gray-500 cursor-pointer">
                <input
                  type="checkbox"
                  v-model="rememberMe"
                  class="accent-brand-700"
                />
                Remember me
              </label>

              <!-- FORGOT PASSWORD -->
              <router-link
                to="/forgot-password"
                class="text-xs text-brand-700 hover:underline"
              >
                Forgot password?
              </router-link>

            </div>
          </div>

          <!-- LOGIN BUTTON -->
          <button
            :disabled="loading"
            class="bg-brand-900 text-white py-2.5 rounded-md font-semibold
                   hover:bg-brand-800 active:scale-95 transition
                   disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ loading ? 'Logging in...' : 'Log In' }}
          </button>
        </form>

        <!-- DIVIDER -->
        <div class="w-full flex items-center gap-3 my-7">
          <div class="flex-1 h-px bg-gray-200"></div>
          <span class="text-xs text-gray-400">or</span>
          <div class="flex-1 h-px bg-gray-200"></div>
        </div>

        <!-- GOOGLE LOGIN -->
        <button
          @click="loginWithGoogle"
          class="w-full flex items-center justify-center gap-2 border border-gray-200 bg-white py-2.5 rounded-md text-sm font-medium hover:bg-gray-50 transition"
        >
          <img
            src="https://www.svgrepo.com/show/475656/google-color.svg"
            class="w-5 h-5"
          />
          Continue with Google
        </button>

      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import { supabase } from '../lib/supabase'
import Swal from 'sweetalert2'
import { User, Mail, Lock } from 'lucide-vue-next'
import { useRouter } from 'vue-router'

const router = useRouter()
const email = ref('')
const password = ref('')
const rememberMe = ref(false)
const loading = ref(false)

const handleLogin = async () => {
  loading.value = true

  const { error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value
  })

  loading.value = false

  if (error) {
    Swal.fire({
      icon: 'error',
      title: 'Login failed',
      text: error.message,
      confirmButtonColor: '#1f2937'
    })
    return
  }

  await Swal.fire({
  icon: 'success',
  title: 'Login successful',
  text: rememberMe.value
    ? 'You will stay signed in on this device.'
    : 'Welcome back to Lutowl',
  allowOutsideClick: false,
  allowEscapeKey: false,
  showConfirmButton: false,
  timer: 1500,
  timerProgressBar: true
})

router.push('/')
}

/* GOOGLE LOGIN */
const loginWithGoogle = async () => {
  await supabase.auth.signOut()

  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin,
      queryParams: {
        prompt: 'select_account'
      }
    }
  })

  if (error) {
    Swal.fire({
      icon: 'error',
      title: 'Google login failed',
      text: error.message
    })
  }
}
</script>

<style scoped>

  .login-bg-pattern {
    --s: 200px; /* control the size */
    --c1: var(--color-brand-700, #7a1cac); /* purple */
    --c2: #fff; /* white */
    --c3: var(--color-brand-400, #816797); /* lighter purple */
    background:
      repeating-conic-gradient(from 30deg,#0000 0 120deg,var(--c3) 0 50%) 
        calc(var(--s)/2) calc(var(--s)*0.2887),
      repeating-conic-gradient(from 30deg,var(--c1) 0 60deg,var(--c2) 0 120deg,var(--c3) 0 50%);
    background-size: var(--s) calc(var(--s)*0.5774);
  }

</style>
