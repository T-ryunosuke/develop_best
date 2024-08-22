// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener("turbo:load", function() {
  var menuToggle = document.getElementById('menu-toggle');
  var sideMenu = document.getElementById('side-menu');
  var menuIcon = document.getElementById('menu-icon');
  var closeIcon = document.getElementById('close-icon');

  if (menuToggle) {
    menuToggle.addEventListener('click', function() {
      sideMenu.classList.toggle('translate-x-0');
      sideMenu.classList.toggle('-translate-x-full');
      menuIcon.classList.toggle('hidden');
      closeIcon.classList.toggle('hidden');
    });
  }
});
