// SPDX-License-Identifier: PMPL-1.0-or-later
// STAMP Protocol - Interactive Demo
// With proven formally verified URL validation

open ProvenSafeUrl

// Demo state
type demoStep =
  | Initial
  | SubscribeRequest
  | ConsentProof
  | LinkValidation
  | Verified

type model = {
  step: demoStep,
  unsubscribeUrl: string,
  urlValid: bool,
}

type msg =
  | NextStep
  | ValidateUrl

// Initialize
let init = () => {
  let model = {
    step: Initial,
    unsubscribeUrl: "https://stamp-protocol.org/unsubscribe?token=abc123",
    urlValid: false,
  }
  model
}

// Update with proven URL validation
let update = (model: model, msg: msg) => {
  switch msg {
  | NextStep =>
      let nextStep = switch model.step {
      | Initial => SubscribeRequest
      | SubscribeRequest => ConsentProof
      | ConsentProof => LinkValidation
      | LinkValidation => Verified
      | Verified => Initial
      }

      // When entering LinkValidation, use ProvenSafeUrl to validate
      if nextStep == LinkValidation {
        switch parse(model.unsubscribeUrl) {
        | Ok(url) =>
            // Proven to be well-formed URL
            let valid = isHttps(model.unsubscribeUrl)
            {...model, step: nextStep, urlValid: valid}
        | Error(_) =>
            // Proven to be invalid URL
            {...model, step: nextStep, urlValid: false}
        }
      } else {
        {...model, step: nextStep}
      }

  | ValidateUrl =>
      // Explicitly validate URL using proven
      switch parse(model.unsubscribeUrl) {
      | Ok(_) => {...model, urlValid: true}
      | Error(_) => {...model, urlValid: false}
      }
  }
}

// Simple view (no TEA integration yet)
let render = (model: model) => {
  let stepName = switch model.step {
  | Initial => "Initial"
  | SubscribeRequest => "Subscribe Request"
  | ConsentProof => "Consent Proof"
  | LinkValidation => "Link Validation (ProvenSafeUrl)"
  | Verified => "Verified"
  }

  "STAMP Demo - Step: " ++ stepName ++
  " | URL Valid: " ++ (model.urlValid ? "✓" : "✗")
}
