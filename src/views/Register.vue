<template>
  <div class="min-h-screen flex flex-col login-bg-pattern relative">
    <div v-if="loading" class="fixed inset-0 z-50 bg-white opacity-80 pointer-events-auto"></div>
    <div v-show="!loading">
      <Navigation />

      <div class="flex-1 flex items-center justify-center px-4 py-6">
        <div class="w-full max-w-lg bg-white rounded-2xl shadow px-6 py-6 flex flex-col items-center">
          <!-- HEADER -->
          <div class="flex flex-col items-center gap-2 mb-4 text-center">
            <div class="flex items-center gap-2">
              <UserPlus class="text-brand-700" :size="24" />
              <h1 class="text-xl font-bold text-brand-900">
                Create your account
              </h1>
            </div>
            <p class="text-sm text-gray-500">
              Create your account to continue.
            </p>
            <p class="text-xs text-gray-400">
              Already have an account?
              <router-link to="/login" class="text-brand-900 underline ml-1 font-medium">
                Log in
              </router-link>
            </p>
          </div>
          <!-- GOOGLE -->
          <button
            @click="signUpWithGoogle"
            class="w-full flex items-center justify-center gap-2 border border-gray-200 bg-white py-2 rounded-md text-sm font-medium hover:bg-gray-50 transition"
          >
            <img src="https://www.svgrepo.com/show/475656/google-color.svg" class="w-5 h-5" />
            Continue with Google
          </button>
          <!-- DIVIDER -->
          <div class="w-full flex items-center gap-3 my-4">
            <div class="flex-1 h-px bg-gray-200"></div>
            <span class="text-xs text-gray-400">or</span>
            <div class="flex-1 h-px bg-gray-200"></div>
          </div>
          <!-- FORM -->
          <form class="w-full flex flex-col gap-3" @submit.prevent="handleSignup">
            <!-- NAME -->
            <div>
              <label class="label">Username</label>
              <input v-model="name" type="text" placeholder="Enter your username" class="input" />
              <p v-if="errors.name" class="error">{{ errors.name }}</p>
            </div>
            <!-- EMAIL -->
            <div>
              <label class="label">Email</label>
              <input v-model="email" type="email" placeholder="example@email.com" class="input" />
              <p v-if="errors.email" class="error">{{ errors.email }}</p>
            </div>
            <!-- PHONE -->
            <div>
              <label class="label">Phone</label>
              <div class="flex items-center gap-2">
                <span class="flex items-center gap-1 px-3 py-2 bg-gray-100 border rounded-md text-sm">
                  <img
                    src="../assets/images/homepage/jp-draws-Philippines-Flag.svg"
                    class="w-5 h-5"
                  />
                  +63
                </span>
                <input
                  v-model="phone"
                  type="text"
                  maxlength="10"
                  placeholder="9123456789"
                  @input="phone = phone.replace(/\D/g, '')"
                  class="input flex-1"
                />
              </div>
              <p v-if="errors.phone" class="error">{{ errors.phone }}</p>
            </div>
            <!-- PASSWORD -->
            <div>
              <label class="label">Password</label>
              <input
                v-model="password"
                type="password"
                placeholder="Enter a strong password"
                class="input"
              />
              <!-- PASSWORD CHECKLIST -->
              <div v-if="password.length > 0" class="mt-1 text-xs space-y-1">
                <p :class="checkClass(password.length >= 8)">• At least 8 characters</p>
                <p :class="checkClass(hasUppercase)">• One uppercase letter</p>
                <p :class="checkClass(hasNumber)">• One number</p>
                <p :class="checkClass(hasSymbol)">• One special character</p>
              </div>
              <p v-if="errors.password" class="error">{{ errors.password }}</p>
            </div>
            <!-- CONFIRM -->
            <div>
              <label class="label">Confirm Password</label>
              <input
                v-model="confirmPassword"
                type="password"
                placeholder="Re-enter password"
                class="input"
              />
              <p v-if="errors.confirmPassword" class="error">
                {{ errors.confirmPassword }}
              </p>
            </div>
            <!-- BUTTON -->
                <button
            :disabled="loading || !isFormValid"
            class="bg-brand-900 text-white py-2 rounded-md font-semibold
                  hover:bg-brand-800 transition
                  disabled:opacity-50 disabled:cursor-not-allowed
                  disabled:hover:bg-brand-900"
          >
            {{ loading ? 'Creating account...' : 'Create Account' }}
          </button>
          </form>
        </div>
      </div>
      <Footer />
    </div>
  </div>
