import { notFound } from 'next/navigation';
import { getPostBySlug } from '../../utils/mdx';
import BlogPostLayout from '../../components/BlogPostLayout';

interface BlogPostPageProps {
  params: {
    slug: string;
  };
}

export default async function BlogPostPage({ params }: BlogPostPageProps) {
  try {
    const post = await getPostBySlug(params.slug);
    
    if (!post) {
      notFound();
    }

    return <BlogPostLayout post={post} />;
  } catch (error) {
    console.error('Error fetching post:', error);
    notFound();
  }
} 