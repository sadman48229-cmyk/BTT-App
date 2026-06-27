"use client";

import React from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, Calendar, MessageCircle } from "lucide-react";

export function CTA() {
  return (
    <section className="py-24 md:py-36 relative overflow-hidden">
      {/* Background */}
      <div className="absolute inset-0 brand-gradient opacity-10 pointer-events-none" />
      <div className="absolute inset-0 pointer-events-none">
        <div className="orb orb-blue absolute w-[800px] h-[800px] left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 opacity-20" />
      </div>
      <div
        className="absolute inset-0 opacity-[0.03]"
        style={{
          backgroundImage: `linear-gradient(hsl(var(--foreground)) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--foreground)) 1px, transparent 1px)`,
          backgroundSize: "64px 64px",
        }}
      />

      <div className="container mx-auto container-padding relative z-10">
        <div className="max-w-4xl mx-auto text-center">
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-sm font-semibold text-primary uppercase tracking-widest mb-6"
          >
            The Next Step is Yours
          </motion.p>

          <motion.h2
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-5xl md:text-6xl lg:text-7xl text-foreground tracking-tight leading-[1.05] mb-8"
          >
            Ready to{" "}
            <span
              className="gradient-text"
              style={{
                backgroundImage:
                  "linear-gradient(135deg, #4CC9F0 0%, #4361EE 40%, #7B2FBE 100%)",
                WebkitBackgroundClip: "text",
                WebkitTextFillColor: "transparent",
              }}
            >
              Activate
            </span>
            <br />
            Your Business?
          </motion.h2>

          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg md:text-xl text-muted-foreground max-w-2xl mx-auto mb-12 leading-relaxed"
          >
            Book a free 45-minute Strategy Call with our team. We&apos;ll analyse
            your business, identify your biggest growth opportunities, and give
            you a clear roadmap — no obligation, no sales pressure.
          </motion.p>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.3 }}
            className="flex flex-col sm:flex-row items-center justify-center gap-4"
          >
            <Link
              href="/book-call"
              className="flex items-center gap-2.5 px-8 py-4 rounded-xl brand-gradient text-white font-bold text-base hover:shadow-2xl hover:shadow-brand-blue/30 hover:scale-[1.02] transition-all duration-300 group w-full sm:w-auto justify-center"
            >
              <Calendar className="w-5 h-5" />
              Book Free Strategy Call
              <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
            </Link>
            <Link
              href="/contact"
              className="flex items-center gap-2.5 px-8 py-4 rounded-xl glass border-2 border-border text-foreground font-bold text-base hover:border-primary hover:text-primary transition-all duration-300 w-full sm:w-auto justify-center"
            >
              <MessageCircle className="w-5 h-5" />
              Send Us a Message
            </Link>
          </motion.div>

          {/* Trust indicators */}
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            transition={{ delay: 0.5 }}
            className="flex flex-wrap items-center justify-center gap-6 mt-12 text-xs text-muted-foreground"
          >
            <span className="flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400" />
              Free 45-minute strategy call
            </span>
            <span className="flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400" />
              No commitment required
            </span>
            <span className="flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400" />
              Response within 24 hours
            </span>
            <span className="flex items-center gap-2">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400" />
              30-day money-back guarantee
            </span>
          </motion.div>
        </div>
      </div>
    </section>
  );
}
