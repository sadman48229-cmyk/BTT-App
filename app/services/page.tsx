import type { Metadata } from "next";
import { ServicesHero } from "@/components/sections/ServicesHero";
import { ServicesDetail } from "@/components/sections/ServicesDetail";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "Services — Premium Digital Services for Business Growth",
  description:
    "Explore BizActivate's full range of services: premium websites, brand identity, SEO, Google & Meta Ads, AI automation, CRM systems, and business growth strategy.",
};

export default function ServicesPage() {
  return (
    <>
      <ServicesHero />
      <ServicesDetail />
      <CTA />
    </>
  );
}
