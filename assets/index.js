"use strict";
// Adjusts offset when hitting an #anchor link
window.addEventListener("hashchange", function () {
  window.scrollTo(window.scrollX, window.scrollY - 100);
});

// const loadColorTheme = () => {
//   if (
//     localStorage.theme === "dark" ||
//     (!("theme" in localStorage) &&
//       window.matchMedia("(prefers-color-scheme: dark)").matches)
//   ) {
//     document.documentElement.setAttribute("data-theme", "dark");
//   } else {
//     document.documentElement.setAttribute("data-theme", "light");
//   }
// };

// const toggleDarkmode = () => {
//   const currentMode = document.documentElement.getAttribute("data-theme");
//   if (currentMode === "dark") {
//     document.documentElement.setAttribute("data-theme", "light");
//     localStorage.setItem("theme", "light");
//   } else if (currentMode === "light") {
//     document.documentElement.setAttribute("data-theme", "dark");
//     localStorage.setItem("theme", "dark");
//   }
// };

// document.addEventListener("load", () => {
//   loadColorTheme();
// });

// document.addEventListener("htmx:load", () => {
//   loadColorTheme();
// });
