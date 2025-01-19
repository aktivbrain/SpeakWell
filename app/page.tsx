'use client';

import React from 'react';
import Navbar from './components/Navbar';
import Hero from './components/sections/Hero';
import Features from './components/sections/Features';
import HowItWorks from './components/sections/HowItWorks';
import Download from './components/sections/Download';
import FAQ from './components/sections/FAQ';
import Footer from './components/Footer';

export default function Home() {
  return (
    <>
      <Navbar />
      <main>
        <Hero />
        <section id="features">
          <Features />
        </section>
        <section id="how-it-works">
          <HowItWorks />
        </section>
        <section id="download">
          <Download />
        </section>
        <section id="faq">
          <FAQ />
        </section>
      </main>
      <Footer />
    </>
  );
} 