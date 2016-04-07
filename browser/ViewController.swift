//
//  ViewController.swift
//  browser
//
//  Created by Ian W. Howe on 4/7/16.
//  Copyright © 2016 Ian W. Howe. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView
    
    @IBOutlet weak var barView: UIView!
    
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
        
        //Default URL when the app starts
        let url = NSURL(string: "https://www.google.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        barView.frame = CGRect(x: 0, y: 0, width: size.width, height: 30)
    }


    
}

