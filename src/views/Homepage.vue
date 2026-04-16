<template>
  <div class="lutowl-homepage">
    <!-- Navigation Bar -->
    <nav class="navigation-bar">
      <div class="navigation-container">
        <div class="brand-logo">
          <img :src="navLogo" alt="Lutowl logo" class="brand-logo__image" />
        </div>
        <ul class="navigation-menu">
          <li class="navigation-menu__item">
            <a href="#home" class="navigation-menu__link">Home</a>
          </li>
          <li class="navigation-menu__item">
            <a href="#about" class="navigation-menu__link">About</a>
          </li>
          <li class="navigation-menu__item">
            <a href="#contact" class="navigation-menu__link">Contact</a>
          </li>
        </ul>
        <button class="btn btn--nav-cta">Discover</button>
      </div>
    </nav>

    <!-- Hero Banner Section -->
    <section class="hero-banner" id="home">
      <div class="hero-banner__overlay">
        <div class="hero-banner__content">
          <h1 class="hero-banner__title">Discover Filipino Cuisine</h1>
          <p class="hero-banner__subtitle">Explore, share, and celebrate traditional recipes from the Philippines</p>
          <div class="hero-banner__actions">
            <button class="btn btn--primary">Start Exploring</button>
            <button class="btn btn--secondary">Share a Recipe</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Value Proposition Section -->
    <section class="value-section" id="about">
      <div class="value-section__wrapper">
        <h2 class="value-section__title">Why Choose Lutowl?</h2>
        <p class="value-section__lead">A modern platform dedicated to preserving and celebrating Filipino culinary heritage</p>
        
        <div class="value-grid">
          <div class="value-card">
            <BookOpen class="value-card__icon" :size="44" />
            <h3 class="value-card__heading">Curated Recipes</h3>
            <p class="value-card__text">Authentic traditional and modern Filipino recipes with detailed instructions and tips</p>
          </div>
          
          <div class="value-card">
            <Users class="value-card__icon" :size="44" />
            <h3 class="value-card__heading">Community Driven</h3>
            <p class="value-card__text">Connect with fellow food enthusiasts and share your culinary experiences</p>
          </div>
          
          <div class="value-card">
            <MapPin class="value-card__icon" :size="44" />
            <h3 class="value-card__heading">Regional Flavors</h3>
            <p class="value-card__text">Explore dishes from different regions and understand their cultural significance</p>
          </div>
          
          <div class="value-card">
            <Lightbulb class="value-card__icon" :size="44" />
            <h3 class="value-card__heading">Smart Discovery</h3>
            <p class="value-card__text">Find recipes based on ingredients, cooking time, and dietary preferences</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Call To Action Section -->
    <section class="cta-section">
      <div class="cta-section__wrapper">
        <h2 class="cta-section__title">Ready to Explore Filipino Recipes?</h2>
        <p class="cta-section__subtitle">Join our community of food lovers today</p>
        <button class="btn btn--cta-primary">Create Free Account</button>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
      <div class="footer__wrapper">
        <div class="footer__content">
          <div class="footer__brand">
            <img :src="footerLogo" alt="Lutowl logo" class="footer__logo" />
            <h4 class="footer__brand-name">Lutowl</h4>
            <p class="footer__brand-desc">Celebrating Filipino cuisine, one recipe at a time.</p>
          </div>
          
          <div class="footer__section">
            <h4 class="footer__heading">Navigation</h4>
            <ul class="footer__links">
              <li><a href="#home" class="footer__link">Home</a></li>
              <li><a href="#discover" class="footer__link">Discover</a></li>
              <li><a href="#about" class="footer__link">About</a></li>
            </ul>
          </div>
          
          <div class="footer__section">
            <h4 class="footer__heading">Legal</h4>
            <ul class="footer__links">
              <li><a href="#terms" class="footer__link">Terms</a></li>
              <li><a href="#privacy" class="footer__link">Privacy</a></li>
              <li><a href="#contact" class="footer__link">Contact</a></li>
            </ul>
          </div>
        </div>
        
        <div class="footer__divider"></div>
        
        <div class="footer__bottom">
          <p class="footer__copyright">&copy; 2026 Lutowl. All rights reserved.</p>
          <p class="footer__tagline">Preserving and celebrating Filipino culinary heritage</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { BookOpen, Users, MapPin, Lightbulb } from 'lucide-vue-next'
import navLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-purle.png'
import footerLogo from '../assets/lutowl-icon-logo/lutowl-logo-light-logo.png'
import '../css/homepage/index.css'
</script>
