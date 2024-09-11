document.addEventListener("turbo:load", function() {
  const gallery = document.getElementById('image-gallery');
  const nextBtn = document.getElementById('next-btn');
  const prevBtn = document.getElementById('prev-btn');
  const items = gallery.querySelectorAll('.snap-center');
  let currentIndex = 0;

  function scrollToIndex(index) {
    // スクロール位置を計算してスムーズに移動
    gallery.scrollTo({
      left: gallery.offsetWidth * index,
      behavior: 'smooth'
    });
  }

  // 初期表示をセット
  scrollToIndex(currentIndex);

  nextBtn.addEventListener('click', function() {
    // 次の画像に進む、最後の画像の次は最初の画像に戻る
    currentIndex = (currentIndex + 1) % items.length;
    scrollToIndex(currentIndex);
  });

  prevBtn.addEventListener('click', function() {
    // 前の画像に戻る、最初の画像の前は最後の画像に戻る
    currentIndex = (currentIndex - 1 + items.length) % items.length;
    scrollToIndex(currentIndex);
  });
});
