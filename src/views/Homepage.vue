<script setup>
import Navigation from '../components/Navigation.vue'
import { BookOpen, Users, MapPin, Lightbulb } from 'lucide-vue-next'
import navLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'
import Footer from '../components/Footer.vue'
</script>

<template>
  <div class="min-h-screen w-full bg-surface-100 text-surface-900">
    <Navigation />

    <section id="home" class="relative w-full bg-brand-900 flex items-end justify-start min-h-[500px] sm:min-h-[500px] md:min-h-[600px] lg:min-h-[700px] lg:items-end lg:justify-start overflow-hidden">
      <div class="absolute inset-0 w-full h-full bg-brand-900">
        <img src="../assets/images/homepage/homepage-banner.jpg" alt="Background" class="w-full h-full object-cover object-center opacity-40" />
      </div>
      <div class="relative z-10 w-full px-4 sm:px-6 lg:px-8 flex flex-col items-center justify-center text-center min-h-[500px] sm:min-h-[500px] md:min-h-[600px] lg:min-h-[700px] py-12 lg:items-start lg:justify-end lg:text-left lg:max-w-2xl lg:pb-24 lg:pt-0">
        <!-- Lutowl branding removed as per user request -->
        <h1 class="mb-5 text-5xl font-bold leading-tight md:text-7xl text-white">Discover Filipino Cuisine</h1>
        <p class="mb-9 max-w-2xl text-lg text-[rgba(247,247,247,0.92)] md:text-2xl">Explore, share, and celebrate traditional recipes from the Philippines</p>
        <div class="flex flex-wrap items-center gap-3.5 justify-center lg:justify-start">
          <router-link to="/discover" class="rounded-xl bg-surface-100 px-7 py-3 text-base font-semibold text-brand-900 shadow-[0_2px_10px_rgba(38,38,38,0.08)] transition hover:bg-surface-200">Start Exploring</router-link>
          <button class="rounded-xl border border-[rgba(247,247,247,0.8)] px-7 py-3 text-base font-semibold text-surface-100 transition hover:bg-[rgba(247,247,247,0.12)]">Share a Recipe</button>
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

    <section class="w-full bg-brand-700 py-20 text-center md:py-24">
      <div class="w-full px-4 sm:px-6 lg:px-8">
        <h2 class="mb-3 text-3xl font-bold text-surface-100 md:text-5xl">Ready to Explore Filipino Recipes?</h2>
        <p class="mb-7 text-base text-[rgba(247,247,247,0.9)] md:text-lg">Join our community of food lovers today</p>
        <button class="get-started-btn px-8 py-3 text-base font-semibold text-white shadow-[0_2px_10px_rgba(38,38,38,0.08)] transition">Get Started</button>
      </div>

    </section>

    <Footer />
  </div>
</template>

<style scoped>
.get-started-btn {
  border-radius: 0.75rem;
  background: var(--color-brand-500);
  transition: background 0.2s;
}
.get-started-btn:hover {
  background: var(--color-brand-900);
}
</style>


