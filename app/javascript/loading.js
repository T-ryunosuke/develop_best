function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}


function fadeOutLoadText() {
  return new Promise((resolve) => {
    window.scrollTo(0, 0);
    const loadTextElement = document.getElementById("loadText");
    if (loadTextElement) {
      loadTextElement.classList.add("fadeOut");
      loadTextElement.addEventListener('transitionend', function onTransitionEnd() {
        loadTextElement.removeEventListener('transitionend', onTransitionEnd);
        resolve();
      });
    }
  });
}

function startFinishAnimation() {
  return new Promise((resolve) => {
    const finishLoadingElement = document.getElementById("finishLoading");
    if (finishLoadingElement) {
      finishLoadingElement.classList.add('action');
      finishLoadingElement.addEventListener('animationend', function onAnimationEnd() {
        finishLoadingElement.removeEventListener('animationend', onAnimationEnd);
        resolve();
      });
    }
  });
}

function startEndAnimation() {
  return new Promise((resolve) => {
    const endLoadingElement = document.getElementById("endLoading");
    if (endLoadingElement) {
      document.getElementById("loadBox").classList.add('hidden', 'invisible');
      endLoadingElement.classList.add('action');
      endLoadingElement.addEventListener('animationend', function onAnimationEnd() {
        endLoadingElement.removeEventListener('animationend', onAnimationEnd);
        resolve();
      });
    }
  });
}


function removeLoading() {
  return new Promise((resolve) => {
    const endLoadingElement = document.getElementById("endLoading");
    if (endLoadingElement) {
      endLoadingElement.classList.add('hidden', 'invisible');
      resolve();
    }
  });
}

async function execute() {
  await delay(500);
  await fadeOutLoadText();
  await startFinishAnimation();
  await delay(100);
  await startEndAnimation();
  await delay(500);
  await removeLoading();
}


document.addEventListener("turbo:load", function () {
  execute();
});
