#!/usr/bin/env -S deno run --allow-net --allow-read --allow-env --allow-run
// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell
//
// Deno-native Cloudflare Pages deployment script

const CLOUDFLARE_API_TOKEN = Deno.env.get("CLOUDFLARE_API_TOKEN");
const CLOUDFLARE_ACCOUNT_ID = Deno.env.get("CLOUDFLARE_ACCOUNT_ID");

if (!CLOUDFLARE_API_TOKEN) {
  console.error("❌ CLOUDFLARE_API_TOKEN environment variable required");
  Deno.exit(1);
}

if (!CLOUDFLARE_ACCOUNT_ID) {
  console.error("❌ CLOUDFLARE_ACCOUNT_ID environment variable required");
  console.log("\n💡 Get your account ID from: https://dash.cloudflare.com/ (right sidebar)");
  Deno.exit(1);
}

console.log("🚀 AVOW Protocol - Deno Cloudflare Deployment");
console.log("═".repeat(50));

// Step 1: Build project
console.log("\n📦 Building project...");
const build = await new Deno.Command("deno", {
  args: ["task", "build"],
  stdout: "inherit",
  stderr: "inherit",
}).output();

if (!build.success) {
  console.error("❌ Build failed");
  Deno.exit(1);
}
console.log("✅ Build successful");

// Step 2: Create project (if doesn't exist)
console.log("\n🔧 Checking Cloudflare Pages project...");

const checkProject = await fetch(
  `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects/avow-protocol`,
  {
    headers: {
      "Authorization": `Bearer ${CLOUDFLARE_API_TOKEN}`,
      "Content-Type": "application/json",
    },
  }
);

if (!checkProject.ok) {
  console.log("📝 Creating new Pages project...");
  const createProject = await fetch(
    `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects`,
    {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${CLOUDFLARE_API_TOKEN}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name: "avow-protocol",
        production_branch: "main",
        build_config: {
          build_command: "deno task build",
          destination_dir: ".",
          root_dir: "/",
        },
      }),
    }
  );

  const result = await createProject.json();
  if (result.success) {
    console.log("✅ Project created");
  } else {
    console.error("❌ Failed to create project:", result.errors);
    Deno.exit(1);
  }
} else {
  console.log("✅ Project exists");
}

// Step 3: Create deployment
console.log("\n🚀 Creating deployment...");

// Note: Direct file upload via API requires creating a tarball and uploading
// For now, provide instructions for completing via dashboard or GitHub integration

console.log("\n" + "═".repeat(50));
console.log("✅ Project configured on Cloudflare!");
console.log("\n📋 Next steps to complete deployment:\n");

console.log("Option 1: Deploy via GitHub Integration (Recommended)");
console.log("  1. Go to: https://dash.cloudflare.com/pages");
console.log("  2. Find 'avow-protocol' project");
console.log("  3. Click 'Connect to Git'");
console.log("  4. Select: hyperpolymath/avow-protocol");
console.log("  5. Cloudflare will auto-deploy on push to main\n");

console.log("Option 2: Deploy via Wrangler CLI");
console.log("  1. Install: npm install -g wrangler");
console.log("  2. Deploy: wrangler pages deploy .\n");

console.log("Option 3: Manual Upload");
console.log("  1. Go to: https://dash.cloudflare.com/pages");
console.log("  2. Upload files directly via dashboard\n");

console.log("🌐 Your site will be available at:");
console.log("   https://avow-protocol.pages.dev");
console.log("   https://avow-protocol.org (after DNS setup)");

console.log("\n📚 Complete setup guide: CLOUDFLARE-MANUAL-SETUP.md");
console.log("═".repeat(50));
