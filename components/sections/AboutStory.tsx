"use client";

import React from "react";
import { motion } from "framer-motion";

const milestones = [
  { year: "2019", event: "BizActivate founded in Singapore with a mission to transform how businesses grow digitally." },
  { year: "2020", event: "Expanded to serve US and Australian markets. First 50 client activations completed." },
  { year: "2021", event: "Launched our proprietary BizActivate Framework™. Helped clients generate $10M+ in revenue." },
  { year: "2022", event: "AI division launched. First enterprise clients onboarded. Team grew to 25+ specialists." },
  { year: "2023", event: "Expanded to 7 countries. 150+ businesses activated. $50M+ in client revenue generated." },
  { year: "2024", event: "Named among top 10 digital agencies in Southeast Asia. Global expansion continues." },
];

export function AboutStory() {
  return (
    <section className="section-padding">
      <div className="container mx-auto container-padding">
        <div className="grid lg:grid-cols-2 gap-16 items-center mb-20">
          <motion.div
            initial={{ opacity: 0, x: -30 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
          >
            <h2 className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-6 tracking-tight">
              Our <span className="gradient-text">Story</span>
            </h2>
            <div className="space-y-5 text-muted-foreground leading-relaxed">
              <p>
                BizActivate was founded with a simple but powerful observation:
                the most ambitious startups and growing businesses were being
                underserved by the agency world. They were getting websites, not
                strategies. Getting deliverables, not outcomes.
              </p>
              <p>
                We set out to build something different — a Business Activation
                Agency that treats every client like a co-founder. One that
                brings the thinking of a Chief Marketing Officer, the execution
                of an elite product team, and the innovation of a Silicon Valley
                startup.
              </p>
              <p>
                Today, BizActivate serves ambitious businesses across Singapore,
                the United States, Australia, the UK, Canada, New Zealand, and
                the UAE — helping them launch faster, grow smarter, automate
                operations, and scale globally.
              </p>
            </div>
          </motion.div>

          {/* Timeline */}
          <div className="flex flex-col gap-5">
            {milestones.map((m, i) => (
              <motion.div
                key={m.year}
                initial={{ opacity: 0, x: 30 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.08 }}
                className="flex gap-5"
              >
                <div className="flex flex-col items-center">
                  <div className="w-10 h-10 rounded-xl brand-gradient flex items-center justify-center text-white text-xs font-bold flex-shrink-0 shadow-lg shadow-brand-blue/20">
                    {m.year.slice(2)}
                  </div>
                  {i < milestones.length - 1 && (
                    <div className="w-px flex-1 bg-gradient-to-b from-primary/30 to-transparent mt-2" />
                  )}
                </div>
                <div className="pt-2 pb-5">
                  <span className="text-sm font-bold text-primary">{m.year}</span>
                  <p className="text-sm text-muted-foreground mt-1 leading-relaxed">{m.event}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
