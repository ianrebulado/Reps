const defaultTheme = require("tailwindcss/defaultTheme");
const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    './app/assets/stylesheets/**/*.css',
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      backgroundImage: {
        bg: "url('bg.png')",
        bg2: "url('bg.jpg')",
        bg3: "url('bg3.jpg')"
      },
      colors: {
        yellow: {
          400: "#E6FE58",
          600: "#DEFE25",
        },
        purple: "#58E6FE",
        offwhite: "B6B6B6",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
