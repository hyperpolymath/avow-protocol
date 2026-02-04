// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell
//
// AVOW Protocol - Main Entry Point
// Initializes the application with post-quantum cryptography and formally verified DOM mounting

// Initialize application on DOM ready
let init = (): unit => {
  Console.log("🚀 Initializing AVOW Protocol...")
  Console.log("📜 License: PMPL-1.0-or-later")
  Console.log("🔐 Crypto: Dilithium5-AES, Kyber-1024, SHAKE3-512")

  // Mount application using formally verified DOM mounter
  AvowSafeMount.mountApp()
}

// Run init when DOM is ready
switch Webapi.Dom.document->Webapi.Dom.Document.readyState {
| "loading" =>
    Webapi.Dom.document->Webapi.Dom.Document.addEventListener(
      "DOMContentLoaded",
      _ => init()
    )
| _ => init()
}
