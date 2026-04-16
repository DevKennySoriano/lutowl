
<div align="left" style="display: flex; align-items: center; gap: 12px;">
	<img src="src/assets/lutowl-icon-logo/lutowl-logo-light-purle.png" alt="Lutowl Icon" width="48" height="48" style="vertical-align: middle; margin-right: 12px;"/>
	<h1 style="display: inline; font-size: 2.2em; font-weight: bold; margin: 0;">Lutowl - Think less. Eat better.</h1>
</div>

## Overview

Lutowl is a modern recipe-sharing platform focused on Filipino cuisine. It helps users discover practical meal ideas quickly based on ingredients, budget, or simple meal prompts.

The project is built with Vue 3 and Vite, styled with Tailwind CSS for a clean and scalable UI workflow.

## About Lutowl

Lutowl works by helping you find meals based on what you need at the moment. You can input what ingredients you have, choose your budget, or simply ask for a meal suggestion. The system then looks through available recipes and shows you the most suitable meal ideas.

After that, Lutowl gives you a list of food options you can choose from. Each suggestion includes the meal name and simple details so you can quickly decide what to cook without overthinking. You can also save recipes you like or try a different suggestion if you want more options.

In short, Lutowl turns your inputs into quick meal ideas. Instead of spending time thinking "what should I cook?", it gives you instant answers that match your situation.

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
│   └── main.css
├── stores/
├── utils/
├── views/
│   └── Homepage.vue
├── App.vue
└── main.js

index.html
package.json
package-lock.json
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
- Tailwind CSS v4
- @tailwindcss/vite
- Lucide Vue Next
- HTML + JavaScript (ES modules)

## Styling Approach

Lutowl uses Tailwind CSS utilities with centralized theme tokens:

- Tailwind setup and global base styles are in `src/css/main.css`
- Theme color tokens are defined using `@theme`
- Component UI is styled directly in Vue templates using Tailwind utility classes
- Vite integrates Tailwind through `@tailwindcss/vite` in `vite.config.js`

## Roadmap

- Add dedicated Discover page for meal browsing
- Add recipe details page
- Add save/bookmark flow
- Add smart input filters (ingredients, budget, prep time)
- Add backend/API integration for dynamic recipes

## Contact and Social Links

- LinkedIn: https://www.linkedin.com/in/kennysoriano/
- GitHub: https://github.com/DevKennySoriano
- Portfolio: https://devkennysoriano.vercel.app/
- Email: devkennysoriano@gmail.com

## License

This project is currently in development.
