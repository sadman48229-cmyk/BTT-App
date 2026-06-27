import React from "react";
import Link from "next/link";
import { Zap, Twitter, Linkedin, Instagram, Youtube, ArrowUpRight } from "lucide-react";

const footerLinks = {
  services: [
    { label: "Website Development", href: "/services#websites" },
    { label: "UI/UX Design", href: "/services#design" },
    { label: "Brand Identity", href: "/services#brand" },
    { label: "SEO & Local SEO", href: "/services#seo" },
    { label: "Google & Meta Ads", href: "/services#ads" },
    { label: "AI Automation", href: "/services#ai" },
    { label: "Business Strategy", href: "/services#strategy" },
    { label: "CRM Systems", href: "/services#crm" },
  ],
  company: [
    { label: "About Us", href: "/about" },
    { label: "Our Work", href: "/portfolio" },
    { label: "Case Studies", href: "/case-studies" },
    { label: "Industries", href: "/industries" },
    { label: "Pricing", href: "/pricing" },
    { label: "Blog", href: "/blog" },
    { label: "Careers", href: "/careers" },
  ],
  resources: [
    { label: "FAQ", href: "/faq" },
    { label: "Contact Us", href: "/contact" },
    { label: "Book Strategy Call", href: "/book-call" },
    { label: "Privacy Policy", href: "/privacy" },
    { label: "Terms of Service", href: "/terms" },
  ],
};

const socials = [
  { icon: Twitter, href: "https://twitter.com/bizactivate", label: "Twitter" },
  { icon: Linkedin, href: "https://linkedin.com/company/bizactivate", label: "LinkedIn" },
  { icon: Instagram, href: "https://instagram.com/bizactivate", label: "Instagram" },
  { icon: Youtube, href: "https://youtube.com/@bizactivate", label: "YouTube" },
];

const countries = ["Singapore", "United States", "Canada", "Australia", "United Kingdom", "New Zealand", "UAE"];

export function Footer() {
  return (
    <footer className="border-t border-border relative overflow-hidden">
      {/* Background gradient */}
      <div className="absolute inset-0 bg-gradient-to-b from-transparent to-brand-blue/5 pointer-events-none" />

      <div className="container mx-auto container-padding relative">
        {/* Top CTA Banner */}
        <div className="py-16 border-b border-border">
          <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-8">
            <div>
              <p className="text-sm font-semibold text-primary uppercase tracking-widest mb-3">
                Ready to Activate?
              </p>
              <h2 className="font-display text-3xl md:text-4xl lg:text-5xl font-bold text-foreground max-w-xl">
                Let&apos;s Build Something{" "}
                <span className="gradient-text">Extraordinary</span>
              </h2>
            </div>
            <div className="flex flex-col sm:flex-row gap-3">
              <Link
                href="/book-call"
                className="inline-flex items-center gap-2 px-7 py-3.5 rounded-xl brand-gradient text-white font-semibold text-sm hover:shadow-xl hover:shadow-brand-blue/25 hover:scale-[1.02] transition-all duration-300"
              >
                Book Free Strategy Call
                <ArrowUpRight className="w-4 h-4" />
              </Link>
              <Link
                href="/contact"
                className="inline-flex items-center gap-2 px-7 py-3.5 rounded-xl border-2 border-border text-foreground font-semibold text-sm hover:border-primary hover:text-primary transition-all duration-300"
              >
                Get in Touch
              </Link>
            </div>
          </div>
        </div>

        {/* Main Footer Grid */}
        <div className="py-16 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-10">
          {/* Brand */}
          <div className="lg:col-span-2">
            <Link href="/" className="flex items-center gap-2.5 mb-5">
              <div className="w-9 h-9 rounded-xl brand-gradient flex items-center justify-center shadow-lg shadow-brand-blue/30">
                <Zap className="w-5 h-5 text-white fill-white" />
              </div>
              <span className="font-display font-bold text-xl tracking-tight">
                <span className="gradient-text">Biz</span>
                <span className="text-foreground">Activate</span>
              </span>
            </Link>
            <p className="text-muted-foreground text-sm leading-relaxed max-w-xs mb-6">
              We don&apos;t build websites. We activate businesses. Transform your
              startup or growing company into a digital-first powerhouse.
            </p>
            <div className="flex gap-3 mb-8">
              {socials.map((social) => (
                <a
                  key={social.label}
                  href={social.href}
                  target="_blank"
                  rel="noopener noreferrer"
                  aria-label={social.label}
                  className="w-9 h-9 rounded-xl glass border border-border flex items-center justify-center text-muted-foreground hover:text-primary hover:border-primary/30 transition-all duration-200"
                >
                  <social.icon className="w-4 h-4" />
                </a>
              ))}
            </div>
            <div className="flex flex-wrap gap-2">
              {countries.map((country) => (
                <span
                  key={country}
                  className="text-xs px-2.5 py-1 rounded-full bg-foreground/5 text-muted-foreground border border-border"
                >
                  {country}
                </span>
              ))}
            </div>
          </div>

          {/* Links */}
          <div>
            <h4 className="font-display font-semibold text-sm text-foreground mb-4 uppercase tracking-widest">
              Services
            </h4>
            <ul className="flex flex-col gap-2.5">
              {footerLinks.services.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-sm text-muted-foreground hover:text-foreground transition-colors duration-150"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h4 className="font-display font-semibold text-sm text-foreground mb-4 uppercase tracking-widest">
              Company
            </h4>
            <ul className="flex flex-col gap-2.5">
              {footerLinks.company.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-sm text-muted-foreground hover:text-foreground transition-colors duration-150"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h4 className="font-display font-semibold text-sm text-foreground mb-4 uppercase tracking-widest">
              Resources
            </h4>
            <ul className="flex flex-col gap-2.5">
              {footerLinks.resources.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="text-sm text-muted-foreground hover:text-foreground transition-colors duration-150"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="py-6 border-t border-border flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-xs text-muted-foreground">
            © {new Date().getFullYear()} BizActivate. All rights reserved.
          </p>
          <div className="flex items-center gap-6">
            <Link
              href="/privacy"
              className="text-xs text-muted-foreground hover:text-foreground transition-colors"
            >
              Privacy Policy
            </Link>
            <Link
              href="/terms"
              className="text-xs text-muted-foreground hover:text-foreground transition-colors"
            >
              Terms of Service
            </Link>
          </div>
          <p className="text-xs text-muted-foreground">
            Built with precision. Powered by purpose.
          </p>
        </div>
      </div>
    </footer>
  );
}
