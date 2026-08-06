#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Deploy all repos to Cloudflare Pages

# Authentication is via `wrangler login` (OAuth), NOT an API token.
# Run it once; wrangler stores the session under ~/.config/.wrangler/.
# Do not reintroduce `export CLOUDFLARE_API_TOKEN=...` here — a token in a
# tracked file is a published credential, and this repository is public.
#
# The account id below is NOT a secret: Cloudflare treats it as an ordinary
# identifier and it appears in dashboard URLs. It is kept because this login
# can see more than one account.
export CLOUDFLARE_ACCOUNT_ID="b72dd54ed3ee66088950c82e0301edbb"

REPOS_DIR="$HOME/Documents/hyperpolymath-repos"

declare -A PROJECTS=(
  [affinescript]="affinescript"
  [anvomidav]="anvomidav"
  [betlang]="betlang"
  [eclexia]="eclexia"
  [ephapax]="ephapax"
  [error-lang]="error-lang"
  [my-lang]="my-lang"
  [oblibeny]="oblibeny"
  [reposystem]="reposystem"
  [verisimdb]="verisimdb"
)

echo "🚀 Deploying repos to Cloudflare Pages"
echo "═══════════════════════════════════════════════════════════════════"

for project in "${!PROJECTS[@]}"; do
  repo="${PROJECTS[$project]}"
  repo_path="$REPOS_DIR/$repo"

  echo ""
  echo "📦 $project"

  if [ ! -d "$repo_path" ]; then
    echo "   ❌ Repo not found: $repo_path"
    continue
  fi

  echo "   📤 Deploying from $repo..."

  cd "$repo_path" || continue

  bunx wrangler pages deploy . --project-name="$project" --branch=main 2>&1 | grep -E "✨|Deployment complete|View your site"

  if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "   ✅ Deployed successfully"
  else
    echo "   ⚠️  Deployment completed (check output)"
  fi
done

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "✅ Deployment batch complete!"
echo ""
echo "📋 Next: Check deployment status at https://dash.cloudflare.com/pages"
echo "═══════════════════════════════════════════════════════════════════"
