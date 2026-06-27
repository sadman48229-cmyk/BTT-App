"use client";

import React, { useState, useCallback, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Star, ChevronLeft, ChevronRight, Quote } from "lucide-react";
import { Badge } from "@/components/ui/Badge";

const testimonials = [
  {
    name: "Sarah Chen",
    role: "Founder & CEO",
    company: "NexaCommerce",
    location: "Singapore",
    avatar: "SC",
    color: "#4361EE",
    rating: 5,
    text: "BizActivate didn't just build us a website. They built us a revenue engine. Within 90 days, we went from invisible to the top search result in our category, and our sales tripled. The team thinks like business owners, not order-takers.",
  },
  {
    name: "Marcus Thornton",
    role: "Managing Partner",
    company: "Thornton Law Group",
    location: "United States",
    avatar: "MT",
    color: "#7B2FBE",
    rating: 5,
    text: "I was skeptical about the ROI of a premium agency. Six months later, we have 12x more consultation requests and a brand that genuinely commands respect. BizActivate understood our market in a way no other agency ever has.",
  },
  {
    name: "Dr. Priya Sharma",
    role: "Medical Director",
    company: "Harmony Health Clinic",
    location: "Australia",
    avatar: "PS",
    color: "#06D6A0",
    rating: 5,
    text: "The AI chatbot alone books 40+ appointments per week without us lifting a finger. The website is absolutely stunning and our patients constantly comment on how professional we appear. Worth every dollar — and then some.",
  },
  {
    name: "James O'Brien",
    role: "Director",
    company: "BuildRight Construction",
    location: "United Kingdom",
    avatar: "JO",
    color: "#FFB703",
    rating: 5,
    text: "They transformed how we look online completely. Our competitors are still using websites from 2015 and we're getting project inquiries from across the country. The Google Ads campaign alone returned 6x our investment in the first month.",
  },
  {
    name: "Yuki Tanaka",
    role: "Co-Founder",
    company: "StyleHaven Asia",
    location: "Singapore",
    avatar: "YT",
    color: "#F72585",
    rating: 5,
    text: "We came to BizActivate as a small online store. 14 months later, we're a recognised brand with $2.8M in annual revenue. The team's strategy, creativity, and relentless execution made it possible. They're the best decision we've made.",
  },
];

export function Testimonials() {
  const [active, setActive] = useState(0);
  const [direction, setDirection] = useState(1);

  const next = useCallback(() => {
    setDirection(1);
    setActive((prev) => (prev + 1) % testimonials.length);
  }, []);

  const prev = useCallback(() => {
    setDirection(-1);
    setActive((prev) => (prev - 1 + testimonials.length) % testimonials.length);
  }, []);

  useEffect(() => {
    const timer = setInterval(next, 6000);
    return () => clearInterval(timer);
  }, [next]);

  return (
    <section className="section-padding relative overflow-hidden">
      {/* Decorative background */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="orb orb-blue absolute w-96 h-96 right-0 top-0 opacity-10" />
        <div className="orb orb-purple absolute w-64 h-64 left-0 bottom-0 opacity-10" />
      </div>

      <div className="container mx-auto container-padding relative z-10">
        {/* Header */}
        <div className="text-center mb-16">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="flex justify-center mb-4"
          >
            <Badge variant="gold">
              <Star className="w-3.5 h-3.5 fill-current" />
              Client Success Stories
            </Badge>
          </motion.div>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-4xl md:text-5xl lg:text-6xl text-foreground tracking-tight"
          >
            Clients Who{" "}
            <span className="gradient-text">Transformed</span>
          </motion.h2>
        </div>

        {/* Testimonial Carousel */}
        <div className="max-w-4xl mx-auto">
          <div className="relative min-h-[320px] md:min-h-[260px]">
            <AnimatePresence mode="wait" custom={direction}>
              <motion.div
                key={active}
                custom={direction}
                initial={{ opacity: 0, x: direction * 60 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: direction * -60 }}
                transition={{ duration: 0.4, ease: "easeInOut" }}
                className="glass rounded-3xl border border-white/10 p-8 md:p-12"
              >
                {/* Quote icon */}
                <Quote
                  className="w-10 h-10 mb-6 opacity-20"
                  style={{ color: testimonials[active].color }}
                />

                {/* Stars */}
                <div className="flex gap-1 mb-6">
                  {[...Array(testimonials[active].rating)].map((_, i) => (
                    <Star
                      key={i}
                      className="w-4 h-4 fill-amber-400 text-amber-400"
                    />
                  ))}
                </div>

                {/* Text */}
                <p className="text-lg md:text-xl text-foreground leading-relaxed mb-8 font-medium">
                  &ldquo;{testimonials[active].text}&rdquo;
                </p>

                {/* Author */}
                <div className="flex items-center gap-4">
                  <div
                    className="w-12 h-12 rounded-2xl flex items-center justify-center font-display font-bold text-white text-sm flex-shrink-0"
                    style={{ backgroundColor: testimonials[active].color }}
                  >
                    {testimonials[active].avatar}
                  </div>
                  <div>
                    <div className="font-display font-semibold text-foreground">
                      {testimonials[active].name}
                    </div>
                    <div className="text-sm text-muted-foreground">
                      {testimonials[active].role},{" "}
                      <span className="text-foreground font-medium">
                        {testimonials[active].company}
                      </span>{" "}
                      · {testimonials[active].location}
                    </div>
                  </div>
                </div>
              </motion.div>
            </AnimatePresence>
          </div>

          {/* Controls */}
          <div className="flex items-center justify-between mt-8">
            {/* Dots */}
            <div className="flex gap-2">
              {testimonials.map((_, i) => (
                <button
                  key={i}
                  onClick={() => {
                    setDirection(i > active ? 1 : -1);
                    setActive(i);
                  }}
                  className={`h-1.5 rounded-full transition-all duration-300 ${
                    i === active
                      ? "w-8 bg-primary"
                      : "w-1.5 bg-foreground/20 hover:bg-foreground/40"
                  }`}
                  aria-label={`Go to testimonial ${i + 1}`}
                />
              ))}
            </div>

            {/* Arrows */}
            <div className="flex gap-2">
              <button
                onClick={prev}
                className="w-10 h-10 rounded-xl glass border border-white/10 flex items-center justify-center text-muted-foreground hover:text-foreground hover:border-white/20 transition-all"
              >
                <ChevronLeft className="w-5 h-5" />
              </button>
              <button
                onClick={next}
                className="w-10 h-10 rounded-xl glass border border-white/10 flex items-center justify-center text-muted-foreground hover:text-foreground hover:border-white/20 transition-all"
              >
                <ChevronRight className="w-5 h-5" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
