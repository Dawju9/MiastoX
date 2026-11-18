// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    const target = document.querySelector(this.getAttribute('href'));
    if (!target) return;
    e.preventDefault();
    target.scrollIntoView({
      behavior: 'smooth',
      block: 'start'
    });
  });
});

// Mobile menu toggle
const menuToggle = document.getElementById('menu-toggle');
const mobileMenu = document.getElementById('mobile-menu');
if (menuToggle && mobileMenu) {
  menuToggle.addEventListener('click', () => {
    mobileMenu.classList.toggle('hidden');
  });
}

// Fade in sections on scroll
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('fade-in');
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('section').forEach(section => {
  observer.observe(section);
});

// Neon glow hover effect
document.querySelectorAll('.glow').forEach(el => {
  el.addEventListener('mouseenter', () => {
    el.classList.add('glow-effect');
  });
  el.addEventListener('mouseleave', () => {
    el.classList.remove('glow-effect');
  });
});

// 3D map iframe loader
const mapIframe = document.querySelector('iframe');
if (mapIframe) {
  mapIframe.onload = () => {
    mapIframe.style.opacity = 1;
  };
}
