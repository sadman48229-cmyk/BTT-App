import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Privacy Policy — BizActivate",
  description: "BizActivate's privacy policy. Learn how we collect, use, and protect your data.",
};

export default function PrivacyPage() {
  return (
    <div className="pt-36 pb-20">
      <div className="container mx-auto container-padding max-w-3xl">
        <h1 className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-4 tracking-tight">
          Privacy Policy
        </h1>
        <p className="text-muted-foreground mb-10">Last updated: December 2024</p>

        <div className="prose prose-invert max-w-none space-y-8">
          {[
            {
              title: "1. Introduction",
              content: "BizActivate ('we', 'our', or 'us') is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website BizActivate.com or use our services.",
            },
            {
              title: "2. Information We Collect",
              content: "We may collect information you provide directly to us, such as when you fill out a contact form, book a strategy call, or subscribe to our newsletter. This includes: name, email address, phone number, company name, and any other information you choose to provide. We also automatically collect certain technical information including IP address, browser type, pages visited, and time spent on pages.",
            },
            {
              title: "3. How We Use Your Information",
              content: "We use the information we collect to: provide, maintain, and improve our services; respond to your inquiries and fulfill your requests; send you technical notices and marketing communications (with your consent); analyze trends and track website usage; detect and prevent fraudulent transactions and other illegal activities.",
            },
            {
              title: "4. Information Sharing",
              content: "We do not sell, trade, or rent your personal information to third parties. We may share your information with trusted service providers who assist us in operating our website and conducting our business, subject to confidentiality agreements. We may also disclose your information where required by law.",
            },
            {
              title: "5. Data Security",
              content: "We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.",
            },
            {
              title: "6. Cookies",
              content: "We use cookies and similar tracking technologies to track activity on our website and store certain information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.",
            },
            {
              title: "7. Your Rights",
              content: "Depending on your location, you may have the right to access, update, or delete your personal information; object to processing of your personal information; request restriction of processing; and data portability. To exercise these rights, please contact us at privacy@bizactivate.com.",
            },
            {
              title: "8. International Transfers",
              content: "Your information may be transferred to and processed in countries other than your country of residence. These countries may have different data protection laws. We ensure appropriate safeguards are in place for such transfers.",
            },
            {
              title: "9. Contact Us",
              content: "If you have questions about this Privacy Policy, please contact us at: privacy@bizactivate.com or write to us at BizActivate, Singapore.",
            },
          ].map((section) => (
            <div key={section.title} className="border-b border-border pb-8 last:border-0">
              <h2 className="font-display font-bold text-xl text-foreground mb-3">{section.title}</h2>
              <p className="text-muted-foreground leading-relaxed">{section.content}</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
