"use client";

import React, { useState } from "react";
import Link from "next/link";
import { motion } from "framer-motion";
import { Check, Zap, Star, ArrowRight } from "lucide-react";
import { Badge } from "@/components/ui/Badge";
import { cn } from "@/lib/utils";

const plans = [
  {
    name: "Launch",
    tagline: "Perfect to get started",
    price: { monthly: 2500, annual: 2000 },
    currency: "USD",
    description:
      "Everything a new business needs to establish a powerful digital presence and start generating leads.",
    color: "#4CC9F0",
    features: [
      "Premium 5-page website",
      "Brand identity design",
      "On-page SEO setup",
      "Google Analytics & Search Console",
      "Contact form & lead capture",
      "Mobile-first responsive design",
      "3 months of support",
      "Performance optimization",
    ],
    cta: "Get Started",
    href: "/book-call?plan=launch",
    popular: false,
  },
  {
    name: "Grow",
    tagline: "Most popular for growing businesses",
    price: { monthly: 5500, annual: 4500 },
    currency: "USD",
    description:
      "Complete digital activation with marketing, SEO, and automation to drive consistent growth.",
    color: "#4361EE",
    features: [
      "Everything in Launch",
      "Premium 10-15 page website",
      "Full brand identity system",
      "SEO campaign (6 months)",
      "Google & Meta Ads management",
      "Email marketing setup",
      "AI chatbot integration",
      "Monthly performance reports",
      "Dedicated account manager",
      "CRM setup & integration",
      "6 months of support",
    ],
    cta: "Activate Growth",
    href: "/book-call?plan=grow",
    popular: true,
  },
  {
    name: "Scale",
    tagline: "For ambitious companies",
    price: { monthly: 9500, annual: 7900 },
    currency: "USD",
    description:
      "Full-stack business activation with AI automation, enterprise marketing, and strategic advisory.",
    color: "#7B2FBE",
    features: [
      "Everything in Grow",
      "Custom web application",
      "Complete AI automation suite",
      "Workflow & CRM automation",
      "Content marketing program",
      "International SEO",
      "Video production",
      "Weekly strategy calls",
      "Executive business advisory",
      "Priority support 24/7",
      "12 months of support",
      "Quarterly brand evolution",
    ],
    cta: "Scale Now",
    href: "/book-call?plan=scale",
    popular: false,
  },
];

export function Pricing() {
  const [annual, setAnnual] = useState(false);

  return (
    <section className="section-padding relative" id="pricing">
      <div className="container mx-auto container-padding">
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-12">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="flex justify-center mb-4"
          >
            <Badge variant="default">
              <Zap className="w-3.5 h-3.5" />
              Transparent Pricing
            </Badge>
          </motion.div>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground mb-5 tracking-tight"
          >
            Investment in Your{" "}
            <span className="gradient-text">Growth</span>
          </motion.h2>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground mb-8"
          >
            Clear pricing. No surprises. Every plan includes our full expertise
            and a dedicated team focused on your success.
          </motion.p>

          {/* Toggle */}
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            className="flex items-center justify-center gap-4"
          >
            <span
              className={cn(
                "text-sm font-medium transition-colors",
                !annual ? "text-foreground" : "text-muted-foreground"
              )}
            >
              Monthly
            </span>
            <button
              onClick={() => setAnnual(!annual)}
              className={cn(
                "relative w-12 h-6 rounded-full transition-colors duration-300",
                annual ? "bg-primary" : "bg-border"
              )}
            >
              <span
                className={cn(
                  "absolute top-1 w-4 h-4 rounded-full bg-white transition-transform duration-300",
                  annual ? "translate-x-7" : "translate-x-1"
                )}
              />
            </button>
            <span
              className={cn(
                "text-sm font-medium transition-colors",
                annual ? "text-foreground" : "text-muted-foreground"
              )}
            >
              Annual{" "}
              <span className="text-xs font-bold text-emerald-400">
                Save 20%
              </span>
            </span>
          </motion.div>
        </div>

        {/* Plans */}
        <div className="grid md:grid-cols-3 gap-6 max-w-5xl mx-auto">
          {plans.map((plan, i) => (
            <motion.div
              key={plan.name}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.5, delay: i * 0.15 }}
              className={cn(
                "relative rounded-3xl border p-8 transition-all duration-300",
                plan.popular
                  ? "border-primary/40 shadow-2xl shadow-primary/10 scale-[1.02]"
                  : "border-border hover:border-primary/20 hover:-translate-y-1 hover:shadow-xl"
              )}
              style={{
                background: plan.popular
                  ? `linear-gradient(135deg, ${plan.color}15 0%, transparent 60%)`
                  : undefined,
              }}
            >
              {plan.popular && (
                <div className="absolute -top-4 left-1/2 -translate-x-1/2">
                  <div className="flex items-center gap-1.5 px-4 py-1.5 rounded-full brand-gradient text-white text-xs font-bold shadow-lg">
                    <Star className="w-3 h-3 fill-white" />
                    Most Popular
                  </div>
                </div>
              )}

              <div className="mb-6">
                <h3
                  className="font-display font-bold text-xl mb-1"
                  style={{ color: plan.color }}
                >
                  {plan.name}
                </h3>
                <p className="text-sm text-muted-foreground mb-5">
                  {plan.tagline}
                </p>
                <div className="flex items-end gap-1">
                  <span className="text-sm text-muted-foreground">$</span>
                  <span className="font-display font-extrabold text-4xl text-foreground">
                    {(annual
                      ? plan.price.annual
                      : plan.price.monthly
                    ).toLocaleString()}
                  </span>
                  <span className="text-sm text-muted-foreground pb-1">
                    /mo
                  </span>
                </div>
                {annual && (
                  <p className="text-xs text-emerald-400 font-medium mt-1">
                    Save $
                    {(
                      (plan.price.monthly - plan.price.annual) *
                      12
                    ).toLocaleString()}{" "}
                    annually
                  </p>
                )}
              </div>

              <p className="text-sm text-muted-foreground mb-6 leading-relaxed">
                {plan.description}
              </p>

              <ul className="flex flex-col gap-3 mb-8">
                {plan.features.map((feature) => (
                  <li key={feature} className="flex items-start gap-3">
                    <div
                      className="w-5 h-5 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5"
                      style={{
                        backgroundColor: `${plan.color}20`,
                        border: `1px solid ${plan.color}30`,
                      }}
                    >
                      <Check
                        className="w-3 h-3"
                        style={{ color: plan.color }}
                        strokeWidth={2.5}
                      />
                    </div>
                    <span className="text-sm text-muted-foreground">
                      {feature}
                    </span>
                  </li>
                ))}
              </ul>

              <Link
                href={plan.href}
                className={cn(
                  "flex items-center justify-center gap-2 w-full py-3.5 rounded-xl font-semibold text-sm transition-all duration-300",
                  plan.popular
                    ? "brand-gradient text-white shadow-lg shadow-brand-blue/25 hover:shadow-xl hover:shadow-brand-blue/35 hover:scale-[1.02]"
                    : "border-2 border-border text-foreground hover:border-primary hover:text-primary"
                )}
              >
                {plan.cta}
                <ArrowRight className="w-4 h-4" />
              </Link>
            </motion.div>
          ))}
        </div>

        {/* Custom note */}
        <motion.p
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          className="text-center text-sm text-muted-foreground mt-10"
        >
          Need a custom solution?{" "}
          <Link
            href="/contact"
            className="text-primary font-semibold hover:underline"
          >
            Contact us for enterprise pricing →
          </Link>
        </motion.p>
      </div>
    </section>
  );
}
