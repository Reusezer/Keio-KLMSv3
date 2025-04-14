//
//  test2view.swift
//  Keio-KLMS
//
//  Created by 小谷理人 on 2025/04/15.
//

/*
 
 
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let cookies: [HTTPCookie]
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let dataStore = WKWebsiteDataStore.default()
        config.websiteDataStore = dataStore
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Inject cookies into the WebView
        let cookieStore = uiView.configuration.websiteDataStore.httpCookieStore
        cookies.forEach { cookie in
            cookieStore.setCookie(cookie)
        }
    }
}

struct test2view: View {
    @EnvironmentObject private var loginData: loginData
    @State private var cookies: [HTTPCookie] = []
    @State private var isLoggedIn = false
    var body: some View {
        NavigationView{
            WebView(url: URL(string: "https://keiouniversity.my.site.com/students/s/")!, cookies: cookies)
        }
    }
}

#Preview {
    test2view()
}

*/
