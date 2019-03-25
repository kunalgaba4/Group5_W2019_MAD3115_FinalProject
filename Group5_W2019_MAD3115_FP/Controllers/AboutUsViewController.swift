//
//  AboutUsViewController.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-25.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        let url = Bundle.main.url(forResource: "home", withExtension: "html")
        myWebView.load(URLRequest(url: url!))
        myWebView.allowsBackForwardNavigationGestures = true
        
    }
    

}
