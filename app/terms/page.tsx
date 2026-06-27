import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Terms of Service — BizActivate",
  description: "BizActivate's terms of service. Read our terms and conditions for using our services.",
};

export default function TermsPage() {
  return (
    <div className="pt-36 pb-20">
      <div className="container mx-auto container-padding max-w-3xl">
        <h1 className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-4 tracking-tight">
          Terms of Service
        </h1>
        <p className="text-muted-foreground mb-10">Last updated: December 2024</p>

        <div className="space-y-8">
          {[
            {
              title: "1. Acceptance of Terms",
              content: "By accessing and using BizActivate's website and services, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by these terms, please do not use our services.",
            },
            {
              title: "2. Services",
              content: "BizActivate provides digital agency services including website development, brand identity design, SEO, digital advertising, AI automation, and business growth consulting. Service details, deliverables, and timelines are specified in individual project agreements.",
            },
            {
              title: "3. Payment Terms",
              content: "Payment terms are outlined in individual project proposals. Typically, a 50% deposit is required before project commencement, with the balance due upon completion. Monthly retainer services are billed in advance. All fees are non-refundable except as specified in our 30-day satisfaction guarantee.",
            },
            {
              title: "4. Intellectual Property",
              content: "Upon receipt of full payment, you will own all custom work created for your project. BizActivate retains the right to showcase completed work in our portfolio and marketing materials unless otherwise agreed in writing.",
            },
            {
              title: "5. Client Responsibilities",
              content: "Clients are responsible for: providing accurate information and timely feedback; obtaining necessary rights and permissions for any content provided; ensuring all content provided does not infringe on third-party intellectual property rights.",
            },
            {
              title: "6. Limitation of Liability",
              content: "BizActivate's liability is limited to the amount paid for the specific service in question. We are not liable for indirect, incidental, or consequential damages arising from the use of our services.",
            },
            {
              title: "7. Termination",
              content: "Either party may terminate a service agreement with 30 days written notice. Work completed up to the termination date will be billed accordingly.",
            },
            {
              title: "8. Governing Law",
              content: "These Terms shall be governed by the laws of Singapore. Any disputes shall be resolved through arbitration in Singapore under SIAC rules.",
            },
            {
              title: "9. Contact",
              content: "For questions regarding these Terms of Service, please contact us at legal@bizactivate.com.",
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
