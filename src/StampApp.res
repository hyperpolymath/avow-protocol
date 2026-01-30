// SPDX-License-Identifier: PMPL-1.0-or-later
// STAMP Protocol - TEA Interactive Demo
// With k9-svc validation and a2ml typed content

type demoStep =
  | Initial
  | SubscribeRequested
  | SubscribeConfirmed
  | VerifyRequested
  | VerificationShown
  | UnsubscribeRequested
  | UnsubscribeConfirmed

type model = {
  demoStep: demoStep,
  demoClicks: int,
}

type msg =
  | NextStep
  | TrackClick

let init = (): (model, Tea.Cmd.t<msg>) => {
  ({demoStep: Initial, demoClicks: 0}, Tea.Cmd.none)
}

let update = (model: model, msg: msg): (model, Tea.Cmd.t<msg>) => {
  switch msg {
  | NextStep =>
      let nextStep = switch model.demoStep {
      | Initial => SubscribeRequested
      | SubscribeRequested => SubscribeConfirmed
      | SubscribeConfirmed => VerifyRequested
      | VerifyRequested => VerificationShown
      | VerificationShown => UnsubscribeRequested
      | UnsubscribeRequested => UnsubscribeConfirmed
      | UnsubscribeConfirmed => Initial
      }
      ({...model, demoStep: nextStep}, Tea.Cmd.none)

  | TrackClick =>
      ({...model, demoClicks: model.demoClicks + 1}, Tea.Cmd.none)
  }
}

let view = (model: model) => {
  open Tea.Html

  let stepContent = switch model.demoStep {
  | Initial =>
      div([], [
        p([], [text("Interactive STAMP Protocol Demo")]),
        p([], [text("See how dependent types prove message compliance")])
      ])

  | SubscribeRequested =>
      div([], [
        p([], [text("✓ Subscribe request sent")]),
        pre([class'("a2ml-proof")], [
          text("(proof consent\n"),
          text("  (action subscribe)\n"),
          text("  (timestamp verified)\n"),
          text("  (type explicit))")
        ])
      ])

  | SubscribeConfirmed =>
      div([], [
        p([class'("success")], [text("✓ Consent cryptographically proven")]),
        code([], [text("proof : confirmation > initial_request")])
      ])

  | VerifyRequested =>
      div([], [
        p([], [text("Verifying consent chain...")])
      ])

  | VerificationShown =>
      div([], [
        p([], [text("✓ Verification complete")]),
        pre([class'("k9-svc-check")], [
          text("(k9-svc validate\n"),
          text("  (component consent-chain)\n"),
          text("  (invariant monotonic)\n"),
          text("  (status valid))")
        ])
      ])

  | UnsubscribeRequested =>
      div([], [
        p([], [text("Testing unsubscribe link...")]),
        pre([class'("k9-svc-check")], [
          text("(k9-svc validate\n"),
          text("  (link unsubscribe)\n"),
          text("  (response-code 200)\n"),
          text("  (response-time < 200ms))")
        ])
      ])

  | UnsubscribeConfirmed =>
      div([], [
        p([class'("success")], [text("✓ Unsubscribe proven working")]),
        p([], [text("Link was tested before sending!")])
      ])
  }

  div([id("tea-demo")], [
    section([class'("interactive-demo")], [
      h2([], [text("Interactive Demo (ReScript-TEA)")]),
      stepContent,
      p([class'("debug")], [
        text("Clicks: " ++ Int.toString(model.demoClicks))
      ])
    ])
  ])
}

let subscriptions = (_model: model) => Tea.Sub.none

let main = () => {
  Tea.App.standardProgram({
    init: init,
    update: update,
    view: view,
    subscriptions: subscriptions,
  })
}

// Initialize on load
@val external document: 'a = "document"
@send external addEventListener: ('a, string, unit => unit) => unit = "addEventListener"

document->addEventListener("DOMContentLoaded", () => main())
