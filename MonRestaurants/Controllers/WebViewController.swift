//
//  WebViewController.swift
//  MonRestaurants
//
//  Created by s b on 28.04.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
