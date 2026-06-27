import type { Metadata } from "next";
import { Industries } from "@/components/home/Industries";
import { IndustriesDetail } from "@/components/sections/IndustriesDetail";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "Industries We Serve — Specialized Digital Solutions",
  description:
    "BizActivate serves construction, medical, legal, real estate, restaurants, e-commerce, startups, and more. Specialized strategies for every industry.",
};

export default function IndustriesPage() {
  return (
    <>
      <div className="pt-20">
        <Industries />
        <IndustriesDetail />
        <CTA />
      </div>
    </>
  );
}
