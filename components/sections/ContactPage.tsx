"use client";

import React, { useState } from "react";
import { motion } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { Button } from "@/components/ui/Button";
import { Mail, MessageSquare, MapPin, Phone, Send, CheckCircle } from "lucide-react";

const contactMethods = [
  { icon: Mail, label: "Email Us", value: "hello@bizactivate.com", href: "mailto:hello@bizactivate.com", color: "#4361EE" },
  { icon: Phone, label: "Call Us", value: "+65 9000 0000", href: "tel:+6590000000", color: "#7B2FBE" },
  { icon: MessageSquare, label: "WhatsApp", value: "Message Us Directly", href: "https://wa.me/6590000000", color: "#25D366" },
  { icon: MapPin, label: "Headquarters", value: "Singapore (Serving Globally)", href: "#", color: "#FFB703" },
];

export function ContactPage() {
  const [submitted, setSubmitted] = useState(false);
  const [form, setForm] = useState({
    name: "", email: "", company: "", service: "", message: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitted(true);
  };

  return (
    <section className="pt-36 pb-20">
      <div className="container mx-auto container-padding">
        <div className="text-center mb-16">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="flex justify-center mb-5">
            <Badge variant="default">
              <MessageSquare className="w-3.5 h-3.5" />
              Contact Us
            </Badge>
          </motion.div>
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-5xl md:text-6xl text-foreground mb-5 tracking-tight"
          >
            Let&apos;s Start a{" "}
            <span className="gradient-text">Conversation</span>
          </motion.h1>
        </div>

        <div className="grid lg:grid-cols-5 gap-12 max-w-5xl mx-auto">
          {/* Contact Methods */}
          <div className="lg:col-span-2">
            <p className="text-muted-foreground leading-relaxed mb-8">
              Ready to activate your business? Reach out through any channel below or fill in the form and we&apos;ll respond within 24 hours.
            </p>
            <div className="flex flex-col gap-4">
              {contactMethods.map((method) => (
                <a
                  key={method.label}
                  href={method.href}
                  className="flex items-center gap-4 p-4 rounded-xl glass border border-border hover:border-primary/20 transition-all duration-300 group"
                >
                  <div
                    className="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
                    style={{ backgroundColor: `${method.color}15`, border: `1px solid ${method.color}25` }}
                  >
                    <method.icon className="w-4.5 h-4.5" style={{ color: method.color }} />
                  </div>
                  <div>
                    <div className="text-xs text-muted-foreground">{method.label}</div>
                    <div className="font-medium text-foreground text-sm group-hover:text-primary transition-colors">{method.value}</div>
                  </div>
                </a>
              ))}
            </div>
          </div>

          {/* Form */}
          <div className="lg:col-span-3">
            {submitted ? (
              <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                className="glass rounded-2xl border border-border p-10 text-center"
              >
                <CheckCircle className="w-14 h-14 text-emerald-400 mx-auto mb-4" />
                <h3 className="font-display font-bold text-2xl text-foreground mb-3">Message Received!</h3>
                <p className="text-muted-foreground">
                  Thank you for reaching out. Our team will review your message and respond within 24 hours.
                </p>
              </motion.div>
            ) : (
              <motion.form
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
                onSubmit={handleSubmit}
                className="glass rounded-2xl border border-border p-8 flex flex-col gap-5"
              >
                <div className="grid sm:grid-cols-2 gap-5">
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Full Name *</label>
                    <input
                      required
                      value={form.name}
                      onChange={(e) => setForm({ ...form, name: e.target.value })}
                      placeholder="John Smith"
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 transition-colors text-sm"
                    />
                  </div>
                  <div>
                    <label className="text-sm font-medium text-foreground mb-1.5 block">Email Address *</label>
                    <input
                      required
                      type="email"
                      value={form.email}
                      onChange={(e) => setForm({ ...form, email: e.target.value })}
                      placeholder="john@company.com"
                      className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 transition-colors text-sm"
                    />
                  </div>
                </div>
                <div>
                  <label className="text-sm font-medium text-foreground mb-1.5 block">Company Name</label>
                  <input
                    value={form.company}
                    onChange={(e) => setForm({ ...form, company: e.target.value })}
                    placeholder="Your Company"
                    className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 transition-colors text-sm"
                  />
                </div>
                <div>
                  <label className="text-sm font-medium text-foreground mb-1.5 block">Service Interested In</label>
                  <select
                    value={form.service}
                    onChange={(e) => setForm({ ...form, service: e.target.value })}
                    className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground focus:outline-none focus:border-primary/50 transition-colors text-sm"
                  >
                    <option value="">Select a service...</option>
                    <option>Website Development</option>
                    <option>Brand Identity</option>
                    <option>SEO</option>
                    <option>Google & Meta Ads</option>
                    <option>AI Automation</option>
                    <option>Business Strategy</option>
                    <option>Full Activation Package</option>
                  </select>
                </div>
                <div>
                  <label className="text-sm font-medium text-foreground mb-1.5 block">Message *</label>
                  <textarea
                    required
                    rows={4}
                    value={form.message}
                    onChange={(e) => setForm({ ...form, message: e.target.value })}
                    placeholder="Tell us about your business and what you'd like to achieve..."
                    className="w-full px-4 py-3 rounded-xl bg-background border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary/50 transition-colors text-sm resize-none"
                  />
                </div>
                <Button type="submit" size="lg" className="w-full">
                  <Send className="w-4.5 h-4.5" />
                  Send Message
                </Button>
                <p className="text-xs text-muted-foreground text-center">
                  We respond within 24 hours. No spam, ever.
                </p>
              </motion.form>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}
