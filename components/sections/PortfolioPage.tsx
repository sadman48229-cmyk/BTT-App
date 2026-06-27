"use client";

import React, { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Badge } from "@/components/ui/Badge";
import { ExternalLink, Layers } from "lucide-react";

const categories = ["All", "Website", "Brand", "E-commerce", "SaaS", "Local Business"];

const projects = [
  { title: "NexaCommerce Platform", category: "E-commerce", description: "Full-stack e-commerce with AI recommendations and automated marketing.", tags: ["Next.js", "AI", "Meta Ads"], color: "#4361EE", accent: "#4CC9F0" },
  { title: "Anderson Legal Group", category: "Website", description: "Authority website with lead generation and local SEO dominance.", tags: ["Next.js", "SEO", "Google Ads"], color: "#7B2FBE", accent: "#F72585" },
  { title: "Harmony Health Clinic", category: "Website", description: "Patient-centric healthcare website with AI booking automation.", tags: ["React", "AI Chatbot", "Local SEO"], color: "#06D6A0", accent: "#4CC9F0" },
  { title: "BuildRight Construction", category: "Brand", description: "Complete brand overhaul and premium website for a growing builder.", tags: ["Branding", "Website", "SEO"], color: "#FFB703", accent: "#FB8500" },
  { title: "StyleHaven Asia", category: "E-commerce", description: "Premium fashion e-commerce with influencer campaign integration.", tags: ["Shopify", "Meta Ads", "Email"], color: "#F72585", accent: "#7B2FBE" },
  { title: "CloudScale SaaS", category: "SaaS", description: "Product-led SaaS landing page with conversion rate optimization.", tags: ["Next.js", "Animation", "CRO"], color: "#4CC9F0", accent: "#4361EE" },
  { title: "The Lotus Restaurant", category: "Local Business", description: "Restaurant website with online ordering and local SEO strategy.", tags: ["Web", "Local SEO", "Google"], color: "#FFB703", accent: "#F72585" },
  { title: "VentureLab Startup", category: "Brand", description: "Startup brand identity from logo to investor pitch deck.", tags: ["Branding", "Pitch Deck", "Strategy"], color: "#7B2FBE", accent: "#4361EE" },
  { title: "PrimeRealty Group", category: "Website", description: "Premium real estate website with property showcase and lead CRM.", tags: ["Next.js", "CRM", "Automation"], color: "#4361EE", accent: "#06D6A0" },
];

export function PortfolioPage() {
  const [activeCategory, setActiveCategory] = useState("All");

  const filtered = activeCategory === "All"
    ? projects
    : projects.filter((p) => p.category === activeCategory);

  return (
    <section className="pt-36 pb-20">
      <div className="container mx-auto container-padding">
        <div className="text-center mb-14">
          <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} className="flex justify-center mb-5">
            <Badge variant="default">
              <Layers className="w-3.5 h-3.5" />
              Our Work
            </Badge>
          </motion.div>
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="font-display font-extrabold text-5xl md:text-6xl text-foreground mb-5 tracking-tight"
          >
            Work That <span className="gradient-text">Speaks</span>
          </motion.h1>
          <motion.p
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.2 }}
            className="text-lg text-muted-foreground max-w-xl mx-auto"
          >
            A curated selection of websites, brands, and campaigns that drove real business results.
          </motion.p>
        </div>

        {/* Filter */}
        <div className="flex flex-wrap justify-center gap-2 mb-12">
          {categories.map((cat) => (
            <button
              key={cat}
              onClick={() => setActiveCategory(cat)}
              className={`px-5 py-2 rounded-full text-sm font-semibold transition-all duration-200 ${
                activeCategory === cat
                  ? "brand-gradient text-white shadow-lg"
                  : "glass border border-border text-muted-foreground hover:text-foreground hover:border-white/20"
              }`}
            >
              {cat}
            </button>
          ))}
        </div>

        {/* Grid */}
        <motion.div layout className="grid md:grid-cols-2 lg:grid-cols-3 gap-5">
          <AnimatePresence>
            {filtered.map((project, i) => (
              <motion.div
                key={project.title}
                layout
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.95 }}
                transition={{ duration: 0.3, delay: i * 0.07 }}
                className="group rounded-2xl overflow-hidden border border-border hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 hover:shadow-xl"
              >
                {/* Image area */}
                <div
                  className="h-48 relative overflow-hidden flex items-center justify-center"
                  style={{ background: `linear-gradient(135deg, ${project.color}20, ${project.accent}10)` }}
                >
                  <span className="font-display font-extrabold text-7xl opacity-10 text-foreground">
                    {project.title.charAt(0)}
                  </span>
                  <div className="absolute top-4 right-4">
                    <Badge variant="glass">{project.category}</Badge>
                  </div>
                  <button className="absolute inset-0 flex items-center justify-center bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <div className="w-12 h-12 rounded-xl bg-white/10 border border-white/20 flex items-center justify-center backdrop-blur-sm">
                      <ExternalLink className="w-5 h-5 text-white" />
                    </div>
                  </button>
                </div>

                <div className="p-6">
                  <h3 className="font-display font-bold text-lg text-foreground mb-1.5">{project.title}</h3>
                  <p className="text-sm text-muted-foreground mb-4 leading-relaxed">{project.description}</p>
                  <div className="flex flex-wrap gap-1.5">
                    {project.tags.map((tag) => (
                      <span key={tag} className="text-xs px-2.5 py-1 rounded-full bg-foreground/5 text-muted-foreground border border-border">
                        {tag}
                      </span>
                    ))}
                  </div>
                </div>
              </motion.div>
            ))}
          </AnimatePresence>
        </motion.div>
      </div>
    </section>
  );
}
