//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by James Honeyball on 05/02/2017.
//  Copyright © 2017 James Honeyball. All rights reserved.
//


import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("WebViewController loaded it's view.")
   
        let url = URL(string: "https://www.bignerdranch.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
}

