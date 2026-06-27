"use client";

import React, { useState } from "react";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { Button } from "@/components/ui/Button";
import { Calendar, Clock, CheckCircle, Zap, TrendingUp, Users, Star } from "lucide-react";

const benefits = [
  "45-minute deep-dive into your business",
  "Custom growth roadmap created for you",
  "Competitor analysis included",
  "No sales pressure, genuine advice",
  "Actionable steps you can use immediately",
  "Led by senior strategists",
];

const steps = [
  { icon: Calendar, title: "Pick a Time", desc: "Choose from available slots that work for your schedule." },
  { icon: Users, title: "We Prepare", desc: "Our team researches your business before the call." },
  { icon: TrendingUp, title: "Strategy Session", desc: "45 minutes of focused, actionable strategy discussion." },
  { icon: Zap, title: "Activation Plan", desc: "Receive your custom roadmap within 24 hours." },
];

export function BookCallPage() {
  const [submitted, setSubmitted] = useState(false);
  const [form, setForm] = useState({
    name: "", email: "", phone: "", company: "", goal: "", timeline: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitted(true);
  };

  return (
    <section className="pt-36 pb-20">
      <div className="container mx-auto container-padding">
        <div className="grid lg:grid-cols-2 gap-16 max-w-5xl mx-auto">
          {/* Left */}
          <div>
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="mb-5">
              <Badge variant="gold">
                <Calendar className="w-3.5 h-3.5" />
                Free Strategy Call
              </Badge>
            </motion.div>
            <motion.h1
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 }}
              className="font-display font-extrabold text-4xl md:text-5xl text-foreground mb-5 tracking-tight leading-[1.05]"
            >
              Book Your Free{" "}
              <span className="gradient-text">Strategy Call</span>
            </motion.h1>
            <motion.p
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="text-muted-foreground leading-relaxed mb-8 text-lg"
            >
              In 45 minutes, we&apos;ll analyse your business, identify your top 3
              growth opportunities, and give you a clear activation roadmap —
              absolutely free.
            </motion.p>

            {/* What you get */}
            <div className="mb-10">
              <p className="text-sm font-bold uppercase tracking-widest text-foreground mb-4">What You Get</p>
              <ul className="flex flex-col gap-3">
                {benefits.map((b) => (
                  <li key={b} className="flex items-center gap-3 text-sm text-muted-foreground">
                    <CheckCircle className="w-5 h-5 text-emerald-400 flex-shrink-0" />
                    {b}
                  </li>
                ))}
              </ul>
            </div>

            {/* Process */}
            <div className="grid grid-cols-2 gap-3">
              {steps.map((step, i) => (
                <div key={step.title} className="p-4 rounded-xl glass border border-border">
                  <div className="flex items-center gap-2 mb-2">
                    <span className="text-xs font-mono text-primary">0{i + 1}</span>
                    <step.icon className="w-4 h-4 text-primary" />
                  </div>
                  <h3 className="font-semibold text-sm text-foreground mb-1">{step.title}</h3>
                  <p className="text-xs text-muted-foreground leading-relaxed">{step.desc}</p>
                </div>
              ))}
            </div>

            {/* Social proof */}
            <div className="mt-8 p-5 rounded-xl glass border border-border">
              <div className="flex gap-1 mb-2">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} className="w-4 h-4 fill-amber-400 text-amber-400" />
                ))}
              </div>
              <p className="text-sm text-muted-foreground italic">
                &ldquo;The strategy call alone was worth $10,000 in clarity. We walked away with a clear roadmap and signed within a week.&rdquo;
              </p>
              <p className="text-xs text-primary font-semibold mt-2">— Marcus T., CEO, BuildRight</p>
            </div>
          </div>

          {/* Right — Form */}
          <div>
            {submitted ? (
              <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                className="glass rounded-2xl border border-border p-10 text-center h-full flex flex-col items-center justify-center"
              >
                <div className="w-20 h-20 rounded-full bg-emerald-400/15 flex items-center justify-center mb-6">
                  <CheckCircle className="w-10 h-10 text-emerald-400" />
                </div>
                <h3 className="font-display font-bold text-2xl text-foreground mb-3">You&apos;re Booked!</h3>
                <p className="text-muted-foreground max-w-xs">
                  Check your email for confirmation and calendar invite. We can&apos;t wait to learn about your business.
                </p>
              </motion.div>
            ) : (
              <motion.form
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
                onSubmit={handleSubmit}
                className="glass rounded-2xl border border-border p-8 flex flex-col gap-5"
              >
                <h3 className="font-display font-bold text-xl text-foreground">
                  Request Your Strategy Call
                </h3>

                <div className="grid sm:grid-cols-2 gap-4">
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Full Name *</label>
                    <input
                      required
                      value={form.name}
                      onChange={(e) => setForm({ ...form, name: e.target.value })}
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 text-sm"
                      placeholder="Your Name"
                    />
                  </div>
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Email *</label>
                    <input
                      required
                      type="email"
                      value={form.email}
                      onChange={(e) => setForm({ ...form, email: e.target.value })}
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 text-sm"
                      placeholder="you@company.com"
                    />
                  </div>
                </div>
                <div className="grid sm:grid-cols-2 gap-4">
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Phone</label>
                    <input
                      value={form.phone}
                      onChange={(e) => setForm({ ...form, phone: e.target.value })}
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 text-sm"
                      placeholder="+65 9000 0000"
                    />
                  </div>
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Company *</label>
                    <input
                      required
                      value={form.company}
                      onChange={(e) => setForm({ ...form, company: e.target.value })}
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 text-sm"
                      placeholder="Company Name"
                    />
                  </div>
                </div>
                <div>
                  <label className="text-sm font-medium text-foreground mb-1.5 block">What&apos;s Your Main Goal? *</label>
                  <select
                    required
                    value={form.goal}
                    onChange={(e) => setForm({ ...form, goal: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground focus:outline-none focus:border-primary/50 text-sm"
                  >
                    <option value="">Select your primary goal...</option>
                    <option>Launch my business online</option>
                    <option>Generate more leads</option>
                    <option>Improve my website</option>
                    <option>Start advertising online</option>
                    <option>Automate my business</option>
                    <option>Scale to new markets</option>
                    <option>Build my brand</option>
                  </select>
                </div>
                <div>
                  <label className="text-sm font-medium text-foreground mb-1.5 block">Timeline *</label>
                  <select
                    required
                    value={form.timeline}
                    onChange={(e) => setForm({ ...form, timeline: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground focus:outline-none focus:border-primary/50 text-sm"
                  >
                    <option value="">When do you want to start?</option>
                    <option>ASAP — this week</option>
                    <option>Within 2 weeks</option>
                    <option>Within a month</option>
                    <option>Next quarter</option>
                    <option>Just exploring</option>
                  </select>
                </div>

                <div className="flex items-center gap-2 p-3 rounded-xl bg-primary/10 border border-primary/20">
                  <Clock className="w-4 h-4 text-primary flex-shrink-0" />
                  <span className="text-xs text-muted-foreground">
                    <span className="font-semibold text-foreground">45 minutes</span> · Free · No commitment · Response within 4 hours
                  </span>
                </div>

                <Button type="submit" size="lg" className="w-full">
                  <Calendar className="w-5 h-5" />
                  Book My Free Strategy Call
                </Button>
              </motion.form>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}
