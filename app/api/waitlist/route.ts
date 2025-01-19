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
  try {
    console.log('Attempting to send welcome email...');
    console.log('Using API Key:', process.env.RESEND_API_KEY ? 'Present' : 'Missing');
    
    const data = await resend.emails.send({
      from: 'VoxPro <notifications@send.voxpro.app>',
      to: email,
      subject: 'Welcome to the VoxPro Waitlist! 🎉',
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
          <h2 style="color: #1B365D;">Welcome to VoxPro! 🎉</h2>
          <p>Thank you for joining our waitlist! We're thrilled to have you on board.</p>
          <p>You'll be among the first to know when VoxPro launches, and you'll get:</p>
          <ul>
            <li>Early access to the app</li>
            <li>Exclusive updates about our progress</li>
            <li>Special launch offers</li>
          </ul>
          <p>In the meantime, follow us on social media for the latest updates:</p>
          <div style="margin-top: 20px;">
            <a href="https://twitter.com/voxproapp" style="color: #1DA1F2; text-decoration: none; margin-right: 20px;">Twitter</a>
            <a href="https://linkedin.com/company/voxpro" style="color: #0A66C2; text-decoration: none;">LinkedIn</a>
          </div>
          <p style="margin-top: 30px; font-size: 12px; color: #666;">
            You're receiving this email because you joined the VoxPro waitlist. 
            If you didn't sign up, please ignore this email.
          </p>
        </div>
      `,
    });
    
    console.log('Email sent successfully:', data);
    return data;
  } catch (error) {
    console.error('Error sending welcome email:', error);
    throw error;
  }
}

// Send notification to admin
async function sendAdminNotification(email: string) {
  try {
    await resend.emails.send({
      from: 'VoxPro <notifications@send.voxpro.app>',
      to: process.env.ADMIN_EMAIL || 'aktivbrain@gmail.com',
      subject: 'New Waitlist Signup! 📈',
      html: `
        <div style="font-family: Arial, sans-serif;">
          <h2 style="color: #1B365D;">New Waitlist Signup!</h2>
          <p>A new user has joined the VoxPro waitlist:</p>
          <p><strong>Email:</strong> ${email}</p>
          <p><strong>Time:</strong> ${new Date().toLocaleString()}</p>
        </div>
      `,
    });
  } catch (error) {
    console.error('Error sending admin notification:', error);
    // Don't throw the error for admin notifications to avoid affecting the user experience
  }
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