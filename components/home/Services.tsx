"use client";

import React, { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import {
  Globe, Palette, Search, Megaphone, Bot, BarChart3,
  Layers, Zap, Users, ArrowRight, Target, Cpu
} from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const services = [
  {
    icon: Globe,
    category: "Web",
    title: "Premium Website Development",
    description:
      "We build fast, beautiful, conversion-optimized websites that work as your best salesperson — 24/7, globally.",
    features: ["Next.js & React", "Mobile-first design", "Core Web Vitals optimized", "CMS integration"],
    color: "from-brand-blue/20 to-brand-blue/5",
    iconColor: "text-brand-blue",
    href: "/services#websites",
  },
  {
    icon: Palette,
    category: "Design",
    title: "Brand Identity & UI/UX",
    description:
      "Distinctive brand identities and user experiences that make your business unforgettable and instantly credible.",
    features: ["Logo & visual system", "Design systems", "User research", "Conversion-focused UX"],
    color: "from-brand-purple/20 to-brand-purple/5",
    iconColor: "text-brand-purple",
    href: "/services#brand",
  },
  {
    icon: Search,
    category: "SEO",
    title: "SEO & Local SEO",
    description:
      "Dominate search results and attract high-intent customers ready to buy, from Google to Maps to AI search.",
    features: ["Technical SEO", "Content strategy", "Local citations", "Rank tracking"],
    color: "from-emerald-500/20 to-emerald-500/5",
    iconColor: "text-emerald-400",
    href: "/services#seo",
  },
  {
    icon: Megaphone,
    category: "Paid Ads",
    title: "Google & Meta Advertising",
    description:
      "Precision-targeted advertising campaigns that turn ad spend into measurable revenue — with zero budget waste.",
    features: ["Google Search & Display", "Meta & Instagram", "A/B testing", "ROAS tracking"],
    color: "from-amber-500/20 to-amber-500/5",
    iconColor: "text-amber-400",
    href: "/services#ads",
  },
  {
    icon: Bot,
    category: "AI",
    title: "AI Automation & Chatbots",
    description:
      "Deploy intelligent AI agents that automate lead capture, customer service, and business operations at scale.",
    features: ["AI chatbots", "Workflow automation", "CRM integration", "24/7 AI support"],
    color: "from-brand-cyan/20 to-brand-cyan/5",
    iconColor: "text-brand-cyan",
    href: "/services#ai",
  },
  {
    icon: BarChart3,
    category: "Growth",
    title: "Business Growth Strategy",
    description:
      "Data-driven growth strategies that identify opportunities, eliminate bottlenecks, and accelerate scale.",
    features: ["Market analysis", "Growth roadmap", "KPI frameworks", "Competitive intelligence"],
    color: "from-brand-pink/20 to-brand-pink/5",
    iconColor: "text-brand-pink",
    href: "/services#strategy",
  },
  {
    icon: Layers,
    category: "Content",
    title: "Content Marketing",
    description:
      "Strategic content that builds authority, drives organic traffic, and nurtures leads through every stage.",
    features: ["Blog & articles", "Video production", "Social media", "Email marketing"],
    color: "from-violet-500/20 to-violet-500/5",
    iconColor: "text-violet-400",
    href: "/services#content",
  },
  {
    icon: Users,
    category: "CRM",
    title: "CRM & Business Systems",
    description:
      "Implement powerful CRM and business systems that give you full visibility and control over your pipeline.",
    features: ["CRM setup", "Pipeline automation", "Sales workflows", "Team dashboards"],
    color: "from-orange-500/20 to-orange-500/5",
    iconColor: "text-orange-400",
    href: "/services#crm",
  },
];

export function Services() {
  const [hoveredIndex, setHoveredIndex] = useState<number | null>(null);

  return (
    <section className="section-padding" id="services">
      <div className="container mx-auto container-padding">
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="flex justify-center mb-4"
          >
            <Badge variant="default">
              <Zap className="w-3.5 h-3.5" />
              Full-Service Activation
            </Badge>
          </motion.div>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-5 tracking-tight"
          >
            Everything You Need to{" "}
            <span className="gradient-text">Dominate</span>
          </motion.h2>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground"
          >
            One agency. Every capability. Zero compromises. We handle the full
            stack of your digital presence and business growth.
          </motion.p>
        </div>

        {/* Services Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-5">
          {services.map((service, i) => (
            <motion.div
              key={service.title}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.07 }}
              onMouseEnter={() => setHoveredIndex(i)}
              onMouseLeave={() => setHoveredIndex(null)}
            >
              <Link
                href={service.href}
                className={`block p-6 rounded-2xl border border-border hover:border-primary/30 transition-all duration-400 h-full bg-gradient-to-br ${service.color} hover:shadow-xl hover:shadow-primary/10 hover:-translate-y-1 group`}
              >
                <div className="mb-5">
                  <span className="text-xs font-semibold text-muted-foreground uppercase tracking-widest">
                    {service.category}
                  </span>
                  <div
                    className={`w-11 h-11 rounded-xl bg-background/50 flex items-center justify-center mt-3 mb-4 ${service.iconColor} group-hover:scale-110 transition-transform duration-300`}
                  >
                    <service.icon className="w-5.5 h-5.5" strokeWidth={1.8} />
                  </div>
                  <h3 className="font-display font-bold text-lg text-foreground mb-2 leading-tight">
                    {service.title}
                  </h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">
                    {service.description}
                  </p>
                </div>

                <ul className="flex flex-col gap-1.5 mb-5">
                  {service.features.map((feature) => (
                    <li
                      key={feature}
                      className="flex items-center gap-2 text-xs text-muted-foreground"
                    >
                      <span className={`w-1 h-1 rounded-full bg-current ${service.iconColor} flex-shrink-0`} />
                      {feature}
                    </li>
                  ))}
                </ul>

                <span
                  className={`flex items-center gap-1.5 text-sm font-semibold ${service.iconColor} group-hover:gap-2.5 transition-all duration-200`}
                >
                  Learn More
                  <ArrowRight className="w-4 h-4" />
                </span>
              </Link>
            </motion.div>
          ))}
        </div>

        {/* Bottom CTA */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center mt-12"
        >
          <Link
            href="/services"
            className="inline-flex items-center gap-2 px-8 py-4 rounded-xl border-2 border-border text-foreground font-semibold hover:border-primary hover:text-primary transition-all duration-300"
          >
            <Cpu className="w-4 h-4" />
            View All Services
            <ArrowRight className="w-4 h-4" />
          </Link>
        </motion.div>
      </div>
    </section>
  );
}
