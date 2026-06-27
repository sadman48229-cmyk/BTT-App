import type { Metadata } from "next";
import { BlogPage } from "@/components/sections/BlogPage";

export const metadata: Metadata = {
  title: "Blog — Insights on Business, Digital Marketing & AI",
  description:
    "Expert insights on business growth, digital marketing strategies, AI automation, SEO, and brand building from the BizActivate team.",
};

export default function Blog() {
  return <BlogPage />;
}
