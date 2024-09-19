module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        noto: ['Noto Sans JP', 'sans-serif'],
      },
      minWidth: {
        'screen': '100vw',
      },
      height: {
        'vh-5': '5vh',
        'vh-10': '10vh',
        'vh-50': '50vh',
        'vh-75': '75vh',
        'vh-100': '100vh'
      },
      colors: {
        'custom-1': '#FDEDC3',
        'custom-2': '#F2D7E7',
        'custom-3': '#B5DBE5',
        'custom-4': '#F6F3BE',
        'custom-5': '#F0C4D1',
        'custom-6': '#15F6AD',
        'custom-7': '#ddd'
      },
      keyframes: {
        flashFade: {
          "0%": { transform: "translateY(0px)", opacity: 1 },
          "70%": { transform: "translateY(0)", opacity: 1 },
          "90%": { transform: "translateY(-8px)", opacity: 0 },
          "100%": { transform: "translateY(-30px)", opacity: 0 }
        },
        quake: {
          '10%, 50%, 90%': {
            transform: 'translate3d(-1px, 0, 0)',
          },
          '30%, 70%': {
            transform: 'translate3d(3px, 0, 0)',
          },
        },
        slide_in_left: {
          "0%": {
              transform: "translateX(-1000px)",
              opacity: "0",
          },
          to: {
              transform: "translateX(0)",
              opacity: "1",
          },
        },
        shadow_pop_br: {
          "0%": {
              "box-shadow": "0 0 #3e3e3e, 0 0 #3e3e3e, 0 0 #3e3e3e",
              transform: "translateX(0) translateY(0)",
          },
          to: {
              "box-shadow": "1px 1px #3e3e3e, 2px 2px #3e3e3e, 3px 3px #3e3e3e",
              transform: "translateX(-3px) translateY(-3px)",
          },
        },
        pulsate_fwd: {
          "0%,to": {
              transform: "scale(1)"
          },
          "70%": {
              transform: "scale(1.1)"
          },
        },
      },
      animation: {
        flash: "flashFade 4.0s forwards",
        quake: 'quake 0.6s linear',
        slide_in_left: "slide_in_left 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) both",
        shadow_pop_br: "shadow_pop_br 0.1s cubic-bezier(0.470, 0.000, 0.745, 0.715)   both",
        "pulsate_fwd": "pulsate_fwd 5s ease infinite both",
      },
    },
  },
  plugins: [require("daisyui")],
}
