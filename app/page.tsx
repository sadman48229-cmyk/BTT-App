import { Hero } from "@/components/home/Hero";
import { SocialProof } from "@/components/home/SocialProof";
import { Philosophy } from "@/components/home/Philosophy";
import { Services } from "@/components/home/Services";
import { Framework } from "@/components/home/Framework";
import { Industries } from "@/components/home/Industries";
import { CaseStudies } from "@/components/home/CaseStudies";
import { Testimonials } from "@/components/home/Testimonials";
import { AISection } from "@/components/home/AISection";
import { Pricing } from "@/components/home/Pricing";
import { FAQ } from "@/components/home/FAQ";
import { CTA } from "@/components/home/CTA";

export default function HomePage() {
  return (
    <>
      <Hero />
      <SocialProof />
      <Philosophy />
      <Services />
      <Framework />
      <Industries />
      <CaseStudies />
      <Testimonials />
      <AISection />
      <Pricing />
      <FAQ />
      <CTA />
    </>
  );
}
