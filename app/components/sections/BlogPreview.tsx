'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import BlogCard from '../BlogCard';
import type { Post } from '../../utils/mdx';

interface BlogPreviewProps {
  posts: Post[];
}

export default function BlogPreview({ posts }: BlogPreviewProps) {
  const latestPosts = posts.slice(0, 2); // Show only the 2 most recent posts

  return (
    <section id="blog" className="py-20 bg-gray-50">
      <div className="container mx-auto px-4">
        <div className="max-w-4xl mx-auto">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="text-center mb-12"
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Latest from Our Blog</h2>
            <p className="text-lg text-gray-600 mb-8">
              Learn about pronunciation tips, language learning strategies, and stay updated with VoxPro
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
            {latestPosts.map((post) => (
              <BlogCard
                key={post.slug}
                title={post.title}
                description={post.description}
                date={post.date}
                slug={post.slug}
                readTime={post.readTime}
                category={post.category}
                imageUrl={post.imageUrl}
              />
            ))}
          </div>

          <div className="text-center">
            <motion.div
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Link
                href="/blog"
                className="inline-block px-8 py-3 rounded-full bg-white text-primary font-semibold border-2 border-primary hover:bg-primary hover:text-white transition-colors"
              >
                View All Posts
              </Link>
            </motion.div>
          </div>
        </div>
      </div>
    </section>
  );
} 