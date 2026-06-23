/**
 * Utility functions to generate and trigger native deep links for calling, WhatsApp, SMS, and Gmail on mobile devices.
 */

export function isMobileDevice(): boolean {
  if (typeof window === 'undefined') return false;
  const userAgent = window.navigator.userAgent;
  const isTouchDevice = 'ontouchstart' in window || window.navigator.maxTouchPoints > 0;
  return /Mobi|Android|iPhone|iPad|iPod/i.test(userAgent) || (isTouchDevice && !/Windows/i.test(userAgent));
}

export function triggerWhatsApp(phone: string | undefined, recruiterName?: string): void {
  if (typeof window === 'undefined' || !phone) return;
  let cleanPhone = phone.replace(/[^0-9]/g, '');
  if (cleanPhone.length === 10) {
    cleanPhone = '91' + cleanPhone;
  }
  const text = recruiterName ? `Hi ${recruiterName.trim()}, ` : '';
  const encodedText = text ? `&text=${encodeURIComponent(text)}` : '';

  if (isMobileDevice()) {
    // Mobile native app deep link
    window.location.href = `whatsapp://send?phone=${cleanPhone}${encodedText}`;
  } else {
    // Desktop universal web link fallback
    window.open(`https://api.whatsapp.com/send?phone=${cleanPhone}${encodedText}`, '_blank', 'noopener,noreferrer');
  }
}

export function triggerSMS(phone: string | undefined, _recruiterName?: string): void {
  if (typeof window === 'undefined' || !phone) return;
  void _recruiterName;
  const cleanPhone = phone.replace(/[^0-9+]/g, '');

  if (isMobileDevice()) {
    window.location.href = `sms:${cleanPhone}`;
  } else {
    window.open(`https://messages.google.com/web/conversations/new?phone=${cleanPhone}`, '_blank', 'noopener,noreferrer');
  }
}

export function triggerGmail(email: string | undefined, recruiterName?: string): void {
  if (typeof window === 'undefined' || !email) return;
  const subject = encodeURIComponent("Job Application Status");
  const body = recruiterName ? encodeURIComponent(`Hi ${recruiterName.trim()},\n\n`) : '';
  window.location.href = `mailto:${email}?subject=${subject}${body ? `&body=${body}` : ''}`;
}

export function triggerPhone(phone: string | undefined): void {
  if (typeof window === 'undefined' || !phone) return;
  const cleanPhone = phone.replace(/[^0-9+]/g, '');
  window.location.href = `tel:${cleanPhone}`;
}

// Deprecated: Retained for backward compatibility during build phase
export function getWhatsAppLink(phone: string, recruiterName?: string): string {
  let cleanPhone = phone.replace(/[^0-9]/g, '');
  if (cleanPhone.length === 10) cleanPhone = '91' + cleanPhone;
  const text = recruiterName ? `Hi ${recruiterName.trim()}, ` : '';
  const encodedText = text ? `&text=${encodeURIComponent(text)}` : '';
  if (isMobileDevice()) return `whatsapp://send?phone=${cleanPhone}${encodedText}`;
  return `https://api.whatsapp.com/send?phone=${cleanPhone}${encodedText}`;
}

export function getGmailLink(email: string, recruiterName?: string): string {
  const subject = encodeURIComponent("Job Application Status");
  const body = recruiterName ? encodeURIComponent(`Hi ${recruiterName.trim()},\n\n`) : '';
  return `mailto:${email}?subject=${subject}${body ? `&body=${body}` : ''}`;
}

export function getPhoneLink(phone: string): string {
  const cleanPhone = phone.replace(/[^0-9+]/g, '');
  return `tel:${cleanPhone}`;
}

export function getGoogleMessagesLink(phone: string, _recruiterName?: string): string {
  void _recruiterName;
  const cleanPhone = phone.replace(/[^0-9+]/g, '');
  if (isMobileDevice()) {
    return `sms:${cleanPhone}`;
  }
  return `https://messages.google.com/web/conversations/new?phone=${cleanPhone}`;
}
