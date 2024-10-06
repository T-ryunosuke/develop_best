document.addEventListener("turbo:load", function () {
  const imageInput = document.getElementById('post_images');

  if (imageInput) {
    imageInput.addEventListener('change', function(event) {
      const files = event.target.files;
      const previewsContainer = document.getElementById('previews');
      previewsContainer.innerHTML = '';  // 既存のプレビューをクリア

      Array.from(files).forEach(function(file) {
        const reader = new FileReader();
        const previewImage = document.createElement('img');
        previewImage.classList.add('mt-3', 'preview-image', 'max-h-52');

        reader.onload = function(e) {
          previewImage.src = e.target.result;
          previewsContainer.appendChild(previewImage);
        };

        reader.readAsDataURL(file);
      });
    });
  }
});
