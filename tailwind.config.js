/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './content/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#4F46E5',
        secondary: '#10B981',
      },
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-out forwards',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0', transform: 'translateY(20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
      typography: {
        DEFAULT: {
          css: {
            color: '#374151',
            a: {
              color: '#4F46E5',
              '&:hover': {
                color: '#4338CA',
              },
            },
            h1: {
              color: '#111827',
              fontWeight: '800',
            },
            h2: {
              color: '#1F2937',
              fontWeight: '700',
            },
            h3: {
              color: '#374151',
              fontWeight: '600',
            },
            strong: {
              color: '#111827',
            },
            code: {
              color: '#4F46E5',
              backgroundColor: '#F3F4F6',
              padding: '0.25rem',
              borderRadius: '0.25rem',
              fontWeight: '600',
            },
            'code::before': {
              content: '""',
            },
            'code::after': {
              content: '""',
            },
            hr: {
              borderColor: '#E5E7EB',
            },
            'ul > li::before': {
              backgroundColor: '#D1D5DB',
            },
            'ol > li::before': {
              color: '#6B7280',
            },
            blockquote: {
              color: '#1F2937',
              borderLeftColor: '#E5E7EB',
            },
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}; 