//
//  ArticleWebViewController.swift
//  News
//
//  Created by Pedro Capela on 28/05/2021.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webViewController: WKWebView!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViewController.load(URLRequest(url: url!))
        webViewController.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
