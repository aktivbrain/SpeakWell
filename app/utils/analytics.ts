// Google Analytics Measurement ID
export const GA_MEASUREMENT_ID = process.env.NEXT_PUBLIC_GA_ID;

// Log page views
export const pageview = (url: string) => {
  window.dataLayer = window.dataLayer || [];
  window.gtag = window.gtag || function(...args) {
    window.dataLayer.push(args);
  };
  
  window.gtag('config', GA_MEASUREMENT_ID!, {
    page_path: url,
  });
};

// Log specific events
export const event = ({ action, category, label, value }: {
  action: string;
  category: string;
  label: string;
  value?: number;
}) => {
  window.dataLayer = window.dataLayer || [];
  window.gtag = window.gtag || function(...args) {
    window.dataLayer.push(args);
  };
  
  window.gtag('event', action, {
    event_category: category,
    event_label: label,
    value: value,
  });
}; 