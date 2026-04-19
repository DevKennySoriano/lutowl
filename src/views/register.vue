<template>
  <div class="min-h-screen bg-surface-100 flex flex-col">
    <Navigation />

    <div class="flex-1 flex items-center justify-center px-4 py-8">
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

            <p v-if="name" :class="nameValid ? ok : bad">
              {{ nameValid ? 'Great name, looks valid' : 'Must be 1–50 characters only' }}
            </p>
          </div>

          <!-- EMAIL -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Email</label>

            <div class="relative">
              <Mail class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="email" type="email" placeholder="you@email.com"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>

            <p v-if="email" :class="emailValid ? ok : bad">
              {{ emailValid ? 'Email format valid' : 'Enter a valid email address' }}
            </p>
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

            <p v-if="phone" :class="phoneValid ? ok : bad">
              {{ phoneValid ? 'Valid PH number' : 'Must start with 9 and be 10 digits' }}
            </p>
          </div>

          <!-- PASSWORD -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Password</label>

            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="password" type="password"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>

            <div v-if="password" class="text-xs mt-1 space-y-1">
              <p :class="rule(password.length >= 8)">• 8+ characters</p>
              <p :class="rule(/[A-Z]/.test(password))">• uppercase letter</p>
              <p :class="rule(/[0-9]/.test(password))">• number</p>
              <p :class="rule(/[^A-Za-z0-9]/.test(password))">• symbol</p>
            </div>
          </div>

          <!-- CONFIRM PASSWORD -->
          <div>
            <label class="text-sm text-gray-500 font-medium">Confirm Password</label>

            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="confirmPassword" type="password"
                class="w-full pl-9 pr-3 py-2 rounded-md border bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>

            <p v-if="confirmPassword" :class="passwordMatch ? ok : bad">
              {{ passwordMatch ? 'Passwords match' : 'Passwords do not match' }}
            </p>
          </div>

          <!-- TERMS -->
          <p class="text-xs text-gray-500 text-center mt-2">
            By registering, you agree to our Terms and Conditions and Privacy Policy.
          </p>

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
const nameValid = computed(() =>
  name.value.length > 0 && name.value.length <= 50
)

const emailValid = computed(() =>
  /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)
)

const phoneValid = computed(() =>
  /^9\d{9}$/.test(phone.value)
)

const passwordMatch = computed(() =>
  password.value === confirmPassword.value
)

const isValid = computed(() =>
  nameValid.value &&
  emailValid.value &&
  phoneValid.value &&
  password.value.length >= 8 &&
  passwordMatch.value
)

const rule = (c) => c ? 'text-green-600' : 'text-gray-400'
const ok = 'text-green-600 text-xs'
const bad = 'text-red-500 text-xs'

/* SIGNUP */
const handleSignup = async () => {

  const confirm = await Swal.fire({
    title: 'Create your account?',
    text: 'Your profile will be created in Lutowl.',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'Yes, Create Account',
    cancelButtonText: 'Cancel',
    reverseButtons: true,
    confirmButtonColor: '#1f2937',
    width: 420
  })

  if (!confirm.isConfirmed) return

  loading.value = true

  Swal.fire({
    title: 'Creating account...',
    text: 'Please wait while we set up your profile.',
    allowOutsideClick: false,
    showConfirmButton: false,
    width: 420,
    didOpen: () => Swal.showLoading()
  })

  const { data, error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value
  })

  if (error) {
    loading.value = false

    Swal.fire({
      icon: 'error',
      title: 'Signup failed',
      text: error.message,
      confirmButtonColor: '#1f2937',
      width: 420
    })
    return
  }

  await supabase.from('accounts_profile').insert({
    user_id: data.user.id,
    username: name.value,
    phone: `+63${phone.value}`
  })

  loading.value = false

  Swal.fire({
    icon: 'success',
    title: 'Account created',
    text: 'You can now log in to your account.',
    confirmButtonColor: '#1f2937',
    width: 420
  })
}
</script>

<style scoped>
.input {
  width: 100%;
  padding: 0.5rem 0.75rem;
  border: 1px solid #e5e7eb;
  border-radius: 6px;
  background: #f9fafb;
  font-size: 14px;
}
.input:focus {
  outline: none;
  border-color: #1f2937;
  background: #fff;
}
</style>