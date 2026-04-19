<template>
  <div class="min-h-screen bg-surface-100 flex flex-col">
    <Navigation />

    <div class="flex-1 flex items-center justify-center px-4 py-10">
      <div class="w-full max-w-md bg-white rounded-2xl shadow px-6 py-10 flex flex-col items-center">

        <!-- HEADER -->
        <div class="flex flex-col items-center gap-2 mb-6 text-center">
          <div class="flex items-center gap-2">
            <UserPlus class="text-brand-700" :size="26" />
            <h1 class="text-2xl font-bold text-brand-900">
              Create your account
            </h1>
          </div>

          <p class="text-sm text-gray-500">
            Already have an account?
            <router-link to="/login" class="text-brand-900 underline ml-1 font-medium">
              Log in
            </router-link>
          </p>
        </div>

        <!-- GOOGLE SIGNUP -->
        <button
          @click="signUpWithGoogle"
          class="w-full flex items-center justify-center gap-2 border border-gray-200 bg-white py-2.5 rounded-md text-sm font-medium hover:bg-gray-50 transition"
        >
          <img
            src="https://www.svgrepo.com/show/475656/google-color.svg"
            class="w-5 h-5"
          />
          Sign up with Google
        </button>

        <!-- DIVIDER -->
        <div class="w-full flex items-center gap-3 my-6">
          <div class="flex-1 h-px bg-gray-200"></div>
          <span class="text-xs text-gray-400">or</span>
          <div class="flex-1 h-px bg-gray-200"></div>
        </div>

        <!-- FORM -->
        <form class="w-full flex flex-col gap-4" @submit.prevent="handleSignup">

          <!-- USERNAME -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Username</label>

            <div class="relative">
              <User class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="name" type="text" placeholder="Your Name"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>
          </div>

          <!-- EMAIL -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Email</label>

            <div class="relative">
              <Mail class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="email" type="email" placeholder="you@email.com"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>
          </div>

          <!-- PHONE -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Phone (Philippines)</label>

            <div class="flex items-center gap-2">
              <span class="flex items-center gap-1 px-3 py-2 bg-gray-100 rounded-md border text-sm">
                <img
                  src="../assets/images/homepage/jp-draws-Philippines-Flag.svg"
                  class="w-5 h-5"
                />
                +63
              </span>

              <input v-model="phone" type="text" maxlength="10"
                placeholder="9123456789"
                @input="phone = phone.replace(/\D/g, '')"
                class="flex-1 px-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>
          </div>

          <!-- PASSWORD -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Password</label>

            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="password" type="password"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>
          </div>

          <!-- CONFIRM -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Confirm Password</label>

            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="confirmPassword" type="password"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>
          </div>

          <!-- BUTTON -->
          <button
            :disabled="!isValid || loading"
            class="bg-brand-900 text-white py-2.5 rounded-md font-semibold
                   hover:bg-brand-800 active:scale-95 transition
                   disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {{ loading ? 'Creating account...' : 'Sign Up' }}
          </button>

        </form>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import { supabase } from '../lib/supabase'
import Swal from 'sweetalert2'
import { UserPlus, User, Mail, Lock } from 'lucide-vue-next'

const name = ref('')
const email = ref('')
const phone = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)

/* VALIDATION */
const isValid = computed(() =>
  name.value &&
  email.value &&
  phone.value &&
  password.value.length >= 8 &&
  password.value === confirmPassword.value
)

/* SIGNUP EMAIL */
const handleSignup = async () => {
  loading.value = true

  const { data, error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value
  })

  if (error) {
    loading.value = false
    Swal.fire('Error', error.message, 'error')
    return
  }

  await supabase.from('accounts_profile').insert({
    user_id: data.user.id,
    username: name.value,
    phone: `+63${phone.value}`
  })

  loading.value = false
  Swal.fire('Success', 'Account created', 'success')
}

/* GOOGLE SIGNUP */
const signUpWithGoogle = async () => {
  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin
    }
  })

  if (error) {
    Swal.fire('Error', error.message, 'error')
  }
}
</script>
