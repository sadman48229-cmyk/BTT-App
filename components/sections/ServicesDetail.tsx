"use client";

import React from "react";
import { motion } from "framer-motion";
import { Globe, Palette, Search, Megaphone, Bot, BarChart3, Layers, Users, Target, Zap } from "lucide-react";

const serviceGroups = [
  {
    id: "websites",
    icon: Globe,
    color: "#4361EE",
    category: "Web Development",
    title: "Premium Website Development",
    description:
      "Your website is your most powerful salesperson. We build stunning, blazing-fast websites that convert visitors into customers and communicate premium quality at every pixel.",
    includes: [
      "Custom Next.js & React development",
      "Conversion-optimized UX/UI design",
      "Mobile-first responsive design",
      "Core Web Vitals optimization",
      "CMS integration (Sanity, Contentful)",
      "API & third-party integrations",
      "E-commerce development",
      "Ongoing maintenance & support",
    ],
  },
  {
    id: "brand",
    icon: Palette,
    color: "#7B2FBE",
    category: "Design & Branding",
    title: "Brand Identity & UI/UX Design",
    description:
      "A powerful brand isn't just a logo — it's a complete strategic identity system that commands attention, builds trust, and makes your business unforgettable.",
    includes: [
      "Brand strategy & positioning",
      "Logo design & visual identity",
      "Color system & typography",
      "Brand guidelines & style guide",
      "UI/UX design for web & mobile",
      "Icon & illustration design",
      "Pitch decks & presentations",
      "Print & marketing materials",
    ],
  },
  {
    id: "seo",
    icon: Search,
    color: "#06D6A0",
    category: "SEO",
    title: "SEO & Local SEO",
    description:
      "Rank at the top of Google for your most valuable keywords and dominate local search. We build organic traffic that compounds month over month.",
    includes: [
      "Technical SEO audit & optimization",
      "Keyword research & strategy",
      "On-page optimization",
      "Link building campaigns",
      "Local SEO & Google Maps",
      "Content strategy & creation",
      "Schema markup implementation",
      "Monthly performance reporting",
    ],
  },
  {
    id: "ads",
    icon: Megaphone,
    color: "#FFB703",
    category: "Paid Advertising",
    title: "Google & Meta Advertising",
    description:
      "Data-driven paid advertising that maximizes every dollar of ad spend. We design, launch, and optimize campaigns that consistently deliver measurable ROI.",
    includes: [
      "Google Search & Display campaigns",
      "Meta (Facebook & Instagram) Ads",
      "YouTube advertising",
      "Landing page design & optimization",
      "A/B testing & creative iterations",
      "Audience research & targeting",
      "Budget management & forecasting",
      "Weekly performance dashboards",
    ],
  },
  {
    id: "ai",
    icon: Bot,
    color: "#4CC9F0",
    category: "AI & Automation",
    title: "AI Automation & Systems",
    description:
      "Deploy intelligent AI systems that work 24/7, capture every lead, automate repetitive tasks, and give your business a competitive edge that scales.",
    includes: [
      "AI chatbot development (GPT-4)",
      "CRM automation & setup",
      "Email marketing automation",
      "Lead scoring & nurturing",
      "Workflow automation (Make/Zapier)",
      "Customer service automation",
      "AI content generation systems",
      "Analytics & performance tracking",
    ],
  },
  {
    id: "strategy",
    icon: Target,
    color: "#F72585",
    category: "Business Strategy",
    title: "Business Growth Strategy",
    description:
      "Strategic advisory that goes beyond marketing. We help you identify your biggest growth levers, build competitive moats, and execute with precision.",
    includes: [
      "Market analysis & research",
      "Competitive intelligence",
      "Growth roadmap development",
      "Revenue model optimization",
      "Partnership strategy",
      "KPI framework setup",
      "Quarterly strategy reviews",
      "Executive advisory sessions",
    ],
  },
];

export function ServicesDetail() {
  return (
    <section className="pb-20">
      <div className="container mx-auto container-padding">
        <div className="flex flex-col gap-16">
          {serviceGroups.map((service, i) => (
            <motion.div
              key={service.id}
              id={service.id}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className={`grid lg:grid-cols-2 gap-12 items-center ${
                i % 2 === 1 ? "lg:grid-flow-col-dense" : ""
              }`}
            >
              <div className={i % 2 === 1 ? "lg:order-2" : ""}>
                <span className="text-xs font-bold uppercase tracking-widest" style={{ color: service.color }}>
                  {service.category}
                </span>
                <h2 className="font-display font-extrabold text-3xl md:text-4xl text-foreground mt-2 mb-4 tracking-tight">
                  {service.title}
                </h2>
                <p className="text-muted-foreground leading-relaxed mb-8 text-lg">
                  {service.description}
                </p>
                <div className="grid sm:grid-cols-2 gap-3">
                  {service.includes.map((item) => (
                    <div key={item} className="flex items-start gap-3">
                      <span
                        className="w-5 h-5 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5 text-xs font-bold text-white"
                        style={{ backgroundColor: service.color }}
                      >
                        ✓
                      </span>
                      <span className="text-sm text-muted-foreground">{item}</span>
                    </div>
                  ))}
                </div>
              </div>

              <div className={`${i % 2 === 1 ? "lg:order-1" : ""}`}>
                <div
                  className="rounded-3xl p-12 flex items-center justify-center aspect-square max-w-sm mx-auto relative overflow-hidden"
                  style={{
                    background: `linear-gradient(135deg, ${service.color}15, ${service.color}05)`,
                    border: `1px solid ${service.color}20`,
                  }}
                >
                  <div
                    className="absolute inset-0"
                    style={{
                      background: `radial-gradient(circle at 30% 30%, ${service.color}20, transparent 70%)`,
                    }}
                  />
                  <service.icon
                    className="w-24 h-24 relative z-10"
                    style={{ color: service.color, opacity: 0.7 }}
                    strokeWidth={1.2}
                  />
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
