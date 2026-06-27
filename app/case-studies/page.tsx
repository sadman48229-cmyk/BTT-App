import type { Metadata } from "next";
import { CaseStudiesPage } from "@/components/sections/CaseStudiesPage";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "Case Studies — Real Results, Real Businesses",
  description:
    "In-depth case studies showing how BizActivate helped businesses achieve extraordinary growth through strategy, design, and digital marketing.",
};

export default function CaseStudies() {
  return (
    <>
      <CaseStudiesPage />
      <CTA />
    </>
  );
}
