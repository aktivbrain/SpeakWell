'use client';

import React from 'react';

const features = [
  {
    title: 'Real-time Feedback',
    description: 'Get instant pronunciation feedback powered by Azure AI technology.',
    icon: '🎯'
  },
  {
    title: 'Detailed Analysis',
    description: 'Receive comprehensive analysis of your pronunciation, including accuracy, fluency, and completeness scores.',
    icon: '📊'
  },
  {
    title: 'Practice Resources',
    description: 'Access a vast library of pronunciation exercises, including vowels, consonants, and common phrases.',
    icon: '📚'
  },
  {
    title: 'Progress Tracking',
    description: 'Monitor your improvement over time with detailed progress reports and statistics.',
    icon: '📈'
  }
];

const Features: React.FC = () => {
  return (
    <section className="py-20 bg-[#F0F2F5]">
      <div className="container mx-auto px-4">
        <h2 className="text-4xl font-bold text-center text-[#1B365D] mb-12">
          Features that Set Us Apart
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {features.map((feature, index) => (
            <div
              key={index}
              className="bg-white p-6 rounded-xl shadow-lg hover:shadow-xl transition-shadow"
            >
              <div className="text-4xl mb-4">{feature.icon}</div>
              <h3 className="text-xl font-semibold text-[#1B365D] mb-2">
                {feature.title}
              </h3>
              <p className="text-gray-600">
                {feature.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Features; 