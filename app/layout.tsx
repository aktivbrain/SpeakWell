import React from 'react';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import Script from 'next/script';
import { GA_MEASUREMENT_ID } from './utils/analytics';
import './globals.css';
import { SpeedInsights } from "@vercel/speed-insights/next"

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
      <head>
        {/* Google Analytics */}
        <Script
          src={`https://www.googletagmanager.com/gtag/js?id=${GA_MEASUREMENT_ID}`}
          strategy="afterInteractive"
        />
        <Script id="google-analytics" strategy="afterInteractive">
          {`
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', '${GA_MEASUREMENT_ID}');
          `}
        </Script>
      </head>
      <body className={inter.className}>
        {children}
        <SpeedInsights />
      </body>
    </html>
  );
} 