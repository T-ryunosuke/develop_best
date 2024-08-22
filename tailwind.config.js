module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      height: {
        'vh-5': '5vh',
        'vh-10': '10vh',
        'vh-50': '50vh',
        'vh-75': '75vh',
        'vh-100': '100vh',
      },
      colors: {
        'custom-1': '#FDEDC3',
        'custom-2': '#F2D7E7',
        'custom-3': '#B5DBE5',
        'custom-4': '#F6F3BE',
        'custom-5': '#F0C4D1',
      },
      keyframes: {
        flashFade: {
          "0%": { transform: "translateY(-100px)", opacity: 1 },
          "20%": { transform: "translateY(0)", opacity: 1 },
          "70%": { transform: "translateY(0)", opacity: 1 },
          "100%": { transform: "translateY(-80px)", opacity: 0 },
        },
      },
      animation: {
        flash: "flashFade 4.0s forwards",
      },
    },
  },
  plugins: [require("daisyui")],
}
