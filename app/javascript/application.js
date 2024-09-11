// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import './image_slider';

document.addEventListener("turbo:load", function() {
  const imageInput = document.getElementById('avatar');
  if (imageInput) {
    imageInput.addEventListener('change', function (event) {
      var reader = new FileReader();
      let file = event.target.files[0];
      const preview = document.getElementById('preview');

      reader.onload = function(e) {
        preview.src = e.target.result;
      };

      if (file) {
        reader.readAsDataURL(file);
      }
    });
  }
});
