interface GTagEvent {
  action: string;
  category: string;
  label: string;
  value?: number;
}

declare global {
  interface Window {
    dataLayer: any[];
    gtag: (...args: any[]) => void;
  }
}

export {}; 