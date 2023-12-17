//
//  WebView.swift
//  BookStoreApp
//
//  Created by Alex on 06.12.2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: "https://archive.org/embed/\(urlString)") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
