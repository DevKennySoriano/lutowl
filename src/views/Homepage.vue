<template>
  <div class="min-h-screen w-full bg-surface-100 text-surface-900">
    <nav class="sticky top-0 z-[100] w-full border-b border-[rgba(46,7,63,0.14)] bg-[rgba(247,247,247,0.96)] shadow-[0_8px_20px_rgba(38,38,38,0.06)] backdrop-blur-md">
      <div class="flex w-full flex-wrap items-center justify-between gap-3 px-4 py-3 sm:px-6 lg:px-8">
        <div class="inline-flex items-center">
          <img :src="navLogo" alt="Lutowl logo" class="block h-10 w-auto rounded-[10px] border border-[rgba(46,7,63,0.25)] bg-gradient-to-br from-[rgba(247,247,247,0.95)] to-[rgba(232,230,222,0.95)] shadow-[0_6px_14px_rgba(38,38,38,0.08)]" />
        </div>
        <ul class="order-3 mt-2 flex w-full flex-wrap items-center justify-center gap-6 border-t border-[rgba(46,7,63,0.12)] pt-3 text-center lg:order-none lg:mt-0 lg:w-auto lg:flex-1 lg:justify-start lg:border-t-0 lg:pt-0">
          <li class="relative">
            <a href="#home" class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700">Home</a>
          </li>
          <li class="relative">
            <a href="#about" class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700">About</a>
          </li>
          <li class="relative">
            <a href="#contact" class="border-b-2 border-transparent py-2 text-sm font-semibold text-brand-900 transition hover:border-brand-500 hover:text-brand-700">Contact</a>
          </li>
        </ul>
        <button class="rounded-xl border border-brand-700 px-5 py-2.5 text-sm font-semibold text-brand-700 transition hover:bg-brand-700 hover:text-surface-100">Discover</button>
      </div>
    </nav>

    <section id="home" class="flex min-h-[600px] w-full items-center justify-center bg-gradient-to-br from-brand-900 via-brand-700 to-brand-500">
      <div class="w-full px-4 text-center text-surface-100 sm:px-6 lg:px-8">
        <div>
          <h1 class="mb-5 text-4xl font-bold leading-tight md:text-6xl">Discover Filipino Cuisine</h1>
          <p class="mx-auto mb-9 max-w-3xl text-base text-[rgba(247,247,247,0.92)] md:text-xl">Explore, share, and celebrate traditional recipes from the Philippines</p>
          <div class="flex flex-wrap items-center justify-center gap-3.5">
            <button class="rounded-xl bg-surface-100 px-7 py-3 text-base font-semibold text-brand-900 shadow-[0_2px_10px_rgba(38,38,38,0.08)] transition hover:bg-surface-200">Start Exploring</button>
            <button class="rounded-xl border border-[rgba(247,247,247,0.8)] px-7 py-3 text-base font-semibold text-surface-100 transition hover:bg-[rgba(247,247,247,0.12)]">Share a Recipe</button>
          </div>
        </div>
      </div>
    </section>

    <section id="about" class="w-full bg-surface-100 py-24 md:py-28">
      <div class="w-full px-4 sm:px-6 lg:px-8">
        <h2 class="mb-3 text-center text-3xl font-bold leading-tight text-brand-900 md:text-5xl">Why Choose Lutowl?</h2>
        <p class="mx-auto mb-11 max-w-3xl text-center text-base text-surface-900/70 md:text-lg">A modern platform dedicated to preserving and celebrating Filipino culinary heritage</p>

        <div class="grid grid-cols-1 gap-5 md:grid-cols-2 xl:grid-cols-4">
          <div class="rounded-2xl border border-[rgba(38,38,38,0.08)] bg-white p-7 text-center shadow-[0_2px_10px_rgba(38,38,38,0.08)]">
            <BookOpen class="mx-auto mb-4 block text-brand-700" :size="44" />
            <h3 class="mb-2 text-xl font-semibold text-brand-900">Curated Recipes</h3>
            <p class="text-sm leading-6 text-surface-900/70">Authentic traditional and modern Filipino recipes with detailed instructions and tips</p>
          </div>

          <div class="rounded-2xl border border-[rgba(38,38,38,0.08)] bg-white p-7 text-center shadow-[0_2px_10px_rgba(38,38,38,0.08)]">
            <Users class="mx-auto mb-4 block text-brand-700" :size="44" />
            <h3 class="mb-2 text-xl font-semibold text-brand-900">Community Driven</h3>
            <p class="text-sm leading-6 text-surface-900/70">Connect with fellow food enthusiasts and share your culinary experiences</p>
          </div>

          <div class="rounded-2xl border border-[rgba(38,38,38,0.08)] bg-white p-7 text-center shadow-[0_2px_10px_rgba(38,38,38,0.08)]">
            <MapPin class="mx-auto mb-4 block text-brand-700" :size="44" />
            <h3 class="mb-2 text-xl font-semibold text-brand-900">Regional Flavors</h3>
            <p class="text-sm leading-6 text-surface-900/70">Explore dishes from different regions and understand their cultural significance</p>
          </div>

          <div class="rounded-2xl border border-[rgba(38,38,38,0.08)] bg-white p-7 text-center shadow-[0_2px_10px_rgba(38,38,38,0.08)]">
            <Lightbulb class="mx-auto mb-4 block text-brand-700" :size="44" />
            <h3 class="mb-2 text-xl font-semibold text-brand-900">Smart Discovery</h3>
            <p class="text-sm leading-6 text-surface-900/70">Find recipes based on ingredients, cooking time, and dietary preferences</p>
          </div>
        </div>
      </div>
    </section>

    <section class="w-full bg-gradient-to-br from-brand-600 to-brand-700 py-20 text-center md:py-24">
      <div class="w-full px-4 sm:px-6 lg:px-8">
        <h2 class="mb-3 text-3xl font-bold text-surface-100 md:text-5xl">Ready to Explore Filipino Recipes?</h2>
        <p class="mb-7 text-base text-[rgba(247,247,247,0.9)] md:text-lg">Join our community of food lovers today</p>
        <button class="rounded-xl bg-brand-700 px-8 py-3 text-base font-semibold text-surface-100 shadow-[0_2px_10px_rgba(38,38,38,0.08)] transition hover:bg-brand-600">Create Free Account</button>
      </div>
    </section>

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
              <li><a href="#home" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Home</a></li>
              <li><a href="#home" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">Discover</a></li>
              <li><a href="#about" class="text-sm text-[rgba(247,247,247,0.72)] transition hover:text-brand-500">About</a></li>
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
  </div>
</template>

<script setup>
import { BookOpen, Users, MapPin, Lightbulb } from 'lucide-vue-next'
import navLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'
import footerLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-logo.png'
</script>
