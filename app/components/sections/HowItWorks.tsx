'use client';

import React from 'react';

const steps = [
  {
    number: '01',
    title: 'Record Your Speech',
    description: 'Simply tap the record button and speak the text you want to practice.',
  },
  {
    number: '02',
    title: 'Get AI Analysis',
    description: 'Our advanced AI analyzes your pronunciation in real-time, providing detailed feedback.',
  },
  {
    number: '03',
    title: 'Review & Practice',
    description: 'Review your scores and specific areas for improvement, then practice to perfect your pronunciation.',
  }
];

const HowItWorks: React.FC = () => {
  return (
    <section className="py-20 bg-white">
      <div className="container mx-auto px-4">
        <h2 className="text-4xl font-bold text-center text-[#1B365D] mb-16">
          How VoxPro Works
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {steps.map((step, index) => (
            <div
              key={index}
              className="relative p-6"
            >
              <div className="text-6xl font-bold text-[#FF6B6B] opacity-20 absolute top-0 left-6">
                {step.number}
              </div>
              <div className="relative z-10 mt-8">
                <h3 className="text-2xl font-semibold text-[#1B365D] mb-4">
                  {step.title}
                </h3>
                <p className="text-gray-600">
                  {step.description}
                </p>
              </div>
              {index < steps.length - 1 && (
                <div className="hidden md:block absolute top-1/2 right-0 transform translate-x-1/2 -translate-y-1/2 text-4xl text-[#FF6B6B] opacity-20">
                  →
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default HowItWorks; 