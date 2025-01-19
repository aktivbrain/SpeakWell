'use client';

import React from 'react';
import Image from 'next/image';

const Hero: React.FC = () => {
  return (
    <section className="relative min-h-screen bg-gradient-to-b from-[#1B365D] to-[#0F1F35] text-white">
      <div className="container mx-auto px-4 py-20 flex flex-col items-center justify-center text-center">
        <Image
          src="/logo.png"
          alt="VoxPro Logo"
          width={120}
          height={120}
          className="mb-8"
        />
        <h1 className="text-5xl md:text-6xl font-bold mb-6">
          Master Your Pronunciation with VoxPro
        </h1>
        <p className="text-xl md:text-2xl mb-8 text-gray-300 max-w-2xl">
          Your AI-powered pronunciation coach for perfecting English speech through real-time feedback and personalized practice.
        </p>
        <div className="flex flex-col sm:flex-row gap-4">
          <button className="px-8 py-3 bg-[#FF6B6B] hover:bg-[#FF8585] rounded-full font-semibold transition-colors">
            Download Now
          </button>
          <button className="px-8 py-3 border-2 border-white hover:bg-white hover:text-[#1B365D] rounded-full font-semibold transition-colors">
            Learn More
          </button>
        </div>
      </div>
      <div className="absolute bottom-0 left-0 right-0 h-20 bg-gradient-to-t from-[#F0F2F5] to-transparent" />
    </section>
  );
};

export default Hero; 