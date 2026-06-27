import type { Metadata } from "next";
import { Pricing } from "@/components/home/Pricing";
import { FAQ } from "@/components/home/FAQ";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "Pricing — Transparent Investment Plans for Every Stage",
  description:
    "Clear, transparent pricing for BizActivate's services. Launch, Grow, and Scale plans for startups and growing businesses. No hidden fees.",
};

export default function PricingPage() {
  return (
    <div className="pt-20">
      <div className="pt-10">
        <Pricing />
      </div>
      <FAQ />
      <CTA />
    </div>
  );
}
