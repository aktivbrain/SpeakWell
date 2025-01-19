'use client';

import React, { useState, useEffect } from 'react';
import Image from 'next/image';

const Navbar: React.FC = () => {
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <nav
      className={`fixed w-full z-50 transition-all duration-300 ${
        isScrolled
          ? 'bg-white shadow-md py-2'
          : 'bg-transparent py-4'
      }`}
    >
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between">
          {/* Logo */}
          <div className="flex items-center">
            <Image
              src="/logo.svg"
              alt="VoxPro Logo"
              width={40}
              height={40}
              className="mr-2"
            />
            <span className={`font-bold text-xl ${
              isScrolled ? 'text-[#1B365D]' : 'text-white'
            }`}>
              VoxPro
            </span>
          </div>

          {/* Navigation Links */}
          <div className="hidden md:flex items-center space-x-8">
            <NavLink href="#features" isScrolled={isScrolled}>Features</NavLink>
            <NavLink href="#how-it-works" isScrolled={isScrolled}>How It Works</NavLink>
            <NavLink href="#faq" isScrolled={isScrolled}>FAQ</NavLink>
          </div>

          {/* Download Button */}
          <button className={`px-6 py-2 rounded-full font-semibold transition-colors ${
            isScrolled
              ? 'bg-[#1B365D] text-white hover:bg-[#2A4A7F]'
              : 'bg-white text-[#1B365D] hover:bg-gray-100'
          }`}>
            Download
          </button>
        </div>
      </div>
    </nav>
  );
};

interface NavLinkProps {
  href: string;
  children: React.ReactNode;
  isScrolled: boolean;
}

const NavLink: React.FC<NavLinkProps> = ({ href, children, isScrolled }) => (
  <a
    href={href}
    className={`font-medium hover:opacity-75 transition-colors ${
      isScrolled ? 'text-[#1B365D]' : 'text-white'
    }`}
  >
    {children}
  </a>
);

export default Navbar; 