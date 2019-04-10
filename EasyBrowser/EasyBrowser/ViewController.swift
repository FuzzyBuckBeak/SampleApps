//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Apo on 4/8/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webkit: WKWebView!
    var progressView: UIProgressView!
    var websites : [String] = ["apple.com", "hackingwithswift.com"]
    override func loadView() {
        webkit = WKWebView()
        webkit.navigationDelegate = self
        view = webkit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       webkit.addObserver(self,
                          forKeyPath: #keyPath(WKWebView.estimatedProgress),
                          options: .new,
                          context: nil)
        
        progressView  = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let progess = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webkit, action: #selector(webkit.reload))
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webkit, action: #selector(webkit.goForward))
        let backward = UIBarButtonItem(barButtonSystemItem: .rewind, target: webkit, action: #selector(webkit.goBack))
        
        toolbarItems = [progess, spacer, refresh, backward, forward]
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                             action: #selector(addButtonTapped))
      
        
        let url = URL(string: "https://" + websites[0])!
        webkit.load(URLRequest(url: url))
        webkit.allowsBackForwardNavigationGestures = true
    }

    @objc func addButtonTapped() {
       let vc = UIAlertController(title: "Open Page ... ", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            vc.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        vc.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webkit.load(URLRequest(url: url))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webkit.estimatedProgress)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
    }
}
