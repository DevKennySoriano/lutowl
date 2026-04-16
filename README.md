# Lutowl - Think less. Eat better.

## Overview

Lutowl is a modern recipe-sharing platform focused on Filipino cuisine. It helps users discover practical meal ideas quickly based on ingredients, budget, or simple meal prompts.

The project is built with Vue 3 and Vite, using a modular CSS architecture for clean and maintainable styling.

## About Lutowl

Lutowl works by helping you find meals based on what you need at the moment. You can input what ingredients you have, choose your budget, or simply ask for a meal suggestion. The system then looks through available recipes and shows you the most suitable meal ideas.

After that, Lutowl gives you a list of food options you can choose from. Each suggestion includes the meal name and simple details so you can quickly decide what to cook without overthinking. You can also save recipes you like or try a different suggestion if you want more options.

In short, Lutowl turns your inputs into quick meal ideas. Instead of spending time thinking "what should I cook?", it gives you instant answers that match your situation.

## Current Features

- Responsive landing homepage (desktop, tablet, mobile)
- Sticky navigation with branded logo and CTA
- Filipino-inspired purple design system
- Modular CSS structure with separated style layers
- Lucide icon integration for clean UI iconography
- Branded metadata title and favicon

## Project Structure

```text
public/
├── favicon.svg
├── icons.svg
└── lutowl-favicon.png

src/
├── assets/
│   ├── css/
│   ├── images/
│   └── lutowl-icon-logo/
│       ├── lutowl-logo-dark.png
│       ├── lutowl-logo-light-logo.png
│       └── lutowl-logo-light-purle.png
├── components/
├── composables/
├── css/
│   ├── main.css
│   └── homepage/
│       ├── base.css
│       ├── footer.css
│       ├── index.css
│       ├── navigation.css
│       ├── responsive.css
│       ├── sections.css
│       └── variables.css
├── stores/
├── utils/
├── views/
│   └── Homepage.vue
├── App.vue
├── main.js
└── style.css

index.html
package.json
vite.config.js
README.md
```

## Installation and Setup

### Prerequisites

- Node.js 20+
- npm (included with Node.js)

### Run Locally

```bash
# install dependencies
npm install

# run development server
npm run dev
```

The app runs at http://localhost:5173 by default.

### Available Scripts

```bash
npm run dev      # start local development server
npm run build    # create production build in dist/
npm run preview  # preview production build locally
```

## Technology Stack

- Vue 3 (Composition API)
- Vite
- Lucide Vue Next
- CSS3 (modular architecture)

## Styling Approach

Lutowl uses layered and separated CSS for maintainability:

- Global reset and app-level defaults in `src/css/main.css`
- Homepage style entrypoint in `src/css/homepage/index.css`
- Section-specific styling split into dedicated files:
	- `variables.css`
	- `base.css`
	- `navigation.css`
	- `sections.css`
	- `footer.css`
	- `responsive.css`

## Roadmap

- Add dedicated Discover page for meal browsing
- Add recipe details page
- Add save/bookmark flow
- Add smart input filters (ingredients, budget, prep time)
- Add backend/API integration for dynamic recipes

## License

This project is currently for development and portfolio use.
