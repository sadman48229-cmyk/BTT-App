import type { Metadata } from "next";
import { FAQ } from "@/components/home/FAQ";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "FAQ — Frequently Asked Questions",
  description:
    "Find answers to the most common questions about BizActivate's services, process, pricing, and results.",
};

export default function FAQPage() {
  return (
    <div className="pt-32">
      <div className="container mx-auto container-padding mb-4 text-center">
        <h1 className="font-display font-extrabold text-5xl md:text-6xl text-foreground tracking-tight">
          Frequently Asked <span className="gradient-text">Questions</span>
        </h1>
      </div>
      <FAQ />
      <CTA />
    </div>
  );
}
