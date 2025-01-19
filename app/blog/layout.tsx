import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Blog - VoxPro',
  description: 'Learn about pronunciation, language learning tips, and updates about VoxPro.',
};

export default function BlogLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <>{children}</>;
} 