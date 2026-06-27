"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Plus, Minus, HelpCircle } from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const faqs = [
  {
    q: "What makes BizActivate different from other digital agencies?",
    a: "Most agencies build deliverables — websites, ads, logos. We build businesses. Our approach is rooted in strategy first, which means every design, every campaign, and every automation we create is tied to a specific business outcome. We also bring AI natively into every engagement, giving you a competitive edge most agencies can't offer.",
  },
  {
    q: "How long does it take to see results?",
    a: "For website projects, you'll have a live, high-performance website within 4-6 weeks. For SEO and organic marketing, meaningful results typically appear in months 3-6. Paid advertising (Google/Meta) starts generating leads within the first 2 weeks of launch. We're transparent about timelines and set realistic expectations from day one.",
  },
  {
    q: "Do you work with startups or only established businesses?",
    a: "We love working with ambitious founders at every stage. Our Launch package is specifically designed for startups that need to build their digital foundation fast and right. We've helped businesses from pre-revenue all the way to international expansion.",
  },
  {
    q: "What countries do you serve?",
    a: "We are headquartered in Singapore and serve clients globally. Our primary markets are Singapore, United States, Canada, Australia, United Kingdom, New Zealand, and UAE. We have experience with international SEO, multi-language websites, and market-specific advertising strategies.",
  },
  {
    q: "What is included in ongoing support?",
    a: "Support includes website maintenance, security updates, performance monitoring, bug fixes, and technical assistance. Grow and Scale plans also include ongoing SEO work, monthly reporting, and access to your dedicated account manager for strategic guidance.",
  },
  {
    q: "Can I see examples of your work?",
    a: "Absolutely — visit our Portfolio and Case Studies pages to see real examples of websites, brand identities, and campaigns we've built. We're also happy to share relevant examples from your specific industry during a free strategy call.",
  },
  {
    q: "How does your AI Automation service work?",
    a: "We assess your business workflows, identify automation opportunities, and deploy AI solutions tailored to your needs. This typically includes an AI chatbot for your website, CRM automation, email sequences, and workflow integrations. Our AI systems are built on enterprise platforms like OpenAI, Make, and Zapier.",
  },
  {
    q: "Do you offer a money-back guarantee?",
    a: "We stand behind our work completely. If you're unsatisfied within the first 30 days of your project, we'll make it right or provide a full refund. Our 98% client satisfaction rate reflects our commitment to delivering exceptional outcomes, not just deliverables.",
  },
];

export function FAQ() {
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  return (
    <section className="section-padding" id="faq">
      <div className="container mx-auto container-padding">
        <div className="grid lg:grid-cols-5 gap-12 items-start">
          {/* Left */}
          <div className="lg:col-span-2 lg:sticky lg:top-32">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="mb-5"
            >
              <Badge variant="default">
                <HelpCircle className="w-3.5 h-3.5" />
                FAQ
              </Badge>
            </motion.div>
            <motion.h2
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-5 tracking-tight"
            >
              Questions?
              <br />
              <span className="gradient-text">Answered.</span>
            </motion.h2>
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
              className="text-muted-foreground leading-relaxed"
            >
              Can&apos;t find what you&apos;re looking for? Book a free strategy call and
              our team will answer every question personally.
            </motion.p>
          </div>

          {/* Right — Accordion */}
          <div className="lg:col-span-3 flex flex-col gap-3">
            {faqs.map((faq, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, y: 15 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.07 }}
                className={`rounded-2xl border transition-all duration-300 overflow-hidden ${
                  openIndex === i
                    ? "border-primary/30 bg-primary/5"
                    : "border-border hover:border-primary/15"
                }`}
              >
                <button
                  onClick={() => setOpenIndex(openIndex === i ? null : i)}
                  className="w-full flex items-start justify-between gap-4 p-6 text-left"
                  aria-expanded={openIndex === i}
                >
                  <span className="font-display font-semibold text-foreground leading-snug">
                    {faq.q}
                  </span>
                  <span
                    className={`flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center transition-all duration-300 ${
                      openIndex === i
                        ? "bg-primary text-white"
                        : "bg-foreground/10 text-muted-foreground"
                    }`}
                  >
                    {openIndex === i ? (
                      <Minus className="w-3.5 h-3.5" />
                    ) : (
                      <Plus className="w-3.5 h-3.5" />
                    )}
                  </span>
                </button>
                <AnimatePresence>
                  {openIndex === i && (
                    <motion.div
                      initial={{ height: 0, opacity: 0 }}
                      animate={{ height: "auto", opacity: 1 }}
                      exit={{ height: 0, opacity: 0 }}
                      transition={{ duration: 0.25, ease: "easeInOut" }}
                    >
                      <div className="px-6 pb-6">
                        <p className="text-muted-foreground leading-relaxed text-sm">
                          {faq.a}
                        </p>
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
