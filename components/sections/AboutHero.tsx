"use client";

import React from "react";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { Users } from "lucide-react";

export function AboutHero() {
  return (
    <section className="pt-36 pb-20 relative overflow-hidden">
      <div className="orb orb-blue absolute w-96 h-96 -top-24 -right-24 opacity-20 pointer-events-none" />
      <div className="orb orb-purple absolute w-64 h-64 bottom-0 -left-16 opacity-15 pointer-events-none" />

      <div className="container mx-auto container-padding relative z-10">
        <div className="max-w-4xl mx-auto text-center">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex justify-center mb-6"
          >
            <Badge variant="default">
              <Users className="w-3.5 h-3.5" />
              About BizActivate
            </Badge>
          </motion.div>
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-5xl md:text-6xl lg:text-7xl text-foreground mb-6 tracking-tight leading-[1.05]"
          >
            Built for Businesses
            <br />
            That Refuse to{" "}
            <span className="gradient-text">Be Average</span>
          </motion.h1>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="text-xl text-muted-foreground max-w-2xl mx-auto leading-relaxed"
          >
            BizActivate was born from a conviction that growing businesses
            deserve world-class strategy, technology, and creativity — not
            template solutions from agencies playing it safe.
          </motion.p>
        </div>
      </div>
    </section>
  );
}
