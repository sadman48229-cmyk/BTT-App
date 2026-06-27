import type { Metadata } from "next";
import { Inter, Syne } from "next/font/google";
import "./globals.css";
import { ThemeProvider } from "@/components/providers/ThemeProvider";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

const syne = Syne({
  subsets: ["latin"],
  variable: "--font-syne",
  display: "swap",
  weight: ["400", "500", "600", "700", "800"],
});

export const metadata: Metadata = {
  metadataBase: new URL("https://bizactivate.com"),
  title: {
    default: "BizActivate — Business Activation Agency",
    template: "%s | BizActivate",
  },
  description:
    "We activate businesses digitally. Transform your startup or growing business with premium websites, digital marketing, AI automation, and business strategy. Singapore, USA, Canada, Australia, UK.",
  keywords: [
    "business activation agency",
    "digital agency Singapore",
    "web design Singapore",
    "AI automation agency",
    "digital marketing agency",
    "SEO agency",
    "brand strategy",
    "startup growth",
    "business transformation",
  ],
  authors: [{ name: "BizActivate" }],
  creator: "BizActivate",
  publisher: "BizActivate",
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://bizactivate.com",
    siteName: "BizActivate",
    title: "BizActivate — We Activate Businesses Digitally",
    description:
      "Transform your business with premium websites, AI automation, digital marketing, and growth strategy. The world's leading Business Activation Agency.",
    images: [
      {
        url: "/og-image.png",
        width: 1200,
        height: 630,
        alt: "BizActivate — Business Activation Agency",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "BizActivate — Business Activation Agency",
    description:
      "We activate businesses digitally. Premium websites, AI automation, digital marketing & growth strategy.",
    images: ["/og-image.png"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning className={`${inter.variable} ${syne.variable}`}>
      <body className="font-sans min-h-screen">
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          <Header />
          <main className="page-enter">{children}</main>
          <Footer />
        </ThemeProvider>
      </body>
    </html>
  );
}
