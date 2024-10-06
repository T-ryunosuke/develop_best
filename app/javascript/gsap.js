import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";


gsap.registerPlugin(ScrollTrigger);

document.addEventListener("turbo:load", function () {

  const toUpObjects = document.getElementById('toUpObjects'),
    objectNumber = 60;

  if (!toUpObjects) return;

  for (let i = 0; i < objectNumber; i++) {
    const li = document.createElement('li')
    li.style.width = `${30 / objectNumber}%`
    li.style.transform = `scale(${gsap.utils.random(.7, 1.2)})`
    toUpObjects.appendChild(li)
  };

  gsap.to('.toUpObjects li', .8, {
    y: -(window.innerHeight * 1.5),
    ease: 'power3.in',
    stagger: {
      amount: 1,
      from: 'random'
    },
    scrollTrigger: {
      trigger: '.contents',
      start: 'bottom 60%',
      end: '+=800',
      pin: true,
      scrub: .5
    }
  });



  const sections = document.querySelectorAll('section');
  sections.forEach(el => {

    gsap.from(el, .5, {
      opacity: 0,
      y: 20,
      scale: 0.8,
      ease: 'back',
      scrollTrigger: {
        trigger: el,
        scrub: true,
        // 要素の指定部分 と ブラウザの指定部分が重なったときにアニメーションを開始するという設定
        start: 'top 80%',
        // 要素の指定部分 と ブラウザの指定部分が重なったときにアニメーションを終了するという設定
        // %指定も可能
        //end: '50% 50%',
      }
    })
  });




  const subheadingElement = document.querySelectorAll('.subheading');
  subheadingElement.forEach(el => {
    const subheadingTexts = el.textContent.split('');
    el.textContent = '';
    let outputTexts = '';
    subheadingTexts.forEach(text => outputTexts += text === ' ' ? ' ' : `<span class="inline-block">${text}</span>`);
    el.innerHTML = outputTexts;
  });

  gsap.to('.overWrap', 5, {
    ease: 'power4.out',
    width: 0,
    scrollTrigger: {
      trigger: '.overWrap',
      scrub: true,
      start: 'top 80%',
      end: 'bottom 50%'
    }
  });


  gsap.timeline({
    scrollTrigger: {
      trigger: '.h1-box',
      start: 'bottom 25%',
      end: 'bottom 20%',
      scrub: 2
    }
  })
  .to('.h1-box h1 span', 3, {
    opacity: 0,
    ease: 'power3.in',
    scaleX: .4,
    y: -25,
    stagger: {
      amount: 1,
      from: 'random'
    }
  })
  .to('.h1-box', 2, {
    ease: 'power2.out',
    opacity: 0.8
  });

  gsap.from('.contentsList li', .5, {
    opacity: 0,
    x: -15,
    ease: 'power4.out',
    scrollTrigger: {
      trigger: '.contentsList',
      start: 'top 80%',
      end: 'bottom 70%',
      scrub: .5
    },
    stagger: {
      amount: 1,
      onStart: function () { this.targets()[0].classList.add('show') },
      onReverseComplete: function () { this.targets()[0].classList.remove('show') },
    }
  });


});
