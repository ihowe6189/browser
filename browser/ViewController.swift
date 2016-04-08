//
//  ViewController.swift
//  browser
//
//  Created by Ian W. Howe on 4/7/16.
//  Copyright © 2016 Ian W. Howe. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    var webView: WKWebView
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    required init(coder aDecocer: NSCoder) {
        self.webView = WKWebView(frame: CGRectZero)
        super.init(coder: aDecocer)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        barView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height,width])
        
        webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        
        //Default URL when the app starts
        let url = NSURL(string: "https://www.google.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        backButton.enabled = false
        forwardButton.enabled = false
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        barView.frame = CGRect(x: 0, y: 0, width: size.width, height: 30)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        urlField.resignFirstResponder()
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlField.text!)!))
        return false
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func reload(sender: UIBarButtonItem) {
        let request = NSURLRequest(URL: webView.URL!)
        webView.loadRequest(request)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "loading" {
            backButton.enabled = webView.canGoBack
            forwardButton.enabled = webView.canGoForward
        }
        if keyPath == "estimated progress"{
            //progressView.hidden = webView.estimatedProgress
        }
    }
    
}

