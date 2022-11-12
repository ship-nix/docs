/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.njk",
    "./src/**/*.md",
    process.env.NODE_PATH + "/tw-elements/dist/js/**/*.js",
  ],
  theme: {
    extend: {
      typography: (theme) => ({
        DEFAULT: {
          css: {
            code: {
              color: "var(--tw-prose-code)",
              backgroundColor: "var(--bs-gray-200)",
              padding: "2px 6px",
              borderRadius: "7px",
              fontWeight: "600",
            },
            "code::before": {
              content: "none",
            },
            "code::after": {
              content: "none",
            },
          },
        },
      }),
    },
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("tw-elements/dist/plugin"),
  ],
};
