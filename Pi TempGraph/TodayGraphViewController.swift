//
//  TodayViewController.swift
//  Pi TempGraph
//
//  Created by Andreas Bachmaier on 30.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit
import NotificationCenter
import PiLibs

class TodayGraphViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var imageView: UIImageView!
    @objc var timer: Timer? = nil
    
    @objc let timerUpdate: TimeInterval = 60
    @objc let space: CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width: 0, height: 167)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TodayGraphViewController.launchApp(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer (timeInterval: timerUpdate, target: self, selector: #selector(TodayGraphViewController.performWidgetUpdate), userInfo: nil, repeats: true)
        performWidgetUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: space, left: space, bottom: space, right: space)
    }
    
    @objc func performWidgetUpdate() {
        if let image = PiLib.loadTempHourImage() {
            self.imageView.image = image
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        performWidgetUpdate()
        completionHandler(NCUpdateResult.newData)
    }
    
    @objc func launchApp(_ recognizer: UITapGestureRecognizer!) {
        let url = PiLib.getPiControlUrl()
        self.extensionContext?.open(url, completionHandler: nil)
    }
}
