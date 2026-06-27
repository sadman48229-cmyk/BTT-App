"use client";

import React from "react";
import { motion } from "framer-motion";

const logos = [
  "TechCorp", "NexaGroup", "BuildRight", "HealthFirst", "LegalPros",
  "EstatePro", "CloudScale", "FoodieApp", "GrowthLab", "StartupX",
  "VentureCo", "DigitalEdge", "SmartBuild", "MedCore", "LawVault"
];

const stats = [
  { value: "200+", label: "Businesses Activated" },
  { value: "$50M+", label: "Revenue Generated" },
  { value: "98%", label: "Client Satisfaction" },
  { value: "7+", label: "Countries Served" },
];

export function SocialProof() {
  return (
    <section className="py-20 border-y border-border overflow-hidden">
      <div className="container mx-auto container-padding mb-12">
        <motion.p
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          className="text-center text-sm font-semibold text-muted-foreground uppercase tracking-widest"
        >
          Trusted by ambitious founders and growing businesses worldwide
        </motion.p>
      </div>

      {/* Logo Marquee */}
      <div className="relative">
        <div className="flex overflow-hidden">
          <div className="flex gap-12 animate-marquee whitespace-nowrap">
            {[...logos, ...logos].map((logo, i) => (
              <div
                key={`${logo}-${i}`}
                className="flex-shrink-0 flex items-center justify-center px-6 py-3 rounded-xl glass border border-white/10 min-w-[140px] opacity-60 hover:opacity-100 transition-opacity duration-300"
              >
                <span className="font-display font-bold text-sm text-muted-foreground">
                  {logo}
                </span>
              </div>
            ))}
          </div>
        </div>
        {/* Fade edges */}
        <div className="absolute inset-y-0 left-0 w-32 bg-gradient-to-r from-background to-transparent pointer-events-none z-10" />
        <div className="absolute inset-y-0 right-0 w-32 bg-gradient-to-l from-background to-transparent pointer-events-none z-10" />
      </div>

      {/* Stats Row */}
      <div className="container mx-auto container-padding mt-16">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6 md:gap-0 md:divide-x divide-border">
          {stats.map((stat, i) => (
            <motion.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.1 }}
              className="text-center px-6 py-4"
            >
              <div className="font-display font-extrabold text-4xl md:text-5xl gradient-text mb-1">
                {stat.value}
              </div>
              <div className="text-sm text-muted-foreground font-medium">
                {stat.label}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
