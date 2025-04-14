//
//  testview.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/14.
//
import SwiftUI
import WebKit

struct testview: View {
    @StateObject private var logindata = loginData()
    @State private var cookies: [HTTPCookie] = []
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            WebView(
                url: URL(string: "https://keiouniversity.my.site.com/students/s/")!,
                cookies: cookies,
                credentials: logindata.credentials
            )
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    var cookies: [HTTPCookie]
    var credentials: (String, String)
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var request = URLRequest(url: url)

        if !cookies.isEmpty {
            let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)
            request.allHTTPHeaderFields = cookieHeader
        }

        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var lastURL: String = ""

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("window.location.href") { [weak self] result, error in
                guard let self = self else { return }
                guard let currentURL = result as? String else {
                    print("❌ Could not get URL")
                    return
                }

                // Avoid repeating on the same page
                if currentURL == self.lastURL {
                    return
                }

                self.lastURL = currentURL
                print("🌐 Navigated to: \(currentURL)")

                // Decide which step we're on based on input fields
                self.handleLoginStep(for: webView)
            }
        }

        private func handleLoginStep(for webView: WKWebView) {
            let username = parent.credentials.0
            let password = parent.credentials.1

            let script = """
            setTimeout(function() {
                const usernameInput = document.getElementById('input28');
                const passwordInput = document.getElementById('input54');

                // STEP 1: Username
                if (usernameInput) {
                    usernameInput.focus();
                    usernameInput.value = '\(username)';
                    usernameInput.dispatchEvent(new Event('input', { bubbles: true }));
                    usernameInput.dispatchEvent(new Event('change', { bubbles: true }));
                    const nextButton = document.querySelector('input.button.button-primary');
                    if (nextButton) {
                        nextButton.click();
                        console.log("✅ Username filled, clicked Next.");
                    }
                    return;
                }

                console.log("❌ No relevant login fields found.");
            }, 800);
            """
            
            let scriptv2 = """
                            setTimeout(function() {
                                
                                const passwordInput = document.getElementById('input54');
                // STEP 2: Password
                if (passwordInput) {
                    passwordInput.focus();
                    passwordInput.value = '\(password)';
                    passwordInput.dispatchEvent(new Event('input', { bubbles: true }));
                    passwordInput.dispatchEvent(new Event('change', { bubbles: true }));
                    const verifyButton = document.querySelector('input.button.button-primary');
                    if (verifyButton) {
                        verifyButton.click();
                        console.log("✅ Password filled, clicked Verify.");
                    } else {
                        console.log("❌ Verify button not found.");
                    }
                    return;
                }
                                console.log("❌ No relevant login fields found.");
                            }, 800);
                """


            webView.evaluateJavaScript(script) { result, error in
                if let error = error {
                    print("❌ JS error: \(error.localizedDescription)")
                } else {
                    print("✅ JS login step injected.")
                    
                    // Wait for 2 seconds before executing the second script
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        webView.evaluateJavaScript(scriptv2) { result, error in
                            if let error = error {
                                print("❌ JS error: \(error.localizedDescription)")
                            } else {
                                print("✅ JS login step injected22.")
                            }
                        }
                    }
                }
            }
        }
    }


}

#Preview {
    testview()
}
