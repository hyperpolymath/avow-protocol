function resultToString(result) {
  switch (result) {
    case "Success":
      return "✓ Verified";
    case "ErrorInvalidUrl":
      return "✗ Invalid URL";
    case "ErrorNotHttps":
      return "✗ Not HTTPS";
    case "ErrorInvalidConsent":
      return "✗ Invalid Consent";
    default:
      return "✗ Verification Failed";
  }
}

function resultToClass(result) {
  return result === "Success" ? "success" : "error";
}

function verifyUnsubscribeLink(url) {
  try {
    const parsed = new URL(url);
    if (parsed.protocol !== "https:") {
      return "ErrorNotHttps";
    }
    return "Success";
  } catch (_err) {
    return "ErrorInvalidUrl";
  }
}

function verifyConsentChain(consent) {
  if (consent.confirmation <= consent.initialRequest || consent.token.length < 10) {
    return "ErrorInvalidConsent";
  }
  return "Success";
}

function testUnsubscribeLink(url) {
  const outputEl = document.getElementById("demo-output");
  outputEl.innerHTML = "<div class='demo-loading'>🔍 Validating link structure...</div>";
  setTimeout(() => {
    const now = Date.now();
    const result = verifyUnsubscribeLink(url);
    const resultClass = resultToClass(result);
    const resultText = resultToString(result);
    const html = `
      <div class="demo-result ${resultClass}">
        <h4>${resultText}</h4>
        <div class="demo-details">
          <p><strong>URL:</strong> ${url}</p>
          <p><strong>Checked At:</strong> ${new Date(now).toISOString()}</p>
          <p><strong>Check:</strong> URL parses and is HTTPS</p>
        </div>
      </div>
    `;
    outputEl.innerHTML = html;
  }, 300);
}

function testConsentChain() {
  const outputEl = document.getElementById("demo-output");
  outputEl.innerHTML = "<div class='demo-loading'>🔍 Verifying consent ordering...</div>";
  setTimeout(() => {
    const now = Date.now();
    const initialRequest = now - 5000;
    const consent = {
      initialRequest,
      confirmation: now,
      token: "user_123_consent_token_abc",
    };
    const result = verifyConsentChain(consent);
    const resultClass = resultToClass(result);
    const resultText = resultToString(result);
    const html = `
      <div class="demo-result ${resultClass}">
        <h4>${resultText}</h4>
        <div class="demo-details">
          <p><strong>Initial Request:</strong> ${new Date(initialRequest).toISOString()}</p>
          <p><strong>Confirmation:</strong> ${new Date(now).toISOString()}</p>
          <p><strong>Token:</strong> ${consent.token}</p>
          <p><strong>Check:</strong> confirmation > initialRequest</p>
        </div>
      </div>
    `;
    outputEl.innerHTML = html;
  }, 300);
}

function initDemo() {
  const testUnsubBtn = document.getElementById("test-unsub-btn");
  const unsubUrlInput = document.getElementById("unsub-url");
  if (testUnsubBtn && unsubUrlInput) {
    testUnsubBtn.addEventListener("click", () => testUnsubscribeLink(unsubUrlInput.value));
  }
  const testConsentBtn = document.getElementById("test-consent-btn");
  if (testConsentBtn) {
    testConsentBtn.addEventListener("click", () => testConsentChain());
  }
}

document.addEventListener("DOMContentLoaded", () => initDemo());
