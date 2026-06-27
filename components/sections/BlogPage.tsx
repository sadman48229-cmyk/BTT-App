"use client";

import React, { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { Clock, BookOpen } from "lucide-react";
import { CTA } from "@/components/home/CTA";

const categories = ["All", "SEO", "AI & Automation", "Design", "Marketing", "Strategy", "Growth"];

const posts = [
  {
    slug: "ai-automation-business-growth-2024",
    category: "AI & Automation",
    title: "How AI Automation is Transforming Business Operations in 2024",
    excerpt: "Discover the specific AI tools and workflows that are helping businesses cut operational costs by 60% while scaling their output 3x.",
    readTime: "8 min read",
    date: "Dec 2024",
    color: "#4CC9F0",
  },
  {
    slug: "local-seo-dominate-google-maps",
    category: "SEO",
    title: "The Complete Guide to Dominating Google Maps & Local SEO",
    excerpt: "A step-by-step playbook for getting your business to rank #1 in local search — and keeping it there through algorithm changes.",
    readTime: "12 min read",
    date: "Nov 2024",
    color: "#06D6A0",
  },
  {
    slug: "premium-web-design-conversion-rate",
    category: "Design",
    title: "Why Premium Web Design Increases Conversion Rates by 40%+",
    excerpt: "The science behind first impressions, trust signals, and visual hierarchy that turns visitors into high-value clients.",
    readTime: "7 min read",
    date: "Nov 2024",
    color: "#4361EE",
  },
  {
    slug: "google-ads-strategy-small-business",
    category: "Marketing",
    title: "Google Ads for Small Businesses: Get 5x ROAS Without Wasting Budget",
    excerpt: "The exact campaign structure and bidding strategies we use to generate consistent returns for our clients across every industry.",
    readTime: "10 min read",
    date: "Oct 2024",
    color: "#FFB703",
  },
  {
    slug: "brand-strategy-startup-positioning",
    category: "Strategy",
    title: "How to Position Your Startup for Premium Pricing (Even as a New Brand)",
    excerpt: "Brand positioning is the highest-leverage work a startup can do. Here's the exact framework we use for every new client.",
    readTime: "9 min read",
    date: "Oct 2024",
    color: "#7B2FBE",
  },
  {
    slug: "meta-ads-2024-complete-guide",
    category: "Marketing",
    title: "Meta Ads in 2024: The Creative & Targeting Strategy That Actually Works",
    excerpt: "After managing $50M+ in Meta ad spend, here's what's working now — and what most businesses get completely wrong.",
    readTime: "11 min read",
    date: "Sep 2024",
    color: "#F72585",
  },
];

export function BlogPage() {
  const [activeCategory, setActiveCategory] = useState("All");

  const filtered = activeCategory === "All"
    ? posts
    : posts.filter((p) => p.category === activeCategory);

  return (
    <>
      <section className="pt-36 pb-20">
        <div className="container mx-auto container-padding">
          <div className="text-center mb-14">
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="flex justify-center mb-5">
              <Badge variant="default">
                <BookOpen className="w-3.5 h-3.5" />
                BizActivate Blog
              </Badge>
            </motion.div>
            <motion.h1
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-5xl md:text-6xl text-foreground mb-5 tracking-tight"
            >
              Insights That <span className="gradient-text">Activate Growth</span>
            </motion.h1>
            <motion.p
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="text-lg text-muted-foreground max-w-xl mx-auto"
            >
              Strategy, AI, design, and marketing insights from the team that activates businesses.
            </motion.p>
          </div>

          {/* Category Filter */}
          <div className="flex flex-wrap justify-center gap-2 mb-12">
            {categories.map((cat) => (
              <button
                key={cat}
                onClick={() => setActiveCategory(cat)}
                className={`px-4 py-2 rounded-full text-sm font-semibold transition-all duration-200 ${
                  activeCategory === cat
                    ? "brand-gradient text-white"
                    : "glass border border-border text-muted-foreground hover:text-foreground"
                }`}
              >
                {cat}
              </button>
            ))}
          </div>

          {/* Posts Grid */}
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filtered.map((post, i) => (
              <motion.article
                key={post.slug}
                initial={{ opacity: 0, y: 25 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.08 }}
                className="group"
              >
                <Link
                  href={`/blog/${post.slug}`}
                  className="block rounded-2xl border border-border hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 hover:shadow-xl overflow-hidden"
                >
                  {/* Header */}
                  <div
                    className="h-44 flex items-center justify-center relative"
                    style={{ background: `linear-gradient(135deg, ${post.color}15, ${post.color}05)` }}
                  >
                    <span className="font-display font-extrabold text-6xl opacity-[0.07] text-foreground">
                      {post.title.charAt(0)}
                    </span>
                    <Badge
                      variant="glass"
                      className="absolute top-4 left-4"
                      style={{ color: post.color }}
                    >
                      {post.category}
                    </Badge>
                  </div>

                  <div className="p-6">
                    <h2 className="font-display font-bold text-lg text-foreground mb-3 leading-snug group-hover:text-primary transition-colors">
                      {post.title}
                    </h2>
                    <p className="text-sm text-muted-foreground leading-relaxed mb-5">
                      {post.excerpt}
                    </p>
                    <div className="flex items-center justify-between text-xs text-muted-foreground">
                      <div className="flex items-center gap-1.5">
                        <Clock className="w-3.5 h-3.5" />
                        {post.readTime}
                      </div>
                      <span>{post.date}</span>
                    </div>
                  </div>
                </Link>
              </motion.article>
            ))}
          </div>
        </div>
      </section>
      <CTA />
    </>
  );
}
