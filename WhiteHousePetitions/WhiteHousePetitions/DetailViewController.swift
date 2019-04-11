//
//  DetailViewController.swift
//  WhiteHousePetitions
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var petition: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        navigationController?.navigationBar.prefersLargeTitles = false
        title = petition?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = petition else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
