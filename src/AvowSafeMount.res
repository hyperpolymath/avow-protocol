// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2026 Jonathan D.A. Jewell
//
// AVOW Protocol - Safe DOM Mounting
// Using rescript-dom-mounter for formally verified mounting

open RescriptDomMounter

// Mount the AVOW TEA application safely
let mountApp = (): unit => {
  SafeDOM.mountSafe(
    "#avow-root",
    "",
    ~onSuccess=rootElement => {
      // Create React root and mount the TEA app
      switch ReactDOM.querySelector("#avow-root") {
      | Some(root) => {
          let reactRoot = ReactDOM.Client.createRoot(root)
          reactRoot->ReactDOM.Client.Root.render(<AvowTea.App flags=() />)
          Console.log("✅ AVOW Protocol mounted successfully")
        }
      | None => Console.error("❌ Failed to find root element")
      }
    },
    ~onError=err => {
      Console.error2("❌ Failed to mount AVOW Protocol:", err)
    }
  )
}

// Batch mount multiple elements safely
let mountBatch = (elements: array<(string, string)>): unit => {
  SafeDOM.mountBatch(
    elements,
    ~onSuccess=() => {
      Console.log("✅ All elements mounted successfully")
    },
    ~onError=err => {
      Console.error2("❌ Batch mount failed:", err)
    }
  )
}

// Validate selector before mounting
let validateSelector = (selector: string): bool => {
  SafeDOM.isValidSelector(selector)
}

// Validate HTML before mounting
let validateHTML = (html: string): bool => {
  SafeDOM.isWellFormedHTML(html)
}
