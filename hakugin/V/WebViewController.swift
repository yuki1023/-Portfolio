//
//  WebViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

final class WebViewController: UIViewController {

    
    @IBOutlet weak var snowWebView: WKWebView!
    
    var selectedUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedUrl)
        
        loadWeb()
    }
    
    func loadWeb(){
        
        let ud = UserDefaults.standard
        selectedUrl = ud.string(forKey: "selectedUrl")
        print(selectedUrl)
        let url = URL(string: selectedUrl)
        let request = URLRequest(url: url!)
        snowWebView.load(request)
        
        
        ud.removeObject(forKey: "selectedUrl")
        
    }
    
    
}
