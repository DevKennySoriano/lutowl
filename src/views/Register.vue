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
          class="w-full flex items-center justify-center gap-2 border border-gray-200 bg-white py-2.5 rounded-md text-sm font-medium hover:bg-gray-50 transition"
        >
          <img src="https://www.svgrepo.com/show/475656/google-color.svg" class="w-5 h-5" />
          Continue with Google
        </button>

        <!-- DIVIDER -->
        <div class="w-full flex items-center gap-3 my-6">
          <div class="flex-1 h-px bg-gray-200"></div>
          <span class="text-xs text-gray-400">or</span>
          <div class="flex-1 h-px bg-gray-200"></div>
        </div>

        <!-- FORM -->
        <form class="w-full flex flex-col gap-4" @submit.prevent="handleSignup">

          <!-- NAME -->
          <div>
            <label class="label">Username</label>
            <input
              v-model="name"
              type="text"
              placeholder="Enter your username"
              class="input"
            />
            <p v-if="errors.name" class="error">{{ errors.name }}</p>
          </div>

          <!-- EMAIL -->
          <div>
            <label class="label">Email</label>
            <input
              v-model="email"
              type="email"
              placeholder="example@email.com"
              class="input"
            />
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
            <div class="mt-2 text-xs space-y-1">
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
            :disabled="loading || hasErrors"
            class="bg-brand-900 text-white py-2.5 rounded-md font-semibold
                   hover:bg-brand-800 transition disabled:opacity-50"
          >
            {{ loading ? 'Creating account...' : 'Create Account' }}
          </button>

        </form>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref, watch, computed } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import { supabase } from '../lib/supabase'
import Swal from 'sweetalert2'
import { UserPlus } from 'lucide-vue-next'

const name = ref('')
const email = ref('')
const phone = ref('')
const password = ref('')
const confirmPassword = ref('')
const loading = ref(false)

const errors = ref({})

/* PASSWORD RULES */
const hasUppercase = computed(() => /[A-Z]/.test(password.value))
const hasNumber = computed(() => /[0-9]/.test(password.value))
const hasSymbol = computed(() => /[^A-Za-z0-9]/.test(password.value))

/* REAL-TIME VALIDATION */
watch([name, email, phone, password, confirmPassword], () => {
  validate()
})

const validate = () => {
  const newErrors = {}

  if (!name.value) newErrors.name = 'Username is required'

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(email.value))
    newErrors.email = 'Enter a valid email address'

  if (phone.value.length !== 10)
    newErrors.phone = 'Enter a valid 10-digit number'

  if (
    password.value.length < 8 ||
    !hasUppercase.value ||
    !hasNumber.value ||
    !hasSymbol.value
  ) {
    newErrors.password = 'Password does not meet requirements'
  }

  if (confirmPassword.value !== password.value)
    newErrors.confirmPassword = 'Passwords do not match'

  errors.value = newErrors
}

/* COMPUTED */
const hasErrors = computed(() => Object.keys(errors.value).length > 0)

/* STYLE HELPER */
const checkClass = (valid) =>
  valid ? 'text-green-600' : 'text-gray-400'

/* SIGNUP */
const handleSignup = async () => {
  validate()
  if (hasErrors.value) return

  loading.value = true

  const { data, error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value
  })

  if (error) {
    loading.value = false
    return Swal.fire('Error', error.message, 'error')
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
    text: 'Your account has been successfully registered.',
    confirmButtonColor: '#1f2937'
  })
}

/* GOOGLE */
const signUpWithGoogle = async () => {
  const { error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: {
      redirectTo: window.location.origin
    }
  })

  if (error) Swal.fire('Error', error.message, 'error')
}
</script>

<style scoped>
.input {
  width: 100%;
  padding: 0.5rem 0.75rem;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 0.875rem;
  background: #f9fafb;
}

.input:focus {
  outline: none;
  border-color: #6d28d9;
  background: white;
}

.label {
  font-size: 0.875rem;
  color: #4b5563;
  font-weight: 500;
}

.error {
  font-size: 12px;
  color: #dc2626;
  margin-top: 4px;
}
</style>