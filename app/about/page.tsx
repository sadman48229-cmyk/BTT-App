import type { Metadata } from "next";
import { AboutHero } from "@/components/sections/AboutHero";
import { AboutStory } from "@/components/sections/AboutStory";
import { AboutValues } from "@/components/sections/AboutValues";
import { AboutTeam } from "@/components/sections/AboutTeam";
import { CTA } from "@/components/home/CTA";

export const metadata: Metadata = {
  title: "About BizActivate — Our Story, Mission & Values",
  description:
    "Learn how BizActivate became the world's leading Business Activation Agency. Our story, mission, values, and the team behind your business transformation.",
};

export default function AboutPage() {
  return (
    <>
      <AboutHero />
      <AboutStory />
      <AboutValues />
      <AboutTeam />
      <CTA />
    </>
  );
}
