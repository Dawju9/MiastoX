/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./_layouts/*.html"],
  theme: {
    extend: {
      colors: {
        neo: {
          bg: '#0a0a0a',
          surface: '#16161e',
          'surface-light': '#1e1e28',
          primary: '#00f5ff',
          secondary: '#ff00aa',
          accent: '#39ff14',
          'primary-glow': 'rgba(0, 245, 255, 0.4)',
          'secondary-glow': 'rgba(255, 0, 170, 0.4)',
        },
      },
      fontFamily: {
        heading: ['"Space Grotesk"', '"PP Mori"', 'sans-serif'],
        body: ['Inter', 'Satoshi', 'sans-serif'],
      },
      animation: {
        'glow-pulse': 'glow-pulse 2s ease-in-out infinite',
        'float': 'float 6s ease-in-out infinite',
        'scanline': 'scanline 8s linear infinite',
      },
      keyframes: {
        'glow-pulse': {
          '0%, 100%': { boxShadow: '0 0 20px rgba(0, 245, 255, 0.3)' },
          '50%': { boxShadow: '0 0 40px rgba(0, 245, 255, 0.6)' },
        },
        'float': {
          '0%, 100%': { transform: 'translateY(0)' },
          '50%': { transform: 'translateY(-20px)' },
        },
        'scanline': {
          '0%': { transform: 'translateY(-100%)' },
          '100%': { transform: 'translateY(100%)' },
        },
      },
    },
  },
  plugins: [],
}