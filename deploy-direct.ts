#!/usr/bin/env -S deno run --allow-net --allow-read --allow-env --allow-run --allow-write
// SPDX-License-Identifier: PMPL-1.0-or-later
// Direct file upload deployment to Cloudflare Pages

import { walk } from "https://deno.land/std@0.208.0/fs/walk.ts";
import { relative } from "https://deno.land/std@0.208.0/path/mod.ts";

const CLOUDFLARE_API_TOKEN = Deno.env.get("CLOUDFLARE_API_TOKEN");
const CLOUDFLARE_ACCOUNT_ID = Deno.env.get("CLOUDFLARE_ACCOUNT_ID");
const PROJECT_NAME = "avow-protocol";

if (!CLOUDFLARE_API_TOKEN || !CLOUDFLARE_ACCOUNT_ID) {
  console.error("❌ Missing credentials");
  Deno.exit(1);
}

console.log("🚀 Direct Deployment to Cloudflare Pages");
console.log("═".repeat(50));

// Step 1: Build
console.log("\n📦 Building project...");
const build = await new Deno.Command("deno", {
  args: ["task", "build"],
  stdout: "piped",
  stderr: "piped",
}).output();

if (!build.success) {
  console.error("❌ Build failed");
  console.error(new TextDecoder().decode(build.stderr));
  Deno.exit(1);
}
console.log("✅ Build successful");

// Step 2: Create tarball of files
console.log("\n📦 Packaging files...");

const files: Record<string, string> = {};
const filesToInclude = [
  "index.html",
  "style.css",
  "favicon.svg",
  "_headers",
  "cloudflare-dns-zone.txt",
];

// Add src/*.res.js files
for await (const entry of walk("./src", { exts: [".js"] })) {
  if (entry.isFile && entry.name.endsWith(".res.js")) {
    const content = await Deno.readTextFile(entry.path);
    const relativePath = relative(".", entry.path);
    files[relativePath] = content;
  }
}

// Add other files
for (const file of filesToInclude) {
  try {
    const content = await Deno.readTextFile(file);
    files[file] = content;
  } catch {
    console.log(`⚠️  Skipping ${file} (not found)`);
  }
}

console.log(`✅ Packaged ${Object.keys(files).length} files`);

// Step 3: Create deployment
console.log("\n🚀 Creating deployment...");

const deploymentResponse = await fetch(
  `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects/${PROJECT_NAME}/deployments`,
  {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${CLOUDFLARE_API_TOKEN}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      branch: "main",
      files: files,
    }),
  }
);

const result = await deploymentResponse.json();

if (result.success) {
  console.log("\n" + "═".repeat(50));
  console.log("✅ DEPLOYMENT SUCCESSFUL!");
  console.log("═".repeat(50));
  console.log(`\n🌐 Your site is live at:`);
  console.log(`   ${result.result.url}`);
  console.log(`\n🔗 Production URL:`);
  console.log(`   https://${PROJECT_NAME}.pages.dev`);
  console.log(`\n📊 Deployment ID: ${result.result.id}`);
  console.log(`\n⏱️  Build started at: ${new Date(result.result.created_on).toLocaleString()}`);
  console.log("\n" + "═".repeat(50));
} else {
  console.error("\n❌ Deployment failed:");
  console.error(JSON.stringify(result.errors, null, 2));
  Deno.exit(1);
}
