<template>
  <footer id="contact" class="w-full bg-surface-900 px-0 pb-7 pt-14 text-surface-100">
    <div class="w-full px-4 sm:px-6 lg:px-8">
      <div class="mb-8 grid grid-cols-1 gap-7 md:grid-cols-[2fr_1fr_1fr]">
        <div class="grid gap-2.5">
          <img :src="footerLogo" alt="Lutowl logo" class="block h-[38px] w-auto rounded-[10px] border border-[rgba(247,247,247,0.25)]" />
          <h4 class="text-xl font-semibold text-surface-100">Lutowl</h4>
          <p class="text-sm text-[rgba(247,247,247,0.72)]">Celebrating Filipino cuisine, one recipe at a time.</p>
        </div>
        <div>
          <h4 class="mb-2.5 text-base font-semibold text-surface-100">Navigation</h4>
          <ul class="grid gap-2">
            <li><router-link to="/" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Home</router-link></li>
            <li><router-link to="/discover" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Discover</router-link></li>
            <li><router-link to="/about" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">About</router-link></li>
          </ul>
        </div>
        <div>
          <h4 class="mb-2.5 text-base font-semibold text-surface-100">Legal</h4>
          <ul class="grid gap-2">
            <li><a href="#terms" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Terms</a></li>
            <li><a href="#privacy" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Privacy</a></li>
            <li><a href="#contact" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Contact</a></li>
          </ul>
        </div>
      </div>
      <div class="mb-4 h-px w-full bg-[rgba(247,247,247,0.18)]"></div>
      <div class="flex flex-wrap items-center justify-between gap-4">
        <p class="text-sm text-[rgba(247,247,247,0.72)]">&copy; 2026 Lutowl. All rights reserved.</p>
        <p class="text-sm text-brand-500">Preserving and celebrating Filipino culinary heritage</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { defineProps } from 'vue'
import footerLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-logo.png'
</script>
