<!--
SPDX-License-Identifier: MPL-2.0
SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell (hyperpolymath)
-->

# Changelog

All notable changes to `avow-protocol` will be documented in this file.

This file is generated from conventional commits by the
[`changelog-reusable.yml`](https://github.com/hyperpolymath/standards/blob/main/.github/workflows/changelog-reusable.yml)
workflow (`hyperpolymath/standards#206`). Adopt the workflow in this repo's CI to keep this file in sync automatically — see
[`templates/cliff.toml`](https://github.com/hyperpolymath/standards/blob/main/templates/cliff.toml)
for the canonical config.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/);
this project aims to follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- feat: absorb avow-telegram-bot as telegram-bot/ subdirectory
- feat: deploy 10 projects to Cloudflare Pages with custom domains
- feat: add custom domain setup script for all three sites
- feat: successful Cloudflare Pages deployment
- feat: add Deno-native deployment script and quick deploy guide
- feat: add Cloudflare deployment configuration and scripts
- feat: rebrand to AVOW Protocol and implement complete formally verified architecture
- feat: add critical security workflows
- feat: integrate k9-svc and A2ML into stamp-website
- feat: complete proven integration and documentation

### Fixed

- fix(ci): sync hypatia-scan.yml to canonical (413: env.HOME+Phase-2+SARIF) (#3)
- fix(ci): adopt canonical hypatia-scan.yml (env.HOME/scanner-layout + Comment-step gate) (#1)
- fix: apply safety triangle fixes (recipe-remove-believe-me)
- fix: update license from MPL-2.0 to PMPL-1.0-or-later
- fix: remove duplicate SCM files from root
- fix: use Deno setup action and task runner for ReScript build
- fix: use original HTML with full styling
- fix: install Pandoc in workflow

### Changed

- refactor: replace all TypeScript with ReScript

### Documentation

- docs: add deployment success report for all three sites
- docs: add DNS zone file for stamp-protocol.org

## Pre-history

Prior commits to this file's introduction are recorded in git history but not formally classified into Keep-a-Changelog sections. To backfill, run `git cliff -o CHANGELOG.md` locally using the canonical [`cliff.toml`](https://github.com/hyperpolymath/standards/blob/main/templates/cliff.toml) — this is one-shot mechanical work.

---

<!-- This file was seeded by the 2026-05-26 estate tech-debt audit follow-up (Row-2 Phase 3); see [`hyperpolymath/standards/docs/audits/2026-05-26-estate-documentation-debt.md`](https://github.com/hyperpolymath/standards/blob/main/docs/audits/2026-05-26-estate-documentation-debt.md). -->
