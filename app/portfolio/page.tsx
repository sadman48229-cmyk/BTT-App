import type { Metadata } from "next";
import { PortfolioPage } from "@/components/sections/PortfolioPage";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "Portfolio — Our Best Work",
  description:
    "Browse BizActivate's portfolio of premium websites, brand identities, and digital campaigns across diverse industries.",
};

export default function Portfolio() {
  return (
    <>
      <PortfolioPage />
      <CTA />
    </>
  );
}
