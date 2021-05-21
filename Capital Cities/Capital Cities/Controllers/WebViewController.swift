//
//  WebViewController.swift
//  Capital Cities
//
//  Created by Joe Pham on 2021-05-21.
//

import WebKit
import UIKit

// challenge 3
class WebViewController: UIViewController {
	static let identifier = "WebViewController"
	@IBOutlet weak var webView: WKWebView!
	var websiteUrl: URL!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard websiteUrl != nil else { return }
		webView.load(URLRequest(url: websiteUrl))
	}
}
