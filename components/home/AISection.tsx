"use client";

import React from "react";
import { motion } from "framer-motion";
import { Bot, Workflow, MessageSquare, Database, Brain, Zap, ArrowRight } from "lucide-react";
import Link from "next/link";
import { Badge } from "@/components/ui/Badge";

const aiCapabilities = [
  {
    icon: MessageSquare,
    title: "AI Chatbots",
    description: "24/7 lead capture, customer support, and appointment booking powered by GPT-4.",
    color: "#4CC9F0",
  },
  {
    icon: Workflow,
    title: "Workflow Automation",
    description: "Eliminate repetitive tasks with intelligent automation across your entire operation.",
    color: "#4361EE",
  },
  {
    icon: Database,
    title: "CRM Intelligence",
    description: "AI-powered CRM that scores leads, predicts churn, and surfaces opportunities.",
    color: "#7B2FBE",
  },
  {
    icon: Brain,
    title: "AI Content Generation",
    description: "Scale your content production with AI that matches your brand voice perfectly.",
    color: "#F72585",
  },
];

export function AISection() {
  return (
    <section className="section-padding relative overflow-hidden">
      {/* Animated gradient background */}
      <div className="absolute inset-0 bg-gradient-to-r from-brand-blue/10 via-brand-purple/10 to-brand-cyan/10 pointer-events-none" />
      <div className="absolute inset-0 pointer-events-none">
        <div
          className="absolute inset-0 opacity-[0.03]"
          style={{
            backgroundImage: `radial-gradient(circle at 1px 1px, hsl(var(--foreground)) 1px, transparent 0)`,
            backgroundSize: "32px 32px",
          }}
        />
      </div>

      <div className="container mx-auto container-padding relative z-10">
        <div className="grid lg:grid-cols-2 gap-16 items-center">
          {/* Left visual */}
          <motion.div
            initial={{ opacity: 0, x: -30 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.7 }}
            className="relative"
          >
            {/* Central AI orb */}
            <div className="relative w-full max-w-sm mx-auto aspect-square">
              {/* Outer ring */}
              <div className="absolute inset-0 rounded-full border border-primary/20 animate-spin-slow" />
              <div
                className="absolute inset-4 rounded-full border border-primary/10"
                style={{ animationDelay: "3s" }}
              />

              {/* Orbital dots */}
              {[0, 60, 120, 180, 240, 300].map((angle, i) => (
                <div
                  key={i}
                  className="absolute w-2.5 h-2.5 rounded-full bg-primary animate-spin-slow"
                  style={{
                    top: `${50 - 46 * Math.cos((angle * Math.PI) / 180)}%`,
                    left: `${50 + 46 * Math.sin((angle * Math.PI) / 180)}%`,
                    animationDelay: `${i * 0.3}s`,
                    opacity: 0.6,
                  }}
                />
              ))}

              {/* Center */}
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="w-32 h-32 rounded-3xl brand-gradient flex items-center justify-center shadow-2xl shadow-brand-blue/40 animate-float">
                  <Bot className="w-14 h-14 text-white" strokeWidth={1.5} />
                </div>
              </div>
            </div>

            {/* Floating feature chips */}
            <motion.div
              animate={{ y: [-8, 8, -8] }}
              transition={{ duration: 5, repeat: Infinity, ease: "easeInOut" }}
              className="absolute top-8 -right-4 glass rounded-2xl border border-white/10 p-4 shadow-xl"
            >
              <div className="flex items-center gap-2">
                <div className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
                <span className="text-sm font-medium text-foreground whitespace-nowrap">
                  AI Active
                </span>
              </div>
              <p className="text-xs text-muted-foreground mt-0.5">
                47 leads captured today
              </p>
            </motion.div>

            <motion.div
              animate={{ y: [8, -8, 8] }}
              transition={{ duration: 6, repeat: Infinity, ease: "easeInOut", delay: 1 }}
              className="absolute bottom-12 -left-4 glass rounded-2xl border border-white/10 p-4 shadow-xl"
            >
              <div className="text-2xl font-display font-bold gradient-text">
                98%
              </div>
              <p className="text-xs text-muted-foreground">
                Automation rate
              </p>
            </motion.div>
          </motion.div>

          {/* Right content */}
          <div>
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="mb-5"
            >
              <Badge variant="default">
                <Bot className="w-3.5 h-3.5" />
                AI-Powered Business
              </Badge>
            </motion.div>

            <motion.h2
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-5 tracking-tight leading-[1.05]"
            >
              Automate Your
              <br />
              Business With{" "}
              <span className="gradient-text-cyan">AI</span>
            </motion.h2>

            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
              className="text-lg text-muted-foreground leading-relaxed mb-10"
            >
              Your competitors are still doing things manually. We deploy
              intelligent AI systems that capture leads, automate operations,
              and scale your business while you sleep.
            </motion.p>

            <div className="grid sm:grid-cols-2 gap-4 mb-10">
              {aiCapabilities.map((cap, i) => (
                <motion.div
                  key={cap.title}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: 0.3 + i * 0.1 }}
                  className="flex gap-4 p-4 rounded-2xl glass border border-border hover:border-white/20 transition-all duration-300 group"
                >
                  <div
                    className="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
                    style={{
                      backgroundColor: `${cap.color}15`,
                      border: `1px solid ${cap.color}25`,
                    }}
                  >
                    <cap.icon
                      className="w-5 h-5"
                      style={{ color: cap.color }}
                      strokeWidth={1.8}
                    />
                  </div>
                  <div>
                    <h3 className="font-display font-semibold text-sm text-foreground mb-1">
                      {cap.title}
                    </h3>
                    <p className="text-xs text-muted-foreground leading-relaxed">
                      {cap.description}
                    </p>
                  </div>
                </motion.div>
              ))}
            </div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.6 }}
            >
              <Link
                href="/services#ai"
                className="inline-flex items-center gap-2 px-7 py-3.5 rounded-xl brand-gradient text-white font-semibold text-sm hover:shadow-xl hover:shadow-brand-blue/25 hover:scale-[1.02] transition-all duration-300 group"
              >
                <Zap className="w-4 h-4" />
                Explore AI Automation
                <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
              </Link>
            </motion.div>
          </div>
        </div>
      </div>
    </section>
  );
}
