#!/usr/bin/env -S deno run --allow-net --allow-read --allow-env
// SPDX-License-Identifier: PMPL-1.0-or-later
// Configure custom domains for Cloudflare Pages projects

const CLOUDFLARE_API_TOKEN = Deno.env.get("CLOUDFLARE_API_TOKEN");
const CLOUDFLARE_ACCOUNT_ID = Deno.env.get("CLOUDFLARE_ACCOUNT_ID");

if (!CLOUDFLARE_API_TOKEN || !CLOUDFLARE_ACCOUNT_ID) {
  console.error("❌ Missing credentials");
  Deno.exit(1);
}

const projects = [
  { name: "avow-protocol", domains: ["avow-protocol.org", "www.avow-protocol.org"] },
  { name: "a2ml", domains: ["a2ml.org", "www.a2ml.org"] },
  { name: "k9-svc", domains: ["k9-svc.org", "www.k9-svc.org"] },
];

console.log("🌐 Setting up custom domains for Cloudflare Pages");
console.log("═".repeat(60));

for (const project of projects) {
  console.log(`\n📋 Project: ${project.name}`);

  for (const domain of project.domains) {
    console.log(`\n  🔧 Adding domain: ${domain}`);

    const response = await fetch(
      `https://api.cloudflare.com/client/v4/accounts/${CLOUDFLARE_ACCOUNT_ID}/pages/projects/${project.name}/domains`,
      {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${CLOUDFLARE_API_TOKEN}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: domain,
        }),
      }
    );

    const result = await response.json();

    if (result.success) {
      console.log(`  ✅ Domain added: ${domain}`);
      console.log(`  📊 Status: ${result.result.status || "pending"}`);

      // Show DNS records needed
      if (result.result.validation_data && Array.isArray(result.result.validation_data)) {
        console.log(`  📝 DNS Records needed:`);
        for (const record of result.result.validation_data) {
          console.log(`     ${record.type} ${record.name} → ${record.value}`);
        }
      }
    } else {
      if (result.errors?.[0]?.code === 1004) {
        console.log(`  ⚠️  Domain already added: ${domain}`);
      } else {
        console.log(`  ❌ Failed: ${JSON.stringify(result.errors)}`);
      }
    }
  }
}

console.log("\n" + "═".repeat(60));
console.log("✅ Domain setup complete!");
console.log("\n📋 Next steps:");
console.log("1. DNS records will be auto-configured by Cloudflare");
console.log("2. Wait 1-5 minutes for activation");
console.log("3. Verify at: https://dash.cloudflare.com/pages");
console.log("\n🌐 Your sites will be available at:");
for (const project of projects) {
  console.log(`   https://${project.domains[0]}`);
}
console.log("═".repeat(60));
