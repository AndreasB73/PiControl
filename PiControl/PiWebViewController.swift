//
//  PiWebViewController.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 26.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit

class PiWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var url: URL? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        webView.loadRequest(URLRequest(url: url!))
    }
    
    func setMyUrl(_ url: URL) {
        self.url = url
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