</template>

<script setup>

import { ref, watch, computed } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import { supabase } from '../lib/supabase'
import Swal from 'sweetalert2'
import { UserPlus } from 'lucide-vue-next'
import { useRouter } from 'vue-router'
const router = useRouter()

const name = ref('')
const email = ref('')
const phone = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)

const errors = ref({})

const hasUppercase = computed(() => /[A-Z]/.test(password.value))
const hasNumber = computed(() => /[0-9]/.test(password.value))
const hasSymbol = computed(() => /[^A-Za-z0-9]/.test(password.value))

watch([name, email, phone, password, confirmPassword], () => {
  validate()
})
const validate = () => {
  const newErrors = {}

  // USERNAME (only validate if user typed something)
  if (name.value && !name.value.trim()) {
    newErrors.name = 'Username is required'
  }

  // EMAIL
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (email.value && !emailRegex.test(email.value)) {
    newErrors.email = 'Enter a valid email address'
  }

  // PHONE
  if (phone.value && phone.value.length !== 10) {
    newErrors.phone = 'Enter a valid 10-digit number'
  }

  // PASSWORD
  if (password.value) {
    if (
      password.value.length < 8 ||
      !hasUppercase.value ||
      !hasNumber.value ||
      !hasSymbol.value
    ) {
      newErrors.password = 'Password does not meet requirements'
    }
  }

  // CONFIRM PASSWORD
  if (confirmPassword.value) {
    if (confirmPassword.value !== password.value) {
      newErrors.confirmPassword = 'Passwords do not match'
    }
  }

  errors.value = newErrors
}
const isFormValid = computed(() => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

  return (
    name.value &&
    emailRegex.test(email.value) &&
    phone.value.length === 10 &&
    password.value.length >= 8 &&
    hasUppercase.value &&
    hasNumber.value &&
    hasSymbol.value &&
    confirmPassword.value === password.value
  )
})

const hasErrors = computed(() => Object.keys(errors.value).length > 0)

const checkClass = (valid) =>
  valid ? 'text-green-600' : 'text-gray-400'

const handleSignup = async () => {
  validate()
  if (hasErrors.value) return

  // Show confirmation dialog
  const res = await Swal.fire({
    title: 'Confirm your details',
    html: `
      <div style='text-align:left'>
        <b>Username:</b> ${name.value}<br>
        <b>Email:</b> ${email.value}<br>
        <b>Phone:</b> +63${phone.value}
      </div>
    `,
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#ad49e1', // Theme main button color
    cancelButtonColor: '#6c757d',
    confirmButtonText: 'Yes, Create Account',
    cancelButtonText: 'Cancel',
    reverseButtons: true
  })
  if (!res.isConfirmed) return

  loading.value = true

  // Show loading modal
  const loadingModal = Swal.fire({
    title: 'Creating account...',
    allowOutsideClick: false,
    allowEscapeKey: false,
    didOpen: () => {
      Swal.showLoading()
    }
  })

  const { data, error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value,
    options: {
      emailRedirectTo: 'none' // Prevent auto sign-in, only send confirmation email
    }
  })

  if (error) {
    loading.value = false
    Swal.close()
    return Swal.fire('Error', error.message, 'error')
  }

  await supabase.from('accounts_profile').insert({
    user_id: data.user.id,
    username: name.value,
    phone: `+63${phone.value}`
  })

  loading.value = false
  await supabase.auth.signOut()
  Swal.close()
  await Swal.fire({
    icon: 'success',
    title: 'Congratulations!',
    text: 'Your account has been created!',
    confirmButtonColor: '#ad49e1',
    confirmButtonText: 'Go to Login'
  })
  router.push('/login')
}

const signUpWithGoogle = async () => {
  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin,
      queryParams: {
        prompt: 'select_account'
      }
    }
  })

  if (error) Swal.fire('Error', error.message, 'error')
}
</script>

<style scoped>
.input {
  width: 100%;
  padding: 0.45rem 0.7rem;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 0.85rem;
  background: #f9fafb;
}

.input:focus {
  outline: none;
  border-color: #6d28d9;
  background: white;
}

.label {
  font-size: 0.8rem;
  color: #4b5563;
  font-weight: 500;
}

.error {
  font-size: 11px;
  color: #dc2626;
  margin-top: 3px;
}
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