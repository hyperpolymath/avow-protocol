;; STAMP Protocol - Meta-Level Information
;; SPDX-License-Identifier: AGPL-3.0-or-later

(meta
  (version "1.0")
  (schema-version "1.0.0")
  (created 1738252800)
  (updated 1738267200)

  (architecture-decisions
    (adr
      (id "adr-001")
      (title "Use Idris2 for ABI definitions")
      (status "accepted")
      (date 1738252800)
      (context
        "Need formal verification of message compliance properties. Traditional languages (Rust, Haskell) can only test, not prove. Dependent types in Idris2 enable compile-time proofs.")
      (decision
        "Use Idris2 for all ABI definitions with dependent type proofs. Generate C headers for FFI compatibility.")
      (consequences
        "POSITIVE: Mathematical guarantees impossible in other languages. Code won't compile if proofs fail. Competitive moat (dependent types expertise rare).

         NEGATIVE: Smaller ecosystem than Rust/Go. Steeper learning curve. Slower compilation.

         MITIGATION: Use Zig FFI layer for performance. Provide high-level bindings in popular languages."))

    (adr
      (id "adr-002")
      (title "Zig for FFI implementation")
      (status "accepted")
      (date 1738252800)
      (context
        "Need C-compatible FFI for broad language support. Options: C, Zig, Rust FFI.")
      (decision
        "Use Zig for FFI implementation. Native C ABI compatibility, memory-safe, cross-compilation built-in.")
      (consequences
        "POSITIVE: Simpler than Rust FFI. Faster than C. Zero-cost abstractions. Excellent cross-platform support.

         NEGATIVE: Zig still evolving (0.13.0). Smaller ecosystem than Rust.

         MITIGATION: Pin exact Zig version. Test on all target platforms. Use stable Zig features only."))

    (adr
      (id "adr-003")
      (title "Transport-agnostic architecture")
      (status "accepted")
      (date 1738252800)
      (context
        "Initial idea focused on email spam. Realized potential extends to social media, SMS, any messaging.")
      (decision
        "Design STAMP as transport-agnostic verification library. Works for email, Telegram, Twitter, Reddit, any platform.")
      (consequences
        "POSITIVE: Much larger market ($1.4B+ vs $200M). Single codebase for all integrations. Network effects across platforms.

         NEGATIVE: More complex design. Harder to explain. Need platform-specific adapters.

         MITIGATION: Start with one platform (Telegram) as proof-of-concept. Document adapter pattern clearly."))

    (adr
      (id "adr-004")
      (title "Mock implementation for MVP")
      (status "accepted")
      (date 1738252800)
      (context
        "Zig FFI had version compatibility issues. Week 1 goal: working demo.")
      (decision
        "Use mock verification library (TypeScript) for Telegram bot MVP. Replace with real libstamp in Week 2.")
      (consequences
        "POSITIVE: Unblocked deployment. Got working demo in Week 1. Validated UX before full implementation.

         NEGATIVE: Mocks don't provide real formal verification. Need to swap out later.

         MITIGATION: Keep mock interface identical to real library. Plan Week 2 for real integration."))

    (adr
      (id "adr-005")
      (title "Dating apps as first customer")
      (status "accepted")
      (date 1738252800)
      (context
        "Need customer with urgent pain point, fast decisions, willingness to pay. Options: email providers, social media platforms, dating apps.")
      (decision
        "Target dating apps for first customer (Weeks 9-20 pilot). Fake profiles are existential threat, measurable impact.")
      (consequences
        "POSITIVE: Safety-critical market. Fast decision-making. Clear success metric (fake profile %). PR-friendly angle.

         NEGATIVE: Smaller market than social media. Need platform-specific integration work.

         MITIGATION: Choose as proof-of-concept. Use case study for larger platforms. Dating app success → social media FOMO."))

    (adr
      (id "adr-006")
      (title "Inception go-to-market strategy")
      (status "accepted")
      (date 1738252800)
      (context
        "How to position STAMP to avoid being pigeonholed as 'email spam filter'.")
      (decision
        "Present narrow solution publicly (email compliance), build broad architecture (works everywhere), let customers discover broader applications themselves ('Inception approach').")
      (consequences
        "POSITIVE: Credible focused pitch. Platforms think broader use is their idea. Avoid 'sounds too ambitious' objection.

         NEGATIVE: May leave money on table. Harder to explain vision to investors.

         MITIGATION: Different pitch for investors (show full vision) vs customers (show narrow use case)."))

    (adr
      (id "adr-007")
      (title "AGPL-3.0 license")
      (status "accepted")
      (date 1738252800)
      (context
        "License choice impacts adoption, monetization, community, competitive moat.")
      (decision
        "Use AGPL-3.0-or-later for all STAMP code. Strong copyleft, network-use trigger.")
      (consequences
        "POSITIVE: Prevents AWS/Google from offering competing hosted service. Encourages paid licensing for proprietary use. Community contributions stay open.

         NEGATIVE: Some enterprises avoid AGPL. May slow adoption initially.

         MITIGATION: Offer commercial licenses for platforms needing proprietary integration. Emphasize hosted API option (bypass license concerns)."))

    (adr
      (id "adr-008")
      (title "Cloudflare Pages for website hosting")
      (status "accepted")
      (date 1738252800)
      (context
        "Need fast, reliable hosting for stamp-protocol.org. Options: Netlify, Vercel, Cloudflare Pages, self-host.")
      (decision
        "Use Cloudflare Pages with auto-deploy from GitHub.")
      (consequences
        "POSITIVE: Free tier sufficient. Global CDN. Auto-SSL. GitHub integration. DDoS protection included.

         NEGATIVE: Vendor lock-in. Some features require Cloudflare account.

         MITIGATION: Keep site static (portable). Use git as source of truth.")))

  (development-practices
    (code-style
      "Idris2: Follow dependent type best practices, all functions documented with type signatures and proofs"
      "Zig: Zig fmt for formatting, explicit error handling, no hidden control flow"
      "TypeScript/ReScript: Deno fmt, strict mode, no 'any' types"
      "Documentation: All public APIs documented, examples included")

    (security
      "All commits GPG-signed"
      "Dependencies pinned to exact versions"
      "Formal verification for critical paths"
      "Threat model updated quarterly"
      "Bug bounty program (when funded)")

    (testing
      "Idris2: Type-level proofs are tests (if it compiles, properties hold)"
      "Zig: Unit tests + integration tests"
      "TypeScript: Deno test for bot functionality"
      "End-to-end: Manual testing of Telegram bot")

    (versioning
      "Semantic versioning (SemVer 2.0)"
      "Major version: Breaking ABI/API changes"
      "Minor version: New features, backward compatible"
      "Patch version: Bug fixes"
      "Version 1.0 when first customer deployed")

    (documentation
      "AsciiDoc for long-form docs (roadmap, threat model, design)"
      "Markdown for quick guides (README, deployment)"
      "Scheme for checkpoint files (STATE.scm, ECOSYSTEM.scm, META.scm)"
      "Inline documentation in all source files")

    (branching
      "main: Stable, deployed code"
      "feature/*: Development branches"
      "No develop branch (continuous deployment)")

    (deployment
      "Telegram bot: Manually deployed (systemd service or screen)"
      "Website: Auto-deploy on git push (Cloudflare Pages)"
      "Library: Tagged releases, manual publish"))

  (design-rationale
    (why-dependent-types
      "Traditional testing can only check specific examples. Formal verification proves properties hold for ALL inputs. Dependent types make invalid states unrepresentable - you literally cannot compile code that violates verification requirements. This is STAMP's core innovation and competitive moat.")

    (why-not-blockchain
      "Blockchain adds complexity, cost, and centralization concerns without solving core problem. STAMP's innovation is formal verification, not decentralization. Cryptographic proofs don't need blockchain. Could integrate with blockchain identity systems if customers want it.")

    (why-start-with-telegram
      "Needed proof-of-concept platform. Telegram has: (1) Bot API (easy integration), (2) No approval process (fast iteration), (3) Privacy-conscious users (aligned values), (4) Free to use (no costs during development). Not target market, just proving ground.")

    (why-target-dating-apps
      "Dating apps have existential fake profile problem. 90% fake profiles on some platforms. Safety-critical (romance scams, catfishing). Users lose trust → platform dies. Measurable impact (fake profile %). Fast decision-making (startups, not slow enterprises). Willing to pay for safety. PR-friendly ('We protect our users'). Perfect first customer.")

    (why-social-media-matters
      "Email spam market is $200M+. Social media bot market is $1.2B+ (6x larger). Platforms spend $100M+/year fighting bots. Election interference, astroturfing, fake engagement erode trust. Advertisers lose confidence. This is where the real money and impact is. Email was starting point, but social media is endgame.")

    (why-formal-verification-matters
      "Every other anti-spam solution is a heuristic or AI model - cat-and-mouse game with spammers. STAMP provides mathematical proof. When you have a proof, the game is over. Spammers cannot bypass proofs, they can only work within the constraints (which make spam uneconomic). This is fundamental difference.")

    (why-open-source
      "Trust. Security cannot be proprietary ('security through obscurity fails'). Community contributions accelerate development. AGPL license prevents freeloading while encouraging adoption. Platforms more likely to adopt open standard than proprietary system. Academic credibility (Idris2 research community). Competitive moat is expertise, not secrecy."))

  (philosophy
    (principles
      "Mathematics over heuristics - Prove properties, don't test them"
      "Economics over whack-a-mole - Make spam unprofitable, not just harder"
      "Privacy over surveillance - Zero-knowledge proofs when possible"
      "Open over proprietary - AGPL-3.0, community-driven"
      "Simple over complex - Solve one problem well"
      "Pragmatic over perfect - Ship MVP, iterate based on feedback")

    (values
      "Rigor: Formal verification is non-negotiable"
      "Transparency: All proofs auditable"
      "Privacy: Minimize data collection"
      "Sustainability: Economic model that works long-term"
      "Impact: Actually eliminate spam, not just reduce it"))

  (future-vision
    "STAMP becomes the standard for verified messaging across all platforms. Just like HTTPS is now expected for websites, STAMP verification becomes expected for messaging platforms. Users demand 'Verified Human' badges. Platforms that don't adopt STAMP lose users to those that do. Spam/bots become economically unviable. Internet communication is trustworthy again."))
