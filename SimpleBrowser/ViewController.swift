//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Marina Khort on 02.08.2020.
//  Copyright © 2020 Marina Khort. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

	var webView: WKWebView!
	var progressView: UIProgressView!
//	var websites = ["apple.com", "hackingwithswift.com"]
	var website: String!

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		let goBack = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
		let goForward = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))
		toolbarItems = [goBack,goForward, progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false
		
		//for checking if our progress bar in action
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
		let url = URL(string: "https://" + website)!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
	}

		//needed for action sheet
//	@objc func openTapped() {
//		let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
//		for _ in website {
//			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
//		}
//		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//		ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem  //for iPad
//		present(ac, animated: true)
//	}
	
//	func openPage(action: UIAlertAction) {
//		let url = URL(string: "https://" + action.title!)!
//		webView.load(URLRequest(url: url))
//	}

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		title = webView.title
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url

		if let host = url?.host {
			for site in website {
				if host.contains(site) {
					decisionHandler(.allow)
					return
				}
//			let ac = UIAlertController(title: "Warning", message: "Website is not allowed", preferredStyle: .alert)
//			ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
//			present(ac, animated: true)
			}
		}
		decisionHandler(.cancel)
	}
}

