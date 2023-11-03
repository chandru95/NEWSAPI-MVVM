//
//  secondViewController.swift
//  newsapi_mvvm
//
//  Created by Karthiga on 10/13/23.
//

import UIKit
import WebKit

class secondViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
        var getmethode: String?
        override func viewDidLoad() {
            super.viewDidLoad()
            if let url = getmethode{
                webview.load(URLRequest (url: URL(string: url)! as URL) as URLRequest)
                }
                else{
                    print("error")
                }
            }
        override func viewDidAppear(_ animated: Bool) {

        }

}
