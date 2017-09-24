//
//  TodayViewController.swift
//  PiToday
//
//  Created by Andreas Bachmaier on 30.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit
import NotificationCenter
import PiLibs

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var DeviceLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @objc let tempKey = "Temperatur"
    @objc let tempOldKey = "TemperaturOld"
    
    @objc var timer: Timer? = nil
    @objc let timerUpdate: TimeInterval = 60
    
    @objc var currentTemp: NSString? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: tempKey) as NSString?
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: tempKey)
        }
    }
    
    @objc var oldTemp: NSString? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: tempOldKey) as NSString?
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: tempOldKey)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width: 0, height: 48)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TodayViewController.launchApp(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        if let temp = defaults.string(forKey: tempKey) {
            self.tempLabel.text = String(format:"%3.1f °C", (temp as NSString).doubleValue)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer (timeInterval: timerUpdate, target: self, selector: #selector(TodayViewController.performWidgetUpdate), userInfo: nil, repeats: true)
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
        return UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left, bottom: 0, right: defaultMarginInsets.right)
    }
    
    @objc func performWidgetUpdate() {
        if let request = PiLib.getCurrentRequest() {
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
                (response, data, error) in
                if let current = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                    self.oldTemp = self.currentTemp
                    self.currentTemp = current
                    
                    let curr = self.currentTemp?.doubleValue
                    let old = self.oldTemp?.doubleValue
                    
                    if (curr > old ) {
                        self.tempLabel.text = String(format:"%3.1f °C  ▲", curr!)
                    } else if (curr < old) {
                        self.tempLabel.text = String(format:"%3.1f °C  ▼", curr!)
                    } else {
                        self.tempLabel.text = String(format:"%3.1f °C", curr!)
                    }
                    
                }
            }
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
