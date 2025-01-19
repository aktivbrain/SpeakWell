import Navbar from './components/Navbar';
import Hero from './components/sections/Hero';
import Features from './components/sections/Features';
import HowItWorks from './components/sections/HowItWorks';
import Download from './components/sections/Download';
import FAQ from './components/sections/FAQ';
import Waitlist from './components/sections/Waitlist';
import Footer from './components/Footer';
import BlogPreview from './components/sections/BlogPreview';
import { getAllPosts } from './utils/mdx';

export default async function Home() {
  const posts = await getAllPosts();

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
        <section id="waitlist">
          <Waitlist />
        </section>
        <section id="faq">
          <FAQ />
        </section>
        <section id="blog-preview">
          <BlogPreview posts={posts} />
        </section>
      </main>
      <Footer />
    </>
  );
} 