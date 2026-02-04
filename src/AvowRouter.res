// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell
//
// AVOW Protocol - Router Definitions
// Using cadre-router and cadre-tea-router for type-safe routing

// Route definitions using cadre-router primitives
module Routes = {
  // Root route: /
  let home = CadreRouter.root

  // About route: /about
  let about = CadreRouter.s("about")

  // Documentation routes: /docs/*
  let docs = CadreRouter.s("docs")
  let docsProtocol = CadreRouter.s("docs") / CadreRouter.s("protocol")
  let docsImplementation = CadreRouter.s("docs") / CadreRouter.s("implementation")
  let docsSecurity = CadreRouter.s("docs") / CadreRouter.s("security")

  // Demo route: /demo
  let demo = CadreRouter.s("demo")

  // Verification route: /verify/:messageId
  let verify = CadreRouter.s("verify") / CadreRouter.string
}

// Route types for TEA pattern matching
type route =
  | Home
  | About
  | Docs
  | DocsProtocol
  | DocsImplementation
  | DocsSecurity
  | Demo
  | Verify(string)
  | NotFound

// Parse URL to route
let parseRoute = (url: string): route => {
  open Routes
  switch url {
  | url if CadreRouter.matches(home, url) => Home
  | url if CadreRouter.matches(about, url) => About
  | url if CadreRouter.matches(docs, url) => Docs
  | url if CadreRouter.matches(docsProtocol, url) => DocsProtocol
  | url if CadreRouter.matches(docsImplementation, url) => DocsImplementation
  | url if CadreRouter.matches(docsSecurity, url) => DocsSecurity
  | url if CadreRouter.matches(demo, url) => Demo
  | url =>
      switch CadreRouter.parse(verify, url) {
      | Some(messageId) => Verify(messageId)
      | None => NotFound
      }
  }
}

// Format route to URL
let formatRoute = (route: route): string => {
  open Routes
  switch route {
  | Home => CadreRouter.format(home, ())
  | About => CadreRouter.format(about, ())
  | Docs => CadreRouter.format(docs, ())
  | DocsProtocol => CadreRouter.format(docsProtocol, ())
  | DocsImplementation => CadreRouter.format(docsImplementation, ())
  | DocsSecurity => CadreRouter.format(docsSecurity, ())
  | Demo => CadreRouter.format(demo, ())
  | Verify(messageId) => CadreRouter.format(verify, messageId)
  | NotFound => "/"
  }
}

// Route to human-readable title
let routeTitle = (route: route): string => {
  switch route {
  | Home => "AVOW Protocol - Authenticated Verifiable Open Web"
  | About => "About AVOW Protocol"
  | Docs => "Documentation"
  | DocsProtocol => "Protocol Specification"
  | DocsImplementation => "Implementation Guide"
  | DocsSecurity => "Security Model"
  | Demo => "Interactive Demo"
  | Verify(messageId) => `Verify Message: ${messageId}`
  | NotFound => "Page Not Found"
  }
}
