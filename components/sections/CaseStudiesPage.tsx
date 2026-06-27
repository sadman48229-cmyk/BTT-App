"use client";

import React from "react";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { TrendingUp, Star, ArrowRight } from "lucide-react";
import Link from "next/link";

const cases = [
  {
    id: "stylehaven",
    tag: "E-Commerce",
    client: "StyleHaven Asia",
    location: "Singapore",
    title: "From $0 to $2.8M Revenue in 14 Months",
    challenge: "StyleHaven launched with zero brand recognition and a basic Shopify template in a saturated fashion market.",
    solution: "We built a premium e-commerce experience, implemented an aggressive Meta and Google advertising strategy, and deployed AI-powered email automation to maximize customer lifetime value.",
    results: [
      { metric: "Revenue Growth", value: "340%", period: "Year 1" },
      { metric: "Ad ROAS", value: "8.4x", period: "Average" },
      { metric: "Email Revenue", value: "31%", period: "of Total" },
      { metric: "Customer LTV", value: "+180%", period: "vs. benchmark" },
    ],
    services: ["E-Commerce Development", "Meta Ads", "Google Ads", "Email Automation", "Brand Identity"],
    color: "#F72585",
  },
  {
    id: "anderson-legal",
    tag: "Law Firm",
    client: "Anderson Legal Group",
    location: "United States",
    title: "12x More Consultations Through Digital Authority",
    challenge: "Anderson Legal had expertise but lacked online visibility. They were losing potential clients to less qualified competitors who ranked higher on Google.",
    solution: "Complete brand transformation, a new authority website optimized for high-intent legal keywords, and a comprehensive local SEO strategy targeting their primary practice areas.",
    results: [
      { metric: "Monthly Leads", value: "12x", period: "Increase" },
      { metric: "#1 Google Rankings", value: "47", period: "Keywords" },
      { metric: "Website Conversion", value: "8.2%", period: "Rate" },
      { metric: "Cost Per Lead", value: "-64%", period: "vs. Before" },
    ],
    services: ["Website Development", "Brand Identity", "SEO", "Google Ads", "Content Marketing"],
    color: "#7B2FBE",
  },
  {
    id: "harmony-health",
    tag: "Healthcare",
    client: "Harmony Health Clinic",
    location: "Australia",
    title: "Fully Booked Clinic in 8 Weeks",
    challenge: "A new medical clinic struggling to attract patients in a competitive local market with no digital presence.",
    solution: "Patient-centric website design, Google Maps optimization, local SEO, and an AI chatbot that qualifies and books appointments automatically 24/7.",
    results: [
      { metric: "Monthly Patients", value: "+310%", period: "Growth" },
      { metric: "Google Maps", value: "#1", period: "Ranking" },
      { metric: "AI Bookings", value: "67%", period: "Automated" },
      { metric: "Waiting List", value: "6 weeks", period: "In 8 weeks" },
    ],
    services: ["Website Design", "Local SEO", "AI Chatbot", "Google Maps", "Brand Identity"],
    color: "#06D6A0",
  },
];

export function CaseStudiesPage() {
  return (
    <section className="pt-36 pb-20">
      <div className="container mx-auto container-padding">
        <div className="text-center mb-16">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="flex justify-center mb-5">
            <Badge variant="default">
              <TrendingUp className="w-3.5 h-3.5" />
              Proven Results
            </Badge>
          </motion.div>
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-5xl md:text-6xl text-foreground mb-5 tracking-tight"
          >
            Stories of <span className="gradient-text">Transformation</span>
          </motion.h1>
          <motion.p
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground max-w-xl mx-auto"
          >
            These aren&apos;t just projects. These are businesses that transformed their futures with BizActivate.
          </motion.p>
        </div>

        <div className="flex flex-col gap-20">
          {cases.map((study, i) => (
            <motion.article
              key={study.id}
              id={study.id}
              initial={{ opacity: 0, y: 40 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.6 }}
              className="glass rounded-3xl border border-border overflow-hidden"
            >
              {/* Header band */}
              <div className="h-1.5" style={{ background: `linear-gradient(90deg, ${study.color}, transparent)` }} />

              <div className="p-8 md:p-12">
                <div className="flex flex-wrap items-start justify-between gap-4 mb-8">
                  <div>
                    <Badge variant="default" className="mb-3">{study.tag}</Badge>
                    <h2 className="font-display font-extrabold text-3xl md:text-4xl text-foreground tracking-tight">
                      {study.title}
                    </h2>
                    <p className="text-primary font-semibold mt-1">{study.client} · {study.location}</p>
                  </div>
                  <div className="flex gap-1">
                    {[...Array(5)].map((_, j) => (
                      <Star key={j} className="w-4 h-4 fill-amber-400 text-amber-400" />
                    ))}
                  </div>
                </div>

                <div className="grid md:grid-cols-2 gap-10 mb-10">
                  <div>
                    <h3 className="font-semibold text-foreground mb-2">The Challenge</h3>
                    <p className="text-muted-foreground leading-relaxed">{study.challenge}</p>
                  </div>
                  <div>
                    <h3 className="font-semibold text-foreground mb-2">Our Solution</h3>
                    <p className="text-muted-foreground leading-relaxed">{study.solution}</p>
                  </div>
                </div>

                {/* Results */}
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                  {study.results.map((result) => (
                    <div
                      key={result.metric}
                      className="text-center p-5 rounded-2xl border border-border"
                      style={{ background: `${study.color}08` }}
                    >
                      <div className="font-display font-extrabold text-2xl md:text-3xl" style={{ color: study.color }}>
                        {result.value}
                      </div>
                      <div className="text-xs font-semibold text-foreground mt-1">{result.metric}</div>
                      <div className="text-xs text-muted-foreground">{result.period}</div>
                    </div>
                  ))}
                </div>

                <div className="flex flex-wrap items-center justify-between gap-4">
                  <div className="flex flex-wrap gap-2">
                    {study.services.map((s) => (
                      <span key={s} className="text-xs px-3 py-1.5 rounded-full bg-foreground/5 text-muted-foreground border border-border">
                        {s}
                      </span>
                    ))}
                  </div>
                  <Link
                    href="/book-call"
                    className="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:underline group"
                  >
                    Get Similar Results
                    <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                  </Link>
                </div>
              </div>
            </motion.article>
          ))}
        </div>
      </div>
    </section>
  );
}
