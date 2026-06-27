"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import {
  Search, Lightbulb, Target, Palette, Layout, Code2,
  Rocket, Megaphone, Bot, TrendingUp, Globe, ChevronRight
} from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const stages = [
  {
    number: "01",
    name: "Discover",
    icon: Search,
    color: "#4CC9F0",
    title: "Deep Discovery",
    description:
      "We immerse ourselves in your business, goals, and market. Every project starts with understanding who you are, who your customers are, and where the real opportunities exist.",
    deliverables: ["Business audit", "Competitor analysis", "Customer research", "Opportunity mapping"],
  },
  {
    number: "02",
    name: "Research",
    icon: Lightbulb,
    color: "#4361EE",
    title: "Market Research",
    description:
      "Data-driven research into your industry, competitors, SEO landscape, and target audience behavior to build a foundation of competitive intelligence.",
    deliverables: ["SEO research", "Market sizing", "Audience personas", "Keyword universe"],
  },
  {
    number: "03",
    name: "Strategy",
    icon: Target,
    color: "#7B2FBE",
    title: "Growth Strategy",
    description:
      "We build a bespoke activation strategy — your unique positioning, messaging architecture, channel mix, and 90-day growth roadmap.",
    deliverables: ["Brand positioning", "Channel strategy", "Revenue roadmap", "KPI framework"],
  },
  {
    number: "04",
    name: "Brand",
    icon: Palette,
    color: "#F72585",
    title: "Brand Identity",
    description:
      "We craft a distinctive brand identity that commands attention, builds instant trust, and positions you as the premium choice in your market.",
    deliverables: ["Logo & identity", "Color & typography", "Brand guidelines", "Visual assets"],
  },
  {
    number: "05",
    name: "Design",
    icon: Layout,
    color: "#FFB703",
    title: "World-Class Design",
    description:
      "Beautiful, conversion-focused designs built to wow your visitors and guide them naturally toward taking action — across every device.",
    deliverables: ["UX wireframes", "UI design", "Prototyping", "Design system"],
  },
  {
    number: "06",
    name: "Develop",
    icon: Code2,
    color: "#4CC9F0",
    title: "Premium Development",
    description:
      "We build blazing-fast, technically excellent websites and web applications using the latest technology stack — built to scale with your business.",
    deliverables: ["Next.js development", "CMS integration", "API connections", "Performance optimization"],
  },
  {
    number: "07",
    name: "Launch",
    icon: Rocket,
    color: "#4361EE",
    title: "Strategic Launch",
    description:
      "A carefully orchestrated launch that maximizes visibility, SEO impact, and initial traction — turning day one into a statement moment.",
    deliverables: ["QA testing", "SEO setup", "Analytics config", "Launch campaign"],
  },
  {
    number: "08",
    name: "Market",
    icon: Megaphone,
    color: "#7B2FBE",
    title: "Digital Marketing",
    description:
      "We execute multi-channel marketing campaigns — SEO, Google Ads, Meta Ads, and content — to drive qualified traffic and consistent lead flow.",
    deliverables: ["SEO campaigns", "Paid advertising", "Content marketing", "Lead generation"],
  },
  {
    number: "09",
    name: "Automate",
    icon: Bot,
    color: "#F72585",
    title: "AI Automation",
    description:
      "We deploy intelligent automations that eliminate repetitive tasks, capture leads 24/7, and let your team focus on high-value work.",
    deliverables: ["AI chatbots", "CRM automation", "Email sequences", "Workflow systems"],
  },
  {
    number: "10",
    name: "Optimize",
    icon: TrendingUp,
    color: "#FFB703",
    title: "Continuous Optimization",
    description:
      "We analyze data, test ideas, and continuously improve performance — turning good results into exceptional ones through relentless iteration.",
    deliverables: ["A/B testing", "Conversion rate optimization", "Analytics review", "Performance reports"],
  },
  {
    number: "11",
    name: "Scale",
    icon: Globe,
    color: "#4CC9F0",
    title: "Global Scale",
    description:
      "With proven systems in place, we help you expand into new markets, channels, and geographies — scaling revenue without scaling complexity.",
    deliverables: ["Market expansion", "International SEO", "Referral systems", "Partnership strategy"],
  },
];

