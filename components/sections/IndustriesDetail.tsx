"use client";

import React from "react";
import { motion } from "framer-motion";

const industryDetails = [
  {
    id: "construction",
    name: "Construction Companies",
    tagline: "Build Your Digital Foundation",
    description:
      "Win more contracts with a professional online presence. We help construction companies generate local leads, showcase past projects, and build the credibility that wins high-value bids.",
    wins: ["More project inquiries", "Stronger local SEO presence", "Professional project portfolio", "Automated lead follow-up"],
    color: "#FFB703",
  },
  {
    id: "medical-clinics",
    name: "Medical Clinics",
    tagline: "Fill Your Appointment Calendar",
    description:
      "Attract more patients, build doctor credibility, and automate your booking process. We specialize in HIPAA-compliant digital solutions for healthcare practices.",
    wins: ["More patient bookings", "Google Maps #1 visibility", "AI booking automation", "Patient trust building"],
    color: "#4CC9F0",
  },
  {
    id: "law-firms",
    name: "Law Firms",
    tagline: "Command Legal Authority Online",
    description:
      "Establish your firm as the premier choice in your practice area. We build authority websites, generate consultation requests, and build the reputation that attracts premium clients.",
    wins: ["More qualified consultations", "Thought leadership content", "Local SEO dominance", "Reputation management"],
    color: "#7B2FBE",
  },
  {
    id: "real-estate",
    name: "Real Estate Companies",
    tagline: "Sell More. Faster.",
    description:
      "Premium property websites, lead generation systems, and marketing automation that keeps buyers and sellers coming back. We help agents and agencies dominate their local market.",
    wins: ["Property showcase websites", "Buyer/seller lead generation", "Email nurture sequences", "Virtual tour integration"],
    color: "#4361EE",
  },
];

export function IndustriesDetail() {
  return (
    <section className="pb-20 section-padding">
      <div className="container mx-auto container-padding">
        <div className="text-center mb-16">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="font-display font-extrabold text-4xl md:text-5xl text-foreground tracking-tight"
          >
            Deep <span className="gradient-text">Industry Expertise</span>
          </motion.h2>
        </div>
        <div className="grid md:grid-cols-2 gap-6">
          {industryDetails.map((industry, i) => (
            <motion.div
              key={industry.id}
              id={industry.id}
              initial={{ opacity: 0, y: 25 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: i * 0.1 }}
              className="p-8 rounded-3xl glass border border-border hover:border-primary/20 transition-all duration-300"
              style={{ borderTop: `2px solid ${industry.color}` }}
            >
              <p className="text-sm font-bold uppercase tracking-widest mb-2" style={{ color: industry.color }}>
                {industry.tagline}
              </p>
              <h3 className="font-display font-bold text-2xl text-foreground mb-3">{industry.name}</h3>
              <p className="text-muted-foreground leading-relaxed mb-6">{industry.description}</p>
              <div className="grid grid-cols-2 gap-2">
                {industry.wins.map((win) => (
                  <div key={win} className="flex items-center gap-2 text-sm text-muted-foreground">
                    <span className="w-1.5 h-1.5 rounded-full flex-shrink-0" style={{ backgroundColor: industry.color }} />
                    {win}
                  </div>
                ))}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
