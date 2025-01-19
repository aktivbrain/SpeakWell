'use client';

import React from 'react';
import Image from 'next/image';
import { motion } from 'framer-motion';

const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.2,
    },
  },
};

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: {
    opacity: 1,
    y: 0,
    transition: {
      duration: 0.5,
    },
  },
};

const Hero: React.FC = () => {
  return (
    <section className="bg-gradient-to-b from-gray-50 to-white">
      <motion.div
        className="container mx-auto px-4 py-20 flex flex-col items-center justify-center text-center"
        variants={containerVariants}
        initial="hidden"
        animate="visible"
      >
        <motion.div variants={itemVariants}>
          <Image
            src="/logo.svg"
            alt="VoxPro Logo"
            width={60}
            height={60}
            className="mb-6"
          />
        </motion.div>

        <motion.h1
          variants={itemVariants}
          className="text-4xl sm:text-5xl md:text-6xl font-bold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-primary to-primary-dark"
        >
          Master Your Pronunciation with AI
        </motion.h1>

        <motion.p
          variants={itemVariants}
          className="text-xl md:text-2xl text-gray-600 mb-8 max-w-2xl"
        >
          Get real-time feedback on your pronunciation and speak English with confidence.
        </motion.p>

        <motion.div
          variants={itemVariants}
          className="flex flex-wrap gap-4 justify-center"
        >
          <motion.a
            href="#waitlist"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="px-8 py-3 rounded-full bg-primary text-white font-semibold hover:bg-primary-dark transition-colors"
          >
            Join Waitlist
          </motion.a>
          <motion.a
            href="/blog"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="px-8 py-3 rounded-full border-2 border-primary text-primary font-semibold hover:bg-primary hover:text-white transition-colors"
          >
            Read Our Blog
          </motion.a>
        </motion.div>

        <motion.div
          variants={itemVariants}
          className="mt-12 text-sm text-gray-500"
        >
          <p>🎯 Personalized feedback</p>
          <p>🎙️ Advanced speech recognition</p>
          <p>📱 Available on iOS and Android</p>
        </motion.div>
      </motion.div>
    </section>
  );
};

export default Hero; 