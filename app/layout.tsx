import React from 'react';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'VoxPro - AI-Powered Pronunciation Coach',
  description: 'Master your English pronunciation with VoxPro, your AI-powered coach providing real-time feedback and personalized practice.',
  keywords: ['pronunciation', 'English learning', 'AI coach', 'speech analysis', 'language learning'],
  openGraph: {
    title: 'VoxPro - AI-Powered Pronunciation Coach',
    description: 'Master your English pronunciation with VoxPro, your AI-powered coach providing real-time feedback and personalized practice.',
    images: ['/og-image.png'],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'VoxPro - AI-Powered Pronunciation Coach',
    description: 'Master your English pronunciation with VoxPro, your AI-powered coach providing real-time feedback and personalized practice.',
    images: ['/og-image.png'],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className="scroll-smooth">
      <body className={inter.className}>
        {children}
      </body>
    </html>
  );
} 