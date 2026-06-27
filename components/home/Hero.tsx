"use client";

import React, { useEffect, useRef } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowRight, Play, Zap, TrendingUp, Globe, Bot } from "lucide-react";
import { Button } from "@/components/ui/Button";
import { Badge } from "@/components/ui/Badge";

const floatingStats = [
  { icon: TrendingUp, value: "340%", label: "Average ROI", color: "text-emerald-400" },
  { icon: Globe, value: "7+", label: "Countries", color: "text-brand-cyan" },
  { icon: Bot, value: "AI-First", label: "Approach", color: "text-brand-blue" },
  { icon: Zap, value: "48h", label: "Launch Speed", color: "text-amber-400" },
];

export function Hero() {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (!containerRef.current) return;
      const rect = containerRef.current.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width - 0.5) * 20;
      const y = ((e.clientY - rect.top) / rect.height - 0.5) * 20;
      const orbs = containerRef.current.querySelectorAll<HTMLElement>(".hero-orb");
      orbs.forEach((orb, i) => {
        const factor = (i + 1) * 0.3;
        orb.style.transform = `translate(${x * factor}px, ${y * factor}px)`;
      });
    };
    window.addEventListener("mousemove", handleMouseMove);
    return () => window.removeEventListener("mousemove", handleMouseMove);
  }, []);

  return (
    <section
      ref={containerRef}
      className="relative min-h-screen flex items-center justify-center overflow-hidden"
    >
      {/* Background Orbs */}
      <div className="hero-orb orb orb-blue absolute w-[600px] h-[600px] -top-32 -left-32 opacity-30 transition-transform duration-700 ease-out" />
      <div className="hero-orb orb orb-purple absolute w-[500px] h-[500px] -bottom-32 -right-32 opacity-25 transition-transform duration-700 ease-out" />
      <div className="hero-orb orb orb-cyan absolute w-[300px] h-[300px] top-1/2 right-1/4 opacity-15 transition-transform duration-700 ease-out" />

      {/* Grid pattern overlay */}
      <div
        className="absolute inset-0 opacity-[0.03]"
        style={{
          backgroundImage: `linear-gradient(hsl(var(--foreground)) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--foreground)) 1px, transparent 1px)`,
          backgroundSize: "64px 64px",
        }}
      />

      <div className="container mx-auto container-padding relative z-10">
        <div className="max-w-5xl mx-auto text-center">
          {/* Badge */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="flex justify-center mb-8"
          >
            <Badge variant="default" className="text-sm px-4 py-1.5 gap-2">
              <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
              Now Activating Businesses Globally
            </Badge>
          </motion.div>

          {/* Main Headline */}
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7, delay: 0.1 }}
            className="font-display font-extrabold text-5xl sm:text-6xl md:text-7xl lg:text-[5.5rem] leading-[1.05] tracking-tight mb-6 text-balance"
          >
            We Don&apos;t Build{" "}
            <span className="relative inline-block">
              <span className="gradient-text">Websites.</span>
            </span>
            <br />
            We Build{" "}
            <span className="relative">
              <span
                className="gradient-text"
                style={{
                  backgroundImage:
                    "linear-gradient(135deg, #4CC9F0 0%, #4361EE 40%, #7B2FBE 100%)",
                  WebkitBackgroundClip: "text",
                  WebkitTextFillColor: "transparent",
                }}
              >
                Businesses.
              </span>
              <motion.span
                initial={{ scaleX: 0 }}
                animate={{ scaleX: 1 }}
                transition={{ duration: 0.8, delay: 0.9 }}
                className="absolute -bottom-2 left-0 right-0 h-1 brand-gradient rounded-full origin-left"
              />
            </span>
          </motion.h1>

          {/* Subheadline */}
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            className="text-lg sm:text-xl text-muted-foreground max-w-2xl mx-auto mb-10 leading-relaxed"
          >
            BizActivate is the world&apos;s first{" "}
            <span className="text-foreground font-medium">
              Business Activation Agency
            </span>{" "}
            — combining strategy, AI, design, and digital marketing to transform
            startups into global brands.
          </motion.p>

          {/* CTAs */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.45 }}
            className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-16"
          >
            <Link href="/book-call">
              <Button size="xl" className="group w-full sm:w-auto">
                Activate Your Business
                <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
              </Button>
            </Link>
            <button className="flex items-center gap-3 px-6 py-4 rounded-xl glass border border-white/10 text-foreground font-medium text-base hover:bg-white/10 transition-all duration-300 group">
              <span className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center group-hover:bg-primary/20 transition-colors">
                <Play className="w-4 h-4 fill-current ml-0.5" />
              </span>
              Watch Our Story
            </button>
          </motion.div>

          {/* Floating Stats */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.7, delay: 0.6 }}
            className="grid grid-cols-2 md:grid-cols-4 gap-4 max-w-3xl mx-auto"
          >
            {floatingStats.map((stat, i) => (
              <motion.div
                key={stat.label}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.5, delay: 0.7 + i * 0.1 }}
                className="glass rounded-2xl p-4 border border-white/10 hover:border-white/20 transition-all duration-300 hover:scale-[1.02] cursor-default"
              >
                <stat.icon className={`w-5 h-5 ${stat.color} mb-2 mx-auto`} />
                <div className={`font-display font-bold text-2xl ${stat.color}`}>
                  {stat.value}
                </div>
                <div className="text-xs text-muted-foreground mt-0.5">
                  {stat.label}
                </div>
              </motion.div>
            ))}
          </motion.div>
        </div>
      </div>

      {/* Scroll Indicator */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 1.5 }}
        className="absolute bottom-8 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2"
      >
        <span className="text-xs text-muted-foreground uppercase tracking-widest">
          Scroll
        </span>
        <div className="w-px h-12 bg-gradient-to-b from-primary/50 to-transparent animate-pulse" />
      </motion.div>
    </section>
  );
}
