<template>
  <nav class="sticky top-0 z-[100] w-full border-b border-[rgba(46,7,63,0.14)] bg-[rgba(247,247,247,0.96)] shadow-[0_8px_20px_rgba(38,38,38,0.06)] backdrop-blur-md">
    <div class="flex w-full flex-wrap items-center justify-between gap-3 px-4 py-3 sm:px-6 lg:px-8">
      <div class="inline-flex items-center gap-3">
        <img :src="navLogo" alt="Lutowl logo" class="block h-10 w-auto rounded-[10px] border border-[rgba(46,7,63,0.25)] bg-white shadow-[0_6px_14px_rgba(38,38,38,0.08)]" />
        <span class="text-2xl font-bold text-brand-700 tracking-wide select-none">Lutowl</span>
      </div>
      <ul class="order-3 mt-2 flex w-full flex-wrap items-center justify-center gap-6 border-t border-[rgba(46,7,63,0.12)] pt-3 text-center lg:order-none lg:mt-0 lg:w-auto lg:flex-1 lg:justify-center lg:border-t-0 lg:pt-0">
        <li class="relative">
          <router-link to="/"
            class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700"
            active-class="nav-active"
            exact
          >Home</router-link>
        </li>
        <li class="relative">
          <router-link to="/discover"
            class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700"
            active-class="nav-active"
          >Discover</router-link>
        </li>
        <li class="relative">
          <router-link to="/about"
            class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700"
            active-class="nav-active"
          >About</router-link>
        </li>
      </ul>
      <div class="flex gap-2">
        <button class="rounded-xl border border-brand-700 px-5 py-2.5 text-sm font-semibold text-brand-700 transition hover:bg-brand-700 hover:text-surface-100">Log In</button>
        <router-link to="/register" class="rounded-xl bg-brand-700 px-5 py-2.5 text-sm font-semibold text-surface-100 transition hover:bg-brand-900">Register</router-link>
      </div>
    </div>
  </nav>
</template>

<script setup>
import navLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'
</script>

<style scoped>
.nav-active {
  border-bottom-color: var(--color-brand-500) !important;
  color: var(--color-brand-500) !important;
}
</style>
