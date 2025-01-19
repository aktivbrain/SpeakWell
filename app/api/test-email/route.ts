import { NextResponse } from 'next/server';
import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export async function GET() {
  try {
    console.log('Testing email with API Key:', process.env.RESEND_API_KEY ? 'Present' : 'Missing');
    
    const data = await resend.emails.send({
      from: 'VoxPro <notifications@send.voxpro.app>',
      to: 'aktivbrain@gmail.com',
      subject: 'Test Email from VoxPro',
      html: '<p>This is a test email to verify the Resend integration.</p>',
    });
    
    console.log('Test email response:', data);
    return NextResponse.json({ success: true, data });
  } catch (error) {
    console.error('Test email error:', error);
    return NextResponse.json({ success: false, error }, { status: 500 });
  }
} 