import type { Metadata } from "next";
import { BookCallPage } from "@/components/sections/BookCallPage";

export const metadata: Metadata = {
  title: "Book a Free Strategy Call — BizActivate",
  description:
    "Book a free 45-minute strategy call with BizActivate. We'll analyse your business and create a custom growth roadmap for you.",
};

export default function BookCall() {
  return <BookCallPage />;
}
