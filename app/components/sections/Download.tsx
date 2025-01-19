'use client';

import React from 'react';
import Image from 'next/image';

const Download: React.FC = () => {
  return (
    <section className="py-20 bg-gradient-to-br from-[#1B365D] to-[#0F1F35] text-white">
      <div className="container mx-auto px-4">
        <div className="flex flex-col lg:flex-row items-center justify-between gap-12">
          <div className="lg:w-1/2">
            <h2 className="text-4xl font-bold mb-6">
              Start Improving Your Pronunciation Today
            </h2>
            <p className="text-xl text-gray-300 mb-8">
              Download VoxPro now and begin your journey to perfect pronunciation with our AI-powered coach.
            </p>
            <div className="flex flex-col sm:flex-row gap-4">
              <button className="flex items-center justify-center px-8 py-3 bg-[#FF6B6B] hover:bg-[#FF8585] rounded-full font-semibold transition-colors">
                <span className="mr-2">🍎</span>
                Download for iOS
              </button>
              <button className="flex items-center justify-center px-8 py-3 border-2 border-white hover:bg-white hover:text-[#1B365D] rounded-full font-semibold transition-colors">
                <span className="mr-2">🤖</span>
                Download for Android
              </button>
            </div>
          </div>
          <div className="lg:w-1/2 relative">
            <div className="relative w-full max-w-md mx-auto">
              <Image
                src="/app-preview.svg"
                alt="VoxPro App Preview"
                width={400}
                height={800}
                className="rounded-3xl shadow-2xl"
              />
              <div className="absolute -top-4 -right-4 bg-[#FF6B6B] text-white px-4 py-2 rounded-full transform rotate-12">
                Free Download!
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Download; 