'use client';

import React, { useState } from 'react';

const faqs = [
  {
    question: "How does VoxPro help improve pronunciation?",
    answer: "VoxPro uses advanced AI technology to analyze your speech in real-time, providing detailed feedback on accuracy, fluency, and completeness. It identifies specific areas for improvement and offers targeted practice exercises."
  },
  {
    question: "Is VoxPro suitable for beginners?",
    answer: "Yes! VoxPro is designed for learners at all levels. Whether you're just starting to learn English or looking to perfect your pronunciation, our app adapts to your skill level and provides appropriate feedback."
  },
  {
    question: "What devices is VoxPro available on?",
    answer: "VoxPro is available for both iOS and Android devices. You can download it from the App Store or Google Play Store and start practicing right away."
  },
  {
    question: "Do I need an internet connection to use VoxPro?",
    answer: "Yes, an internet connection is required to use VoxPro's real-time analysis features. However, you can download practice materials for offline use."
  },
  {
    question: "Is VoxPro free to use?",
    answer: "VoxPro offers a free version with basic features. For advanced features and unlimited practice sessions, we offer affordable premium subscriptions."
  }
];

const FAQ: React.FC = () => {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  const toggleFAQ = (index: number) => {
    setOpenIndex(openIndex === index ? null : index);
  };

  return (
    <section className="py-20 bg-[#F0F2F5]">
      <div className="container mx-auto px-4">
        <h2 className="text-4xl font-bold text-center text-[#1B365D] mb-12">
          Frequently Asked Questions
        </h2>
        <div className="max-w-3xl mx-auto">
          {faqs.map((faq, index) => (
            <div
              key={index}
              className="mb-4 bg-white rounded-lg shadow-md overflow-hidden"
            >
              <button
                className="w-full px-6 py-4 text-left flex justify-between items-center hover:bg-gray-50"
                onClick={() => toggleFAQ(index)}
              >
                <span className="text-lg font-semibold text-[#1B365D]">
                  {faq.question}
                </span>
                <span className={`transform transition-transform ${openIndex === index ? 'rotate-180' : ''}`}>
                  ▼
                </span>
              </button>
              <div
                className={`px-6 overflow-hidden transition-all duration-300 ease-in-out ${
                  openIndex === index ? 'max-h-96 py-4' : 'max-h-0'
                }`}
              >
                <p className="text-gray-600">{faq.answer}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default FAQ; 