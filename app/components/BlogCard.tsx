import { motion } from 'framer-motion';
import Link from 'next/link';
import Image from 'next/image';

interface BlogCardProps {
  title: string;
  description: string;
  date: string;
  slug: string;
  readTime: string;
  category: string;
  imageUrl?: string;
}

export default function BlogCard({
  title,
  description,
  date,
  slug,
  readTime,
  category,
  imageUrl = '/blog-placeholder.jpg',
}: BlogCardProps) {
  return (
    <motion.article
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
      className="bg-white rounded-xl shadow-sm overflow-hidden hover:shadow-md transition-shadow"
    >
      <Link href={`/blog/${slug}`} className="block">
        <div className="relative h-48 w-full">
          <Image
            src={imageUrl}
            alt={title}
            fill
            className="object-cover"
          />
        </div>
        <div className="p-6">
          <div className="flex items-center gap-4 mb-4">
            <span className="text-sm text-primary font-medium">{category}</span>
            <span className="text-sm text-gray-500">{date}</span>
            <span className="text-sm text-gray-500">{readTime} read</span>
          </div>
          <h3 className="text-xl font-bold mb-2 text-gray-900 hover:text-primary transition-colors">
            {title}
          </h3>
          <p className="text-gray-600 line-clamp-2">{description}</p>
          <div className="mt-4">
            <span className="text-primary font-medium hover:text-primary-dark transition-colors">
              Read more →
            </span>
          </div>
        </div>
      </Link>
    </motion.article>
  );
} 