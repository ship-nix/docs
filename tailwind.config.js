/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.njk",
    process.env.NODE_PATH + "/tw-elements/dist/js/**/*.js",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("tw-elements/dist/plugin"),
  ],
};
