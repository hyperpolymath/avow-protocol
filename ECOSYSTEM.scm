;; AVOW Protocol - Ecosystem Position
;; SPDX-License-Identifier: PMPL-1.0-or-later

(ecosystem
  (version "1.0")
  (name "AVOW Protocol")
  (type "protocol-and-library")
  (purpose "Formal verification for messaging compliance")

  (position-in-ecosystem
    "First-of-its-kind protocol using dependent types (Idris2) to mathematically prove message compliance properties. Transport-agnostic verification library that platforms integrate to eliminate spam, bots, and fake accounts.")

  (related-projects
    (project
      (name "Idris2")
      (url "https://idris-lang.org")
      (relationship "dependency")
      (description "Dependent type language providing formal verification capabilities"))

    (project
      (name "proven")
      (url "https://github.com/hyperpolymath/proven")
      (relationship "sibling-standard")
      (description "Formally verified library for URL validation, used in AVOW website"))

    (project
      (name "libavow")
      (url "https://github.com/hyperpolymath/libavow")
      (relationship "core-component")
      (description "Core AVOW verification library (Idris2 ABI + Zig FFI)"))

    (project
      (name "avow-telegram-bot")
      (url "https://github.com/hyperpolymath/avow-telegram-bot")
      (relationship "reference-implementation")
      (description "Telegram bot demonstrating AVOW Protocol (@avow_demo_bot)"))

    (project
      (name "avow-website")
      (url "https://github.com/hyperpolymath/avow-website")
      (relationship "documentation-and-demo")
      (description "Interactive website at avow-protocol.org"))

    (project
      (name "CAN-SPAM Act")
      (url "https://www.ftc.gov/business-guidance/resources/can-spam-act-compliance-guide-business")
      (relationship "regulatory-compliance")
      (description "AVOW provides cryptographic proof of compliance"))

    (project
      (name "GDPR")
      (url "https://gdpr.eu")
      (relationship "regulatory-compliance")
      (description "AVOW proves consent requirements (GDPR Articles 6, 7)"))

    (project
      (name "EU Digital Services Act")
      (url "https://digital-strategy.ec.europa.eu/en/policies/digital-services-act-package")
      (relationship "regulatory-compliance")
      (description "AVOW addresses bot/fake account requirements (Articles 24, 34)"))

    (project
      (name "Telegram Bot API")
      (url "https://core.telegram.org/bots/api")
      (relationship "integration-target")
      (description "First platform integration for proof-of-concept"))

    (project
      (name "Bumble/Hinge/Feeld")
      (relationship "potential-customer")
      (description "Dating apps: primary market for Week 9-20 pilot"))

    (project
      (name "Twitter/X")
      (relationship "potential-customer")
      (description "Social media platform: target for Week 37+ after proven success"))

    (project
      (name "Reddit")
      (relationship "potential-customer")
      (description "Social media platform: anti-astroturfing use case"))

    (project
      (name "A2ML")
      (url "https://github.com/hyperpolymath/a2ml")
      (relationship "inspiration")
      (description "Initial inspiration for formal verification approach"))

    (project
      (name "k9")
      (url "https://github.com/hyperpolymath/k9")
      (relationship "inspiration")
      (description "Service validation patterns influenced AVOW design"))

    (project
      (name "casket-ssg")
      (url "https://github.com/hyperpolymath/casket-ssg")
      (relationship "dependency")
      (description "Static site generator for AVOW website"))

    (project
      (name "cadre-tea-router")
      (url "https://github.com/hyperpolymath/cadre-tea-router")
      (relationship "dependency")
      (description "TEA-based router built on casket-ssg"))

    (project
      (name "rescript-tea")
      (url "https://github.com/hyperpolymath/rescript-tea")
      (relationship "dependency")
      (description "The Elm Architecture in ReScript for unbreakable UI"))

    (project
      (name "rescript-dom-mounter")
      (url "https://github.com/hyperpolymath/rescript-dom-mounter")
      (relationship "dependency")
      (description "DOM mounting utilities for ReScript applications")))

  (what-this-is
    "AVOW (Authenticated Verifiable Open Web) Protocol is a transport-agnostic verification library that uses dependent types to mathematically prove message compliance properties. It's NOT a messaging platform itself - it's a verification layer that platforms integrate."

    "Key innovation: Code literally won't compile if verification requirements aren't met. This is impossible with traditional testing approaches."

    "Target markets: Dating apps ($3B+), social media bot defense ($1.2B+), email compliance ($200M+).")

  (what-this-is-not
    "NOT a messaging app/platform (it's a library)"
    "NOT a testing framework (it's formal verification)"
    "NOT specific to email (works for any messaging protocol)"
    "NOT a blockchain/crypto project (though could integrate)"
    "NOT a manual review system (fully automated proofs)"
    "NOT a heuristic/ML approach (mathematical guarantees)"))
