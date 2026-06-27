"use client";

import React from "react";
import { motion } from "framer-motion";
import { Zap, TrendingUp, Shield, Cpu } from "lucide-react";

const pillars = [
  {
    icon: Zap,
    title: "Speed Without Compromise",
    description:
      "We move fast because market timing matters. But speed never compromises quality — our systems ensure both.",
    color: "text-amber-400",
    bg: "bg-amber-400/10 border-amber-400/20",
  },
  {
    icon: TrendingUp,
    title: "Results Over Vanity",
    description:
      "We don't count clicks. We count revenue. Every decision is anchored to what actually grows your business.",
    color: "text-emerald-400",
    bg: "bg-emerald-400/10 border-emerald-400/20",
  },
  {
    icon: Shield,
    title: "Strategy Before Tactics",
    description:
      "Most agencies jump to execution. We start with strategy — because the right plan executed correctly beats any tactic.",
    color: "text-brand-blue",
    bg: "bg-brand-blue/10 border-brand-blue/20",
  },
  {
    icon: Cpu,
    title: "AI-Powered by Default",
    description:
      "Every engagement is enhanced by AI — from research to automation. It's not a feature. It's how we operate.",
    color: "text-brand-cyan",
    bg: "bg-brand-cyan/10 border-brand-cyan/20",
  },
];

export function Philosophy() {
  return (
    <section className="section-padding relative">
      <div className="container mx-auto container-padding">
        <div className="grid lg:grid-cols-2 gap-16 items-center">
          {/* Left Content */}
          <div>
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="text-sm font-semibold text-primary uppercase tracking-widest mb-4"
            >
              Our Philosophy
            </motion.p>
            <motion.h2
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-6 tracking-tight leading-[1.05]"
            >
              The New Standard
              <br />
              for Business{" "}
              <span className="gradient-text">Growth</span>
            </motion.h2>
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
              className="text-lg text-muted-foreground leading-relaxed mb-8"
            >
              The world has changed. Your customers are online. Your competitors
              are scaling with AI. Traditional agencies sell deliverables. We
              deliver outcomes.
            </motion.p>
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.3 }}
              className="text-lg text-muted-foreground leading-relaxed mb-10"
            >
              BizActivate was born from a simple belief:{" "}
              <span className="text-foreground font-medium">
                every ambitious business deserves a team that thinks like a
                partner, not a vendor.
              </span>{" "}
              We embed into your growth journey and don&apos;t leave until you win.
            </motion.p>

            {/* Quote Block */}
            <motion.blockquote
              initial={{ opacity: 0, x: -20 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.4 }}
              className="relative pl-6 border-l-2 border-primary"
            >
              <p className="text-lg font-medium text-foreground italic leading-relaxed">
                &ldquo;We don&apos;t just build digital assets. We build the systems,
                strategy, and momentum that turn businesses into category
                leaders.&rdquo;
              </p>
              <footer className="mt-4 text-sm text-muted-foreground">
                — BizActivate Founding Team
              </footer>
            </motion.blockquote>
          </div>

          {/* Right — Pillars */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {pillars.map((pillar, i) => (
              <motion.div
                key={pillar.title}
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5, delay: i * 0.1 }}
                className="p-6 rounded-2xl glass border border-border hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 hover:shadow-lg"
              >
                <div
                  className={`w-12 h-12 rounded-xl flex items-center justify-center mb-4 border ${pillar.bg}`}
                >
                  <pillar.icon className={`w-6 h-6 ${pillar.color}`} strokeWidth={1.8} />
                </div>
                <h3 className="font-display font-bold text-base text-foreground mb-2">
                  {pillar.title}
                </h3>
                <p className="text-sm text-muted-foreground leading-relaxed">
                  {pillar.description}
                </p>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
