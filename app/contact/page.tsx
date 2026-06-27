import type { Metadata } from "next";
import { ContactPage } from "@/components/sections/ContactPage";

export const metadata: Metadata = {
  title: "Contact BizActivate — Let's Talk Business",
  description:
    "Get in touch with the BizActivate team. Reach us for project inquiries, partnerships, or general questions.",
};

export default function Contact() {
  return <ContactPage />;
}
