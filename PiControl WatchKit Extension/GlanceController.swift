//
//  GlanceController.swift
//  PiControl WatchKit Extension
//
//  Created by Andreas Bachmaier on 30.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import WatchKit
import Foundation
import PiLibsWatch

class GlanceController: WKInterfaceController {
    
    @IBOutlet weak var deviceLabel: WKInterfaceLabel!
    @IBOutlet weak var tempLabel: WKInterfaceLabel!
    
    @IBOutlet weak var detailGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        performGlanceUpdate()
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @objc func performGlanceUpdate() {
        showRoom()
        if let current = PiLibWatch.currentTemp {
            showTemp(current)
        }
        
        if let url = URL(string:"http://pi.bachmaier.cc/current.txt") {
            URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if (data != nil && error == nil) {
                    DispatchQueue.main.async {
                        if let current = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                            self.showTemp(current)
                        }
                    }
                }
            }) .resume()
        }
        
    }
    
    @objc func showRoom() {
        //let menloFont = UIFont(name: "Menlo", size: 20.0)!
        let menloFont = UIFont.systemFont(ofSize: 20)
        let fontAttrs = [NSAttributedStringKey.font : menloFont]
        let attrString = NSAttributedString(string: "Wohnzimmer", attributes: fontAttrs)
        self.deviceLabel.setAttributedText(attrString)
    }
    
    @objc func showTemp(_ current: NSString) {
        let attrString = PiLibWatch.formatCurrentValue(current)
        self.tempLabel.setAttributedText(attrString)
    }
}
