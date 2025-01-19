import { Resend } from 'resend';
import { NextResponse } from 'next/server';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function GET() {
  try {
    console.log('Starting test email send...');
    console.log('Using API Key:', process.env.RESEND_API_KEY ? 'Present' : 'Missing');
    
    const data = await resend.emails.send({
      from: 'VoxPro <notifications@voxpro.app>',
      to: process.env.ADMIN_EMAIL || 'aktivbrain@gmail.com',
      subject: 'Email Configuration Test',
      html: `
        <h1>Email Configuration Test</h1>
        <p>This is a test email to verify your email configuration.</p>
        <p>If you received this email, your DNS records are properly configured!</p>
        <p>Sent from: notifications@voxpro.app</p>
        <p>Time: ${new Date().toISOString()}</p>
      `,
    });

    console.log('Email sent successfully:', data);
    
    return NextResponse.json({ success: true, data });
  } catch (error) {
    console.error('Error sending test email:', error);
    return NextResponse.json(
      { success: false, error: error.message },
      { status: 500 }
    );
  }
} 