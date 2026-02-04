;; STAMP Protocol - Ecosystem Position
;; SPDX-License-Identifier: AGPL-3.0-or-later

(ecosystem
  (version "1.0")
  (name "STAMP Protocol")
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
      (description "Formally verified library for URL validation, used in STAMP website"))

    (project
      (name "libstamp")
      (url "https://github.com/hyperpolymath/libstamp")
      (relationship "core-component")
      (description "Core STAMP verification library (Idris2 ABI + Zig FFI)"))

    (project
      (name "stamp-telegram-bot")
      (url "https://github.com/hyperpolymath/stamp-telegram-bot")
      (relationship "reference-implementation")
      (description "Telegram bot demonstrating STAMP Protocol (@stamp_demo_bot)"))

    (project
      (name "stamp-website")
      (url "https://github.com/hyperpolymath/stamp-website")
      (relationship "documentation-and-demo")
      (description "Interactive website at stamp-protocol.org"))

    (project
      (name "CAN-SPAM Act")
      (url "https://www.ftc.gov/business-guidance/resources/can-spam-act-compliance-guide-business")
      (relationship "regulatory-compliance")
      (description "STAMP provides cryptographic proof of compliance"))

    (project
      (name "GDPR")
      (url "https://gdpr.eu")
      (relationship "regulatory-compliance")
      (description "STAMP proves consent requirements (GDPR Articles 6, 7)"))

    (project
      (name "EU Digital Services Act")
      (url "https://digital-strategy.ec.europa.eu/en/policies/digital-services-act-package")
      (relationship "regulatory-compliance")
      (description "STAMP addresses bot/fake account requirements (Articles 24, 34)"))

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
      (description "Service validation patterns influenced STAMP design")))

  (what-this-is
    "STAMP (Secure Typed Announcement Messaging Protocol) is a transport-agnostic verification library that uses dependent types to mathematically prove message compliance properties. It's NOT a messaging platform itself - it's a verification layer that platforms integrate."

    "Key innovation: Code literally won't compile if verification requirements aren't met. This is impossible with traditional testing approaches."

    "Target markets: Dating apps ($3B+), social media bot defense ($1.2B+), email compliance ($200M+).")

  (what-this-is-not
    "NOT a messaging app/platform (it's a library)"
    "NOT a testing framework (it's formal verification)"
    "NOT specific to email (works for any messaging protocol)"
    "NOT a blockchain/crypto project (though could integrate)"
    "NOT a manual review system (fully automated proofs)"
    "NOT a heuristic/ML approach (mathematical guarantees)"))
