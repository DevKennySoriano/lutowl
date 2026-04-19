<template>
  <div class="min-h-screen bg-surface-100 flex flex-col">
    <Navigation />

    <div class="flex-1 flex items-center justify-center px-4 py-8">
      <div class="w-full max-w-md bg-white rounded-2xl shadow-[0_6px_24px_rgba(0,0,0,0.06)] px-6 py-10 flex flex-col items-center">
        
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

        <form class="w-full flex flex-col gap-4">
          
          <!-- Name -->
          <div class="flex flex-col gap-1">
            <label class="text-sm text-gray-500 font-medium">Name</label>
            <div class="relative">
              <User class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="name" type="text" placeholder="Your Name"
                class="w-full pl-9 pr-3 py-2 rounded-md border border-gray-200 bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>

            <p v-if="name" :class="nameValid ? 'text-green-600 text-xs' : 'text-red-500 text-xs'">
              {{ nameValid
                ? 'Nice, name looks clean and valid.'
                : 'Almost there, keep it within 50 characters.' }}
            </p>
          </div>

          <!-- Email -->
          <div class="flex flex-col gap-1">
            <label class="text-sm text-gray-500 font-medium">Email</label>
            <div class="relative">
              <Mail class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input v-model="email" type="email" placeholder="you@email.com"
                class="w-full pl-9 pr-3 py-2 rounded-md border border-gray-200 bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition" />
            </div>

            <p v-if="email" :class="emailValid ? 'text-green-600 text-xs' : 'text-red-500 text-xs'">
              {{ emailValid
                ? 'Perfect, email format checks out.'
                : 'Invalid format, please enter a valid email address.' }}
            </p>
          </div>

          <!-- Password -->
          <div class="flex flex-col gap-1">
            <label class="text-sm text-gray-500 font-medium">Password</label>
            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input
                v-model="password"
                @focus="passwordFocused = true"
                @blur="passwordFocused = false"
                type="password"
                placeholder="Password"
                class="w-full pl-9 pr-3 py-2 rounded-md border border-gray-200 bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition"
              />
            </div>

            <div v-if="passwordFocused || password" class="text-xs mt-1 space-y-1">
              <p :class="ruleClass(password.length >= 8)">
                • {{ password.length >= 8 ? 'Good length, secure baseline achieved' : 'Use at least 8 characters' }}
              </p>
              <p :class="ruleClass(/[A-Z]/.test(password))">
                • {{ /[A-Z]/.test(password) ? 'Uppercase detected, strong signal' : 'Add 1 uppercase letter' }}
              </p>
              <p :class="ruleClass(/[0-9]/.test(password))">
                • {{ /[0-9]/.test(password) ? 'Number included, nice' : 'Include at least 1 number' }}
              </p>
              <p :class="ruleClass(/[^A-Za-z0-9]/.test(password))">
                • {{ /[^A-Za-z0-9]/.test(password) ? 'Symbol added, extra security' : 'Add a special character' }}
              </p>
            </div>
          </div>

          <!-- Confirm Password -->
          <div class="flex flex-col gap-1">
            <label class="text-sm text-gray-500 font-medium">Confirm Password</label>
            <div class="relative">
              <Lock class="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" :size="16" />
              <input
                v-model="confirmPassword"
                @focus="confirmFocused = true"
                @blur="confirmFocused = false"
                type="password"
                placeholder="Confirm Password"
                class="w-full pl-9 pr-3 py-2 rounded-md border border-gray-200 bg-gray-50 text-sm focus:outline-none focus:border-brand-700 focus:bg-white transition"
              />
            </div>

            <p
              v-if="confirmFocused || confirmPassword"
              :class="passwordMatch ? 'text-green-600 text-xs mt-1' : 'text-red-500 text-xs mt-1'"
            >
              {{ passwordMatch
                ? 'Matched, everything aligns perfectly'
                : 'Mismatch detected, passwords do not match' }}
            </p>
          </div>

          <!-- Terms -->
          <p class="text-xs text-gray-500 text-center mt-2 leading-relaxed">
            By registering, you agree to our
            <span class="text-brand-900 font-medium underline cursor-pointer">Terms and Conditions</span>
            and
            <span class="text-brand-900 font-medium underline cursor-pointer">Privacy Policy</span>.
          </p>

          <!-- Submit -->
          <button
            :disabled="!isValid"
            class="mt-2 flex items-center justify-center gap-2 bg-brand-900 text-white py-2.5 rounded-md text-sm font-semibold hover:bg-brand-800 transition disabled:opacity-50 disabled:cursor-not-allowed"
            type="submit"
          >
            <UserPlus :size="16" />
            Sign Up
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
import { User, Mail, Lock, UserPlus } from 'lucide-vue-next'

const name = ref('')
const email = ref('')
const password = ref('')
const confirmPassword = ref('')

const passwordFocused = ref(false)
const confirmFocused = ref(false)

const nameValid = computed(() => name.value.length > 0 && name.value.length <= 50)

const emailValid = computed(() =>
  /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)
)

const passwordValid = computed(() => {
  return password.value.length >= 8 &&
    /[A-Z]/.test(password.value) &&
    /[0-9]/.test(password.value) &&
    /[^A-Za-z0-9]/.test(password.value)
})

const passwordMatch = computed(() => password.value === confirmPassword.value)

const isValid = computed(() =>
  nameValid.value &&
  emailValid.value &&
  passwordValid.value &&
  passwordMatch.value
)

const ruleClass = (condition) =>
  condition ? 'text-green-600' : 'text-gray-400'
</script>