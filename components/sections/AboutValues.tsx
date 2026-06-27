"use client";

import React from "react";
import { motion } from "framer-motion";
import { Heart, Lightbulb, Target, Rocket, Shield, Zap } from "lucide-react";

const values = [
  { icon: Target, title: "Results-Obsessed", description: "Every decision we make is anchored to one question: will this grow our client's business?", color: "#4361EE" },
  { icon: Lightbulb, title: "Creative Intelligence", description: "We combine left-brain strategy with right-brain creativity to build brands that think and feel right.", color: "#7B2FBE" },
  { icon: Zap, title: "Relentless Speed", description: "We move with urgency because every day without momentum is a day your competition gains ground.", color: "#FFB703" },
  { icon: Shield, title: "Radical Transparency", description: "No hidden fees. No vague reports. No excuses. You always know exactly what we're doing and why.", color: "#06D6A0" },
  { icon: Rocket, title: "Long-Term Partnership", description: "We don't do one-off projects. We build long-term relationships that compound in value over time.", color: "#4CC9F0" },
  { icon: Heart, title: "Genuine Care", description: "We genuinely care about the success of every business we work with. Your win is our win.", color: "#F72585" },
];

export function AboutValues() {
  return (
    <section className="section-padding bg-gradient-to-b from-transparent via-foreground/[0.02] to-transparent">
      <div className="container mx-auto container-padding">
        <div className="text-center max-w-2xl mx-auto mb-14">
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-4 tracking-tight"
          >
            What We <span className="gradient-text">Stand For</span>
          </motion.h2>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {values.map((v, i) => (
            <motion.div
              key={v.title}
              initial={{ opacity: 0, y: 25 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: i * 0.1 }}
              className="p-7 rounded-2xl glass border border-border hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 group"
            >
              <div
                className="w-12 h-12 rounded-xl flex items-center justify-center mb-5"
                style={{ backgroundColor: `${v.color}15`, border: `1px solid ${v.color}25` }}
              >
                <v.icon className="w-6 h-6" style={{ color: v.color }} strokeWidth={1.8} />
              </div>
              <h3 className="font-display font-bold text-lg text-foreground mb-2">{v.title}</h3>
              <p className="text-sm text-muted-foreground leading-relaxed">{v.description}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
