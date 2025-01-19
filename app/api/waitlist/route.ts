import { NextResponse } from 'next/server';
import fs from 'fs/promises';
import path from 'path';
import { Resend } from 'resend';

const WAITLIST_FILE = path.join(process.cwd(), 'data', 'waitlist.json');
const resend = new Resend(process.env.RESEND_API_KEY);

// Ensure the data directory exists
async function ensureDirectory() {
  const dir = path.join(process.cwd(), 'data');
  try {
    await fs.access(dir);
  } catch {
    await fs.mkdir(dir);
  }
}

// Read the waitlist file
async function readWaitlist(): Promise<string[]> {
  try {
    const data = await fs.readFile(WAITLIST_FILE, 'utf-8');
    return JSON.parse(data);
  } catch {
    return [];
  }
}

// Write to the waitlist file
async function writeWaitlist(emails: string[]) {
  await fs.writeFile(WAITLIST_FILE, JSON.stringify(emails, null, 2));
}

// Send welcome email
async function sendWelcomeEmail(email: string) {
  return resend.emails.send({
    from: 'VoxPro <notifications@voxpro.app>',
    to: email,
    subject: 'Welcome to VoxPro Waitlist!',
    html: `
      <h1>Welcome to VoxPro!</h1>
      <p>Thank you for joining our waitlist. We're excited to have you on board!</p>
      <p>We'll keep you updated on our progress and let you know when VoxPro is ready for you.</p>
      <p>Best regards,<br/>The VoxPro Team</p>
    `,
  });
}

// Send notification to admin
async function sendAdminNotification(email: string) {
  return resend.emails.send({
    from: 'VoxPro <notifications@voxpro.app>',
    to: process.env.ADMIN_EMAIL || 'aktivbrain@gmail.com',
    subject: 'New Waitlist Signup!',
    html: `
      <h1>New Waitlist Signup</h1>
      <p>A new user has joined the VoxPro waitlist:</p>
      <p>Email: ${email}</p>
      <p>Time: ${new Date().toISOString()}</p>
    `,
  });
}

export async function POST(request: Request) {
  try {
    const { email } = await request.json();
    console.log('Received email submission:', email);

    // Basic email validation
    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      return NextResponse.json(
        { error: 'Invalid email address' },
        { status: 400 }
      );
    }

    await ensureDirectory();
    const emails = await readWaitlist();

    // Check if email already exists
    if (emails.includes(email)) {
      return NextResponse.json(
        { error: 'Email already registered' },
        { status: 400 }
      );
    }

    // Add new email and save
    emails.push(email);
    await writeWaitlist(emails);

    // Send emails asynchronously
    Promise.all([
      sendWelcomeEmail(email),
      sendAdminNotification(email)
    ]).catch(console.error);

    return NextResponse.json(
      { message: 'Successfully joined waitlist' },
      { status: 200 }
    );
  } catch (error) {
    console.error('Waitlist error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
} 