export function Framework() {
  const [activeStage, setActiveStage] = useState(0);

  return (
    <section className="section-padding relative overflow-hidden bg-gradient-to-b from-background via-primary/5 to-background">
      <div className="absolute inset-0 pointer-events-none">
        <div className="orb orb-blue absolute w-96 h-96 -right-24 top-24 opacity-20" />
        <div className="orb orb-purple absolute w-64 h-64 -left-16 bottom-24 opacity-15" />
      </div>

      <div className="container mx-auto container-padding relative z-10">
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="flex justify-center mb-4"
          >
            <Badge variant="gold">
              ™ Proprietary Method
            </Badge>
          </motion.div>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-5 tracking-tight"
          >
            The{" "}
            <span className="gradient-text-gold">BizActivate</span>
            <br />
            Framework™
          </motion.h2>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground"
          >
            Our proven 11-stage activation system transforms businesses from
            idea to unstoppable growth engine. No guesswork. Pure execution.
          </motion.p>
        </div>

        {/* Framework Display */}
        <div className="grid lg:grid-cols-5 gap-8 items-start">
          {/* Stage Selector */}
          <div className="lg:col-span-2 flex flex-col gap-2">
            {stages.map((stage, i) => (
              <motion.button
                key={stage.name}
                initial={{ opacity: 0, x: -20 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.04 }}
                onClick={() => setActiveStage(i)}
                className={`flex items-center gap-4 p-4 rounded-xl text-left transition-all duration-300 group ${
                  activeStage === i
                    ? "glass border border-white/20 shadow-lg"
                    : "hover:bg-foreground/5 border border-transparent"
                }`}
              >
                <div
                  className={`w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0 transition-all duration-300`}
                  style={{
                    backgroundColor:
                      activeStage === i
                        ? `${stage.color}20`
                        : "hsl(var(--foreground) / 0.05)",
                    border: `1px solid ${activeStage === i ? stage.color + "40" : "transparent"}`,
                  }}
                >
                  <stage.icon
                    className="w-4.5 h-4.5"
                    style={{ color: activeStage === i ? stage.color : undefined }}
                  />
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-mono text-muted-foreground">
                      {stage.number}
                    </span>
                    <span
                      className={`font-display font-semibold text-sm transition-colors ${
                        activeStage === i ? "text-foreground" : "text-muted-foreground"
                      }`}
                    >
                      {stage.name}
                    </span>
                  </div>
                </div>
                <ChevronRight
                  className={`w-4 h-4 text-muted-foreground flex-shrink-0 transition-transform duration-200 ${
                    activeStage === i ? "translate-x-0.5 text-primary" : ""
                  }`}
                />
              </motion.button>
            ))}
          </div>

          {/* Stage Detail */}
          <div className="lg:col-span-3 lg:sticky lg:top-32">
            <AnimatePresence mode="wait">
              <motion.div
                key={activeStage}
                initial={{ opacity: 0, x: 20, scale: 0.98 }}
                animate={{ opacity: 1, x: 0, scale: 1 }}
                exit={{ opacity: 0, x: -20, scale: 0.98 }}
                transition={{ duration: 0.3 }}
                className="glass rounded-3xl border border-white/10 p-8 md:p-10"
              >
                <div className="flex items-start gap-5 mb-8">
                  <div
                    className="w-16 h-16 rounded-2xl flex items-center justify-center flex-shrink-0 shadow-lg"
                    style={{
                      backgroundColor: `${stages[activeStage].color}20`,
                      border: `1px solid ${stages[activeStage].color}30`,
                      boxShadow: `0 0 40px ${stages[activeStage].color}20`,
                    }}
                  >
                    {React.createElement(stages[activeStage].icon, {
                      className: "w-7 h-7",
                      style: { color: stages[activeStage].color },
                      strokeWidth: 1.8,
                    })}
                  </div>
                  <div>
                    <span
                      className="text-xs font-mono font-bold uppercase tracking-widest"
                      style={{ color: stages[activeStage].color }}
                    >
                      Stage {stages[activeStage].number}
                    </span>
                    <h3 className="font-display font-bold text-2xl md:text-3xl text-foreground mt-1">
                      {stages[activeStage].title}
                    </h3>
                  </div>
                </div>

                <p className="text-muted-foreground text-lg leading-relaxed mb-8">
                  {stages[activeStage].description}
                </p>

                <div>
                  <p className="text-sm font-semibold text-foreground uppercase tracking-widest mb-4">
                    Deliverables
                  </p>
                  <div className="grid grid-cols-2 gap-3">
                    {stages[activeStage].deliverables.map((item) => (
                      <div
                        key={item}
                        className="flex items-center gap-2.5 p-3 rounded-xl bg-foreground/5 border border-border"
                      >
                        <span
                          className="w-1.5 h-1.5 rounded-full flex-shrink-0"
                          style={{ backgroundColor: stages[activeStage].color }}
                        />
                        <span className="text-sm text-foreground font-medium">
                          {item}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>

                {/* Navigation */}
                <div className="flex items-center justify-between mt-8 pt-8 border-t border-border">
                  <button
                    onClick={() => setActiveStage(Math.max(0, activeStage - 1))}
                    disabled={activeStage === 0}
                    className="text-sm text-muted-foreground hover:text-foreground transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                  >
                    ← Previous
                  </button>
                  <span className="text-xs text-muted-foreground font-mono">
                    {activeStage + 1} / {stages.length}
                  </span>
                  <button
                    onClick={() =>
                      setActiveStage(Math.min(stages.length - 1, activeStage + 1))
                    }
                    disabled={activeStage === stages.length - 1}
                    className="text-sm text-muted-foreground hover:text-foreground transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                  >
                    Next →
                  </button>
                </div>
              </motion.div>
            </AnimatePresence>
          </div>
        </div>
      </div>
    </section>
  );
}
