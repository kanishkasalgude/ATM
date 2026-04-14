/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx,ts,tsx}'],
  theme: {
    extend: {
      colors: {
        navy: {
          DEFAULT: '#1B2A6B',
          50:  '#E8EBF5',
          100: '#C5CCEA',
          200: '#9FAADD',
          300: '#7888D0',
          400: '#5166C3',
          500: '#1B2A6B',
          600: '#162258',
          700: '#101A45',
          800: '#0B1231',
          900: '#050A1E',
        },
        orange: {
          DEFAULT: '#E87722',
          50:  '#FDF3E8',
          100: '#FAE0C0',
          200: '#F6CC98',
          300: '#F3B870',
          400: '#EFA348',
          500: '#E87722',
          600: '#C9641A',
          700: '#A85114',
          800: '#863E0E',
          900: '#652C08',
        },
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui'],
      },
      boxShadow: {
        card: '0 2px 12px rgba(27,42,107,0.10)',
        'card-hover': '0 6px 24px rgba(27,42,107,0.18)',
      },
    },
  },
  plugins: [],
};
