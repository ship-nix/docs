"use strict";
import "tw-elements";

// const svgClass = "w-4 h-4 mt-4";
// const logoImg = (lang) =>
//   `<img src="/assets/img/icon/${lang}.svg" class="${svgClass}" alt="${lang}">`;

// function langLogo(lang) {
//   switch (lang) {
//     case "elm":
//     case "haskell":
//     case "javascript":
//     case "bash":
//     case "typescript":
//     case "jsx":
//     case "nix":
//     case "sql":
//     case "html":
//       return logoImg(lang);
//     default:
//       return lang;
//   }
// }

// function addSyntaxSymbolLogos() {
//   const codeNodes = document.querySelectorAll("pre[class*='language-']");
//   codeNodes.forEach((codeNode) => {
//     const lang = codeNode.classList[0].substring(
//       codeNode.classList[0].indexOf("-") + 1
//     );
//     const langNode = document.createElement("div");
//     langNode.innerHTML = langLogo(lang);
//     langNode.classList.add("lang-label");
//     codeNode.prepend(langNode);
//   });
// }

// window.addEventListener("load", (event) => {
//   addSyntaxSymbolLogos();
// });

// document.addEventListener("turbo:load", (e) => {
//   addSyntaxSymbolLogos();
// });

// Adjusts offset when hitting an #anchor link
window.addEventListener("hashchange", function () {
  window.scrollTo(window.scrollX, window.scrollY - 100);
});
