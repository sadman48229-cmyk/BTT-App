"use client";

import React from "react";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { Cpu } from "lucide-react";

export function ServicesHero() {
  return (
    <section className="pt-36 pb-20 relative overflow-hidden text-center">
      <div className="orb orb-blue absolute w-96 h-96 -top-24 left-1/4 opacity-15 pointer-events-none" />
      <div className="container mx-auto container-padding relative z-10">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex justify-center mb-6"
        >
          <Badge variant="default">
            <Cpu className="w-3.5 h-3.5" />
            Full-Stack Services
          </Badge>
        </motion.div>
        <motion.h1
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="font-display font-extrabold text-5xl md:text-6xl lg:text-7xl text-foreground mb-6 tracking-tight"
        >
          One Agency.
          <br />
          <span className="gradient-text">Every Capability.</span>
        </motion.h1>
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="text-xl text-muted-foreground max-w-2xl mx-auto"
        >
          From brand identity to AI automation, we handle the full spectrum of
          digital growth. No juggling multiple agencies. No communication gaps.
          Just relentless execution.
        </motion.p>
      </div>
    </section>
  );
}
