<!--
SPDX-License-Identifier: CC-BY-SA-4.0
SPDX-FileCopyrightText: 2025-2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->

[![Idris Inside](https://img.shields.io/badge/Idris-Inside-5E5086?style=flat&amp;logo=idris&amp;logoColor=white)](https://github.com/hyperpolymath/proven) ![Protocol
Draft](https://img.shields.io/badge/Protocol-Draft-blue)

Reference site and interactive demo for the **AVOW Protocol**—a
high-assurance standard for secure subscriber attribution and spam
prevention.

<div id="toc">

</div>

# Introduction

The **AVOW Protocol** (**A**ttributed **V**erification of **O**rigin
**W**illingness) is designed to solve the "Spam vs. Ham" problem at the
architectural level. Unlike traditional opt-in systems that rely on
easily spoofed headers, AVOW uses formal mathematical proofs to ensure
that every message is both **attributed** to a known source and
**willed** by the recipient.

# Core Concepts

The protocol moves beyond simple "Opt-in" logic by verifying the
relationship between the message source and the receiver’s intent.

## 1. Attributed Origin

Every message or subscription event must carry a cryptographic proof of
its source. This eliminates "ghost" subscriptions and sender spoofing.

## 2. Origin Willingness

Willingness is not a static state but a verified property of the
communication channel. A message is classified as **Ham** only if the
recipient has an active, proven "willingness token" for that specific
**Origin**.

## 3. The Spam-Ham Determinant

A communication is rejected as **Spam** if: \* The **Origin** cannot be
cryptographically attributed. \* The **Willingness** proof has expired
or was never issued. \* The state transition violates the formally
verified workflow.

# Formal Logic (The AVOW Proof)

Using the `proven` library (Idris2), we define the validity of a
communication state through the following theorem:

```math
V(m) \iff A(o) \land W(r, o)
```

Where: \* \$V(m)\$ is the validity of the message. \* \$A(o)\$ is the
successful **Attribution** of the Origin \$o\$. \* \$W(r, o)\$ is the
**Willingness** of the recipient \$r\$ to accept \$o\$.

# Technical Stack

- **Logic Engine:** ReScript 12 + TEA (The Elm Architecture)

- **Verification:** `proven` (Idris2) for structural integrity of state
  and URLs.

- **Security:** Enforced HTTPS and Content Security Policies (CSP) via
  `.well-known/` standards.

# Project Structure

```text
avow-protocol/
├── src/
│   ├── AvowApp.res         # Core Logic & State Machine
│   ├── OriginProof.res     # Attribution logic
│   └── ProvenSafeUrl.res   # Idris2-backed URL proofs
├── docs/
│   └── PROTOCOL.adoc       # Full mathematical specification
└── .well-known/            # RFC 9116 & Protocol discovery
```

# Implementation Status

- [x] **Origin Attribution:** Cryptographic binding of senders.

- [x] **Formal URL Validation:** Zero-runtime-error URL parsing.

- [ ] **Willingness State Machine:** Full TEA implementation of consent
  lifecycles.

- [ ] **Spam/Ham Heuristics:** Proof-based filtering demo.

# License

MPL-2.0
