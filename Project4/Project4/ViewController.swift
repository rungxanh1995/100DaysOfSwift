//
//  ViewController.swift
//  Project4
//
//  Created by Joe Pham on 2021-01-09.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    // Class ViewController inherits UIViewController
    // and conforms to WKNavigationDelegate protocol
    
    // Create the web view
//    var webView: WKWebView!
    // Create the progress view
    var progressView: UIProgressView!
    // Create an array of allowed websites
    var websites = websiteInstance.globalWebsitesList
    // Declare a var to hold the current website to be shared
    var websiteToShare: URL?
    
    // Integrate webView screen from Storyboard
    @IBOutlet var webView: WKWebView!
    
    var selectedWebsite: String?
    
    // Alter built-in loadView()
    override func loadView() {
        // 1. Assign an empty WKWebView instance to webView
        webView = WKWebView()
        
        // 2. Set webView's navigationDelegate to the current view controller
        webView.navigationDelegate = self
        // A delegate is 1 thing acting in place of another
        // This might be why the website takes the entire screen to display
        // (i.e. the navigation bar is on top of the website's floating navbar at the moment)
        
        // 3. Make the current view of loadView() that webView
        view = webView
        
//        // This is the initial website displayed by this app
//        let url = URL(string: "https://" + websites[0])!
//        // 1. This assigns a URL object out of String to url
//        webView.load(URLRequest(url: url))
//        // 2. This create a URLRequest object from the url, then feeds webView to load
//        webView.allowsBackForwardNavigationGestures = true
//        // 3. This enables backward/forward edge-swiping gesture
        
        // End of loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let websiteToLoad = selectedWebsite {
            let url = URL(string: "https://" + websiteToLoad)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Add a navigation button to share current website
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: #selector(shareTapped))

        // Declare value as a UIProgressView instance to progressView
        progressView = UIProgressView(progressViewStyle: .default)
        // Set its layout size to fit its contents fully
        progressView.sizeToFit()
        // Create a progress button by passing the UIProgressView instance in there to param customView
        let progressButton = UIBarButtonItem(customView: progressView)
        // Also create a flexible space
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        // And a refresh button
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        // Add back button
        let backSymbol = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backSymbol, style: .plain, target: webView, action: #selector(webView.goBack))
        // Add forward button
        let forwardSymbol = UIImage(systemName: "chevron.right")
        let forwardButton = UIBarButtonItem(image: forwardSymbol, style: .plain, target: webView, action: #selector(webView.goForward))
        // Add the website list
        let listSymbol = UIImage(systemName: "list.bullet")
        let listButton = UIBarButtonItem(image: listSymbol, style: .plain, target: self, action: #selector(openTapped))
        
        // Create an array containing the defined buttons -> sets to toolbarItems
        toolbarItems = [backButton, spacer, forwardButton, spacer, progressButton, spacer, listButton, spacer, refreshButton]
        navigationController?.isToolbarHidden = false
        navigationController?.hidesBarsOnSwipe = true
        
        // Add a KVO observer of the estimatedProgress property on the web view
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        // The 4 params meaning are:
        // 1. _ observer: who the observer is (in this case we are the observer)
        // 2. forKeyPath: what to observe (the estimatedProgress property of WKWebView inside a key path)
        // 3. options: which value we want (the value that was just set, hence the new one)
        // 4. context: arbitrary data of the value provided when the observer was registered to receive KVO notifications
        
        // End of viewDidLoad()
        }
    
    // Obj-C openTapped() method to display UIAlertController options
    // These options are pre-set websites for users to browse
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
        }
    
    // openPage method that takes param value from UIAlertAction above
    // Then string interpolated it in a complete URL and passed to webView to load as a URLRequest
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    // Update title of webView to title of webpage after finished loading the site
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    // Edit observeValue() method to tell when the estimatedProgress value has changed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // When the keyPath equates value of the keypath of key estimatedProgress
        if keyPath == "estimatedProgress" {
            // Convert the estimatedProgress value of webView to a float & assign to progressView.progress
            progressView.progress = Float(webView.estimatedProgress)
            print(webView.estimatedProgress)
        }
    }
    
    // Allow navigation to happen or not -> check the navigation URL to see whether we like it
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Set constant url equal to the URL of the navigation
        let url = navigationAction.request.url
        
        // See if the URL has a host (website domain)
        // Hence the optional url
        if let host = url?.host {
            // It does have a host, so proceed to check if the website is in the list
            for website in websites {
                if host.contains(website) {
                    // Call decisionHandler with a positive response: allow loading
                    decisionHandler(.allow)
                    // Set the current host to website to share
                    websiteToShare = url
                    // Then exit this method
                    return
                }
            }
            // If user somehow access a URL that isn't allowed, then show a blocking alert
            showBlockAlert()
        }
        
        // Otherwise if there's no host set, or website not in the list
        // Call decisionHandler to cancel loading
        decisionHandler(.cancel)
    }
    
    // Method to show a blocked website alert
    func showBlockAlert() {
        let ac = UIAlertController(title: "Blocked website", message: "The browser is attempting to navigate to a website not in the website catalog", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    // Obj-C shareTapped() method to share current website
    @objc func shareTapped() {
        let ac = UIActivityViewController(activityItems: [websiteToShare!], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    // End of Class
}
