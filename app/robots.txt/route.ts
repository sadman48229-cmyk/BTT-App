import { NextResponse } from "next/server";

export async function GET() {
  const content = `User-agent: *
Allow: /

Sitemap: https://bizactivate.com/sitemap.xml

# Block AI scrapers
User-agent: GPTBot
Disallow: /

User-agent: CCBot
Disallow: /

User-agent: Google-Extended
Disallow: /
`;

  return new NextResponse(content, {
    headers: {
      "Content-Type": "text/plain",
      "Cache-Control": "public, max-age=86400",
    },
  });
}
