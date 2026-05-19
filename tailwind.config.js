/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./_layouts/*.html"],
  theme: {
    extend: {
      colors: {
        neo: {
          bg: '#0a0a0a',
          surface: '#1a1a1a',
          'surface-light': '#242424',
          primary: '#d4d4d4',
          secondary: '#888888',
          accent: '#555555',
          'primary-glow': 'rgba(212, 212, 212, 0.15)',
          'secondary-glow': 'rgba(136, 136, 136, 0.1)',
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
          '0%, 100%': { boxShadow: '0 0 20px rgba(212, 212, 212, 0.1)' },
          '50%': { boxShadow: '0 0 40px rgba(212, 212, 212, 0.2)' },
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