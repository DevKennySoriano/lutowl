<script setup>
import Navigation from '../../components/Navigation.vue'
import Footer from '../../components/Footer.vue'
import { supabase } from '../../lib/supabase'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'

const router = useRouter()

const logout = async () => {
  const confirm = await Swal.fire({
    title: 'Logout?',
    text: 'You will be signed out of your account.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes, logout',
    cancelButtonText: 'Cancel',
    reverseButtons: true,
    confirmButtonColor: '#dc2626',
    width: 420
  })

  if (!confirm.isConfirmed) return


  const { error } = await supabase.auth.signOut()

  if (error) {
    Swal.fire('Error', error.message, 'error')
    return
  }


  await supabase.auth.setSession({
    access_token: null,
    refresh_token: null
  })

  localStorage.removeItem('sb-auth-token')
  localStorage.removeItem('supabase.auth.token')


  await Swal.fire({
    icon: 'success',
    title: 'Logged out',
    text: 'You have been signed out successfully.',
    confirmButtonColor: '#1f2937',
    width: 420
  })


  window.location.href = '/login'
}
</script>
