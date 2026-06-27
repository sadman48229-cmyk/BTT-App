"use client";

import React from "react";
import { motion } from "framer-motion";
import { Linkedin, Twitter } from "lucide-react";

const team = [
  { name: "Alex Rivera", role: "Founder & CEO", bio: "10+ years building digital businesses across Asia-Pacific. Previously at Google and McKinsey.", initials: "AR", color: "#4361EE" },
  { name: "Sofia Laurent", role: "Chief Design Officer", bio: "Award-winning UX designer who led design at 3 unicorn startups before founding her own studio.", initials: "SL", color: "#F72585" },
  { name: "James Woo", role: "Head of Growth", bio: "Performance marketing expert who has managed $50M+ in ad spend across Google, Meta, and TikTok.", initials: "JW", color: "#4CC9F0" },
  { name: "Priya Nair", role: "Head of AI & Automation", bio: "AI engineer and automation specialist who built systems for Fortune 500 companies.", initials: "PN", color: "#7B2FBE" },
  { name: "Marcus Chen", role: "Head of Technology", bio: "Full-stack architect specializing in high-performance Next.js applications and scalable cloud systems.", initials: "MC", color: "#06D6A0" },
  { name: "Emma Thompson", role: "Head of Strategy", bio: "Former management consultant turned brand strategist with a track record of market-defining launches.", initials: "ET", color: "#FFB703" },
];

export function AboutTeam() {
  return (
    <section className="section-padding">
      <div className="container mx-auto container-padding">
        <div className="text-center max-w-2xl mx-auto mb-14">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-4 tracking-tight"
          >
            The <span className="gradient-text">Activation Team</span>
          </motion.h2>
          <p className="text-muted-foreground text-lg">
            Strategists, designers, engineers, and growth experts united by one mission.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {team.map((member, i) => (
            <motion.div
              key={member.name}
              initial={{ opacity: 0, y: 25 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: i * 0.1 }}
              className="glass rounded-2xl border border-border p-6 hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 group"
            >
              <div className="flex items-start gap-4 mb-4">
                <div
                  className="w-14 h-14 rounded-2xl flex items-center justify-center font-display font-bold text-white text-lg flex-shrink-0"
                  style={{ backgroundColor: member.color, boxShadow: `0 8px 24px ${member.color}30` }}
                >
                  {member.initials}
                </div>
                <div>
                  <h3 className="font-display font-bold text-foreground">{member.name}</h3>
                  <p className="text-sm text-primary font-semibold">{member.role}</p>
                </div>
              </div>
              <p className="text-sm text-muted-foreground leading-relaxed mb-4">{member.bio}</p>
              <div className="flex gap-2">
                <button className="w-8 h-8 rounded-lg glass border border-border flex items-center justify-center text-muted-foreground hover:text-primary hover:border-primary/30 transition-all">
                  <Linkedin className="w-3.5 h-3.5" />
                </button>
                <button className="w-8 h-8 rounded-lg glass border border-border flex items-center justify-center text-muted-foreground hover:text-primary hover:border-primary/30 transition-all">
                  <Twitter className="w-3.5 h-3.5" />
                </button>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
