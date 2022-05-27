const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: {
          50: '#9bbce1',
          100: '#87aeda',
          200: '#73a1d4',
          300: '#5f93ce',
          400: '#4b86c8',
          500: '#3778c2',
          600: '#326caf',
          700: '#2c609b',
          800: '#275488',
          900: '#214874',
          1000: '#1c3c61',
        },
        secondary: {
          50: '#afda91',
          100: '#9fd37b',
          200: '#8fcb65',
          300: '#7fc44f',
          400: '#6fbc39',
          500: '#5fb523',
          600: '#56a320',
          700: '#4c911c',
          800: '#437f19',
          900: '#396d15',
          1000: '#305b12',
        },
        tertiary: {
          50: '#a1a5aa',
          100: '#8e9398',
          200: '#7b8187',
          300: '#696f76',
          400: '#565d65',
          500: '#434b54',
          600: '#3c444c',
          700: '#363c43',
          800: '#2f353b',
          900: '#282d32',
          1000: '#22262a',
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
