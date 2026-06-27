"use client";

import React, { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import {
  Building2, Stethoscope, Scale, Home, UtensilsCrossed,
  Users, ShoppingBag, Briefcase, Globe, HardHat, ArrowRight
} from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const industries = [
  {
    icon: HardHat,
    name: "Construction",
    description: "Generate more local leads and build a trusted brand that wins contracts.",
    color: "#FFB703",
  },
  {
    icon: Stethoscope,
    name: "Medical Clinics",
    description: "Attract more patients with a professional digital presence and local SEO.",
    color: "#4CC9F0",
  },
  {
    icon: Scale,
    name: "Law Firms",
    description: "Establish authority and generate qualified legal consultations online.",
    color: "#7B2FBE",
  },
  {
    icon: Home,
    name: "Real Estate",
    description: "Showcase listings and convert buyers with premium property websites.",
    color: "#4361EE",
  },
  {
    icon: UtensilsCrossed,
    name: "Restaurants",
    description: "Drive foot traffic and online orders with irresistible digital presence.",
    color: "#F72585",
  },
  {
    icon: Users,
    name: "Coaches & Consultants",
    description: "Build your personal brand and fill your calendar with premium clients.",
    color: "#06D6A0",
  },
  {
    icon: ShoppingBag,
    name: "E-Commerce",
    description: "Scale your online store with conversion optimization and paid traffic.",
    color: "#FFB703",
  },
  {
    icon: Briefcase,
    name: "Startups",
    description: "Launch faster, validate ideas, and build the brand investors trust.",
    color: "#4CC9F0",
  },
  {
    icon: Building2,
    name: "Agencies",
    description: "White-label our expertise to deliver world-class work to your clients.",
    color: "#7B2FBE",
  },
  {
    icon: Globe,
    name: "International Brands",
    description: "Enter new markets with localized strategy and multi-market execution.",
    color: "#4361EE",
  },
];

export function Industries() {
  const [hovered, setHovered] = useState<number | null>(null);

  return (
    <section className="section-padding bg-gradient-to-b from-transparent via-foreground/[0.02] to-transparent">
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
              <Globe className="w-3.5 h-3.5" />
              Industries We Serve
            </Badge>
          </motion.div>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-5 tracking-tight"
          >
            We Activate Every{" "}
            <span className="gradient-text">Industry</span>
          </motion.h2>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground"
          >
            From local clinics to global enterprises, we have deep expertise
            across industries that demand real results.
          </motion.p>
        </div>

        {/* Industry Grid */}
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-3 md:gap-4">
          {industries.map((industry, i) => (
            <motion.div
              key={industry.name}
              initial={{ opacity: 0, scale: 0.95 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              transition={{ duration: 0.4, delay: i * 0.06 }}
              onMouseEnter={() => setHovered(i)}
              onMouseLeave={() => setHovered(null)}
              className="relative group"
            >
              <Link
                href={`/industries#${industry.name.toLowerCase().replace(/\s+/g, "-")}`}
                className="block p-5 rounded-2xl glass border border-border hover:border-white/20 transition-all duration-300 hover:-translate-y-1 hover:shadow-xl text-center"
                style={{
                  boxShadow:
                    hovered === i
                      ? `0 20px 40px ${industry.color}15`
                      : undefined,
                  borderColor: hovered === i ? `${industry.color}30` : undefined,
                }}
              >
                <div
                  className="w-12 h-12 rounded-xl mx-auto mb-3 flex items-center justify-center transition-all duration-300"
                  style={{
                    backgroundColor:
                      hovered === i
                        ? `${industry.color}20`
                        : "hsl(var(--foreground) / 0.05)",
                  }}
                >
                  <industry.icon
                    className="w-6 h-6 transition-colors duration-300"
                    strokeWidth={1.8}
                    style={{ color: hovered === i ? industry.color : undefined }}
                  />
                </div>
                <h3 className="font-display font-semibold text-sm text-foreground mb-1.5">
                  {industry.name}
                </h3>
                <p className="text-xs text-muted-foreground leading-relaxed hidden md:block">
                  {industry.description}
                </p>
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
            href="/industries"
            className="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:text-primary/80 transition-colors group"
          >
            View All Industries
            <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
          </Link>
        </motion.div>
      </div>
    </section>
  );
}
