"use client";

import React from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, TrendingUp, Star } from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const cases = [
  {
    tag: "E-Commerce",
    title: "From Zero to $2.8M in 14 Months",
    client: "StyleHaven Singapore",
    description:
      "We built a premium Shopify store, ran aggressive Meta and Google campaigns, and implemented AI-powered email automation. The result: 340% ROI and a category leader in 14 months.",
    metrics: [
      { label: "Revenue Growth", value: "340%" },
      { label: "Ad ROAS", value: "8.4x" },
      { label: "Organic Traffic", value: "+280%" },
    ],
    gradient: "from-brand-blue/20 via-brand-purple/10 to-transparent",
    tag_color: "default",
    image: "/cases/ecommerce.jpg",
  },
  {
    tag: "Law Firm",
    title: "12x More Consultations in 6 Months",
    client: "Anderson Legal Group",
    description:
      "A complete brand transformation, new website, and aggressive local SEO strategy positioned them as the #1 firm in their market. From 8 to 97 monthly leads.",
    metrics: [
      { label: "Lead Increase", value: "12x" },
      { label: "Google #1 Rankings", value: "47" },
      { label: "Website Conversion", value: "8.2%" },
    ],
    gradient: "from-brand-purple/20 via-brand-pink/10 to-transparent",
    tag_color: "gold",
    image: "/cases/legal.jpg",
  },
  {
    tag: "Medical Clinic",
    title: "Fully Booked Within 8 Weeks",
    client: "Harmony Health Clinic",
    description:
      "Strategic rebrand, patient-centric website, Google Maps optimization, and AI chatbot for booking. From struggling clinic to 6-week waiting list.",
    metrics: [
      { label: "Monthly Patients", value: "+310%" },
      { label: "Google Maps Rank", value: "#1" },
      { label: "AI Chatbot Bookings", value: "67%" },
    ],
    gradient: "from-emerald-500/15 via-brand-cyan/10 to-transparent",
    tag_color: "success",
    image: "/cases/medical.jpg",
  },
];

export function CaseStudies() {
  return (
    <section className="section-padding relative overflow-hidden">
      <div className="container mx-auto container-padding">
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-14">
          <div>
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="mb-4"
            >
              <Badge variant="default">
                <TrendingUp className="w-3.5 h-3.5" />
                Proven Results
              </Badge>
            </motion.div>
            <motion.h2
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground tracking-tight"
            >
              Real Businesses.
              <br />
              <span className="gradient-text">Real Results.</span>
            </motion.h2>
          </div>
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
          >
            <Link
              href="/case-studies"
              className="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:text-primary/80 transition-colors group"
            >
              View All Case Studies
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </Link>
          </motion.div>
        </div>

        {/* Cases */}
        <div className="grid md:grid-cols-3 gap-6">
          {cases.map((study, i) => (
            <motion.div
              key={study.title}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.15 }}
              className="group"
            >
              <Link
                href={`/case-studies#${study.client.toLowerCase().replace(/\s+/g, "-")}`}
                className={`block rounded-3xl overflow-hidden border border-border hover:border-primary/30 transition-all duration-400 hover:-translate-y-2 hover:shadow-2xl hover:shadow-primary/10 bg-gradient-to-br ${study.gradient}`}
              >
                {/* Image placeholder */}
                <div className="h-48 bg-gradient-to-br from-foreground/5 to-foreground/10 relative overflow-hidden">
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="font-display font-bold text-5xl text-foreground/10">
                      {study.client.charAt(0)}
                    </span>
                  </div>
                  {/* Shimmer effect */}
                  <div className="absolute inset-0 shimmer opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
                </div>

                <div className="p-7">
                  <div className="flex items-center justify-between mb-4">
                    <Badge variant={study.tag_color as "default" | "gold" | "success"}>
                      {study.tag}
                    </Badge>
                    <div className="flex gap-0.5">
                      {[...Array(5)].map((_, j) => (
                        <Star key={j} className="w-3.5 h-3.5 fill-amber-400 text-amber-400" />
                      ))}
                    </div>
                  </div>

                  <h3 className="font-display font-bold text-xl text-foreground mb-2 leading-tight">
                    {study.title}
                  </h3>
                  <p className="text-xs text-primary font-semibold mb-4 uppercase tracking-wide">
                    {study.client}
                  </p>
                  <p className="text-sm text-muted-foreground leading-relaxed mb-6">
                    {study.description}
                  </p>

                  {/* Metrics */}
                  <div className="grid grid-cols-3 gap-3 pt-5 border-t border-border">
                    {study.metrics.map((m) => (
                      <div key={m.label} className="text-center">
                        <div className="font-display font-bold text-lg gradient-text">
                          {m.value}
                        </div>
                        <div className="text-xs text-muted-foreground mt-0.5 leading-tight">
                          {m.label}
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </Link>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
