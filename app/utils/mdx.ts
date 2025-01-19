import 'server-only';
import { promises as fs } from 'fs';
import path from 'path';
import matter from 'gray-matter';

const postsDirectory = path.join(process.cwd(), 'content/blog');

export interface Post {
  slug: string;
  title: string;
  description: string;
  date: string;
  category: string;
  readTime: string;
  imageUrl?: string;
  content: string;
}

// Sample posts for development
const samplePosts: Post[] = [
  {
    slug: 'getting-started',
    title: 'Getting Started with English Pronunciation',
    description: 'Learn the basics of English pronunciation and how VoxPro can help you improve your speaking skills.',
    date: '2024-01-19',
    category: 'Pronunciation Tips',
    readTime: '5 min',
    imageUrl: '/blog/getting-started.jpg',
    content: `# Getting Started with English Pronunciation\n\nEnglish pronunciation can be challenging...`,
  },
  {
    slug: 'common-mistakes',
    title: 'Common English Pronunciation Mistakes',
    description: 'Discover the most common pronunciation mistakes and learn how to avoid them.',
    date: '2024-01-20',
    category: 'Learning Strategies',
    readTime: '4 min',
    imageUrl: '/blog/common-mistakes.jpg',
    content: `# Common English Pronunciation Mistakes\n\nMany learners struggle with...`,
  },
];

export async function getAllPosts(): Promise<Post[]> {
  try {
    // Check if the directory exists
    try {
      await fs.access(postsDirectory);
    } catch {
      // Return sample posts if directory doesn't exist
      return samplePosts;
    }

    const fileNames = await fs.readdir(postsDirectory);
    const posts = await Promise.all(
      fileNames
        .filter(fileName => fileName.endsWith('.mdx'))
        .map(async fileName => {
          const slug = fileName.replace(/\.mdx$/, '');
          const fullPath = path.join(postsDirectory, fileName);
          const fileContents = await fs.readFile(fullPath, 'utf8');
          const { data, content } = matter(fileContents);

          return {
            slug,
            title: data.title,
            description: data.description,
            date: data.date,
            category: data.category,
            readTime: data.readTime,
            imageUrl: data.imageUrl,
            content,
          };
        })
    );

    // If no posts found in directory, return sample posts
    return posts.length > 0 ? posts.sort((a, b) => (a.date > b.date ? -1 : 1)) : samplePosts;
  } catch (error) {
    console.error('Error reading blog posts:', error);
    // Return sample posts as fallback
    return samplePosts;
  }
}

export async function getPostBySlug(slug: string): Promise<Post | null> {
  try {
    // First check sample posts
    const samplePost = samplePosts.find(post => post.slug === slug);
    if (samplePost) {
      return samplePost;
    }

    const fullPath = path.join(postsDirectory, `${slug}.mdx`);
    const fileContents = await fs.readFile(fullPath, 'utf8');
    const { data, content } = matter(fileContents);

    return {
      slug,
      title: data.title,
      description: data.description,
      date: data.date,
      category: data.category,
      readTime: data.readTime,
      imageUrl: data.imageUrl,
      content,
    };
  } catch (error) {
    console.error(`Error reading blog post ${slug}:`, error);
    return null;
  }
} 