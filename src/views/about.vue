<template>
  <div class="min-h-screen flex flex-col bg-surface-100">
    <Navigation />

    <div class="flex-1 flex flex-col">
      <div class="h-44 w-full bg-brand-700 flex items-center justify-center">
        <div class="text-center text-white px-4">
          <h1 class="text-3xl md:text-4xl font-bold tracking-tight">About Lutowl</h1>
          <p class="text-sm md:text-base mt-2 opacity-90">
            Learn more about our mission and team
          </p>
        </div>
      </div>

      <div class="max-w-6xl w-full mx-auto bg-white md:rounded-2xl shadow-none md:shadow-[0_2px_12px_rgba(38,38,38,0.08)] mt-0 md:mt-12 mb-0 md:mb-20 flex flex-col h-[720px] overflow-hidden">
        <div class="flex flex-col md:flex-row w-full">

          <div class="w-full md:w-1/3 border-b md:border-b-0 md:border-r border-gray-200 bg-surface-50 flex flex-row md:flex-col p-3 md:p-6 gap-2 overflow-x-auto md:overflow-visible">
            <button
              v-for="tab in tabs"
              :key="tab.key"
              @click="activeTab = tab.key"
              :class="[
                'flex-shrink-0 md:w-full text-left px-4 py-2.5 md:py-3 rounded-lg text-sm font-semibold transition',
                activeTab === tab.key
                  ? 'bg-brand-500 text-white'
                  : 'text-gray-500 hover:bg-gray-100 hover:text-brand-700'
              ]"
            >
              {{ tab.label }}
            </button>
          </div>

          <div class="flex-1 overflow-y-auto px-4 md:px-12 py-6 md:py-10">
            <article class="space-y-5 md:space-y-6 text-[14px] md:text-[15px] leading-relaxed text-surface-900/90">

              <template v-if="activeTab === 'story'">
                <div class="flex items-center gap-3 mb-4 md:mb-6">
                  <BookOpen class="text-brand-700" :size="32" />
                  <h2 class="text-2xl md:text-3xl font-bold text-brand-900">Our Story</h2>
                </div>
                <p><strong>Lutowl</strong> was created to make discovering and sharing Filipino recipes easier and more meaningful. It highlights both traditional dishes and modern creations, bringing Filipino cuisine closer to everyone.</p>
                <p>Users can explore recipes, share their own, and connect with others who love cooking. Whether beginner or experienced, Lutowl supports learning and inspiration.</p>
                <p>It is more than a recipe platform—it is a space where culture, stories, and flavors come together.</p>
              </template>

              <template v-else-if="activeTab === 'mission'">
                <div class="flex items-center gap-3 mb-4 md:mb-6">
                  <Lightbulb class="text-brand-700" :size="32" />
                  <h2 class="text-2xl md:text-3xl font-bold text-brand-900">Our Mission</h2>
                </div>
                <p><strong>Our mission</strong> is to make Filipino recipes accessible, organized, and easy to share in a modern way.</p>
                <p>We aim to empower users to document their cooking experiences and preserve local culinary knowledge for future generations.</p>
                <p>Through technology, we simplify how people discover, learn, and enjoy Filipino food.</p>
              </template>

              <template v-else-if="activeTab === 'vision'">
                <div class="flex items-center gap-3 mb-4 md:mb-6">
                  <MapPin class="text-brand-700" :size="32" />
                  <h2 class="text-2xl md:text-3xl font-bold text-brand-900">Our Vision</h2>
                </div>
                <p><strong>Our vision</strong> is to become a leading digital platform for Filipino cuisine worldwide.</p>
                <p>We envision a community where recipes are not only shared but continuously improved and celebrated.</p>
                <p>Lutowl strives to connect people globally through the love of Filipino food.</p>
              </template>

              <template v-else-if="activeTab === 'privacy'">
                <div class="flex items-center gap-3 mb-4 md:mb-6">
                  <Users class="text-brand-700" :size="32" />
                  <h2 class="text-2xl md:text-3xl font-bold text-brand-900">Privacy and Policy</h2>
                </div>
                <p><strong>Your privacy matters.</strong> We collect only essential data to improve your experience.</p>
                <p>We do not sell or share your personal information without consent.</p>
                <p>Your data is handled securely and responsibly at all times.</p>
              </template>

              <template v-else-if="activeTab === 'terms'">
                <h2 class="text-2xl md:text-3xl font-bold text-brand-900 mb-4 md:mb-6">Terms and Condition</h2>
                <p>By using <strong>Lutowl</strong>, you agree to follow platform guidelines and policies.</p>
                <p>Users are responsible for their content, and inappropriate materials may be removed.</p>
                <p>We may update these terms to improve the platform.</p>
              </template>

              <template v-else-if="activeTab === 'contact'">
                <h2 class="text-2xl md:text-3xl font-bold text-brand-900 mb-4 md:mb-6">Contact</h2>
                <p><strong>We value your feedback.</strong> Reach out for questions or suggestions.</p>
                <p>
                  Email:
                  <strong>
                    <a href="mailto:support@lutowl.com" class="text-brand-500 hover:underline">
                      support@lutowl.com
                    </a>
                  </strong>
                </p>
                <p>We aim to respond as quickly as possible.</p>
              </template>

            </article>
          </div>
        </div>
      </div>
    </div>

    <Footer />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Navigation from '../components/Navigation.vue'
import Footer from '../components/Footer.vue'
import { BookOpen, Users, MapPin, Lightbulb } from 'lucide-vue-next'

const tabs = [
  { key: 'story', label: 'Our Story' },
  { key: 'mission', label: 'Mission' },
  { key: 'vision', label: 'Vision' },
  { key: 'privacy', label: 'Privacy Policy' },
  { key: 'terms', label: 'Terms & Conditions' },
  { key: 'contact', label: 'Contact' },
]

const activeTab = ref('story')
</script>