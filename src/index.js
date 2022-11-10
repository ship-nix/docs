import "tw-elements";

// Adjusts offset when hitting an #anchor link
window.addEventListener("hashchange", function () {
  window.scrollTo(window.scrollX, window.scrollY - 100);
});
