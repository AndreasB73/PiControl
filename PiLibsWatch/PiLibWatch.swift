//
//  PiLibWatch.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 26.10.15.
//  Copyright © 2015 Andreas Bachmaier. All rights reserved.
//

import WatchKit
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


open class PiLibWatch: NSObject {

    fileprivate static let tempKey = "Temperatur"
    fileprivate static let tempOldKey = "TemperaturOld"
    
    @objc open static func formatCurrentValue(_ current: NSString) -> NSAttributedString {
        var text: String
        
        self.oldTemp = self.currentTemp
        self.currentTemp = current
        
        let curr = self.currentTemp?.doubleValue
        let old = self.oldTemp?.doubleValue
        
        
        if (curr > old ) {
            text = String(format:"%3.1f °C  ▲", curr!)
        } else if (curr < old) {
            text = String(format:"%3.1f °C  ▼", curr!)
        } else {
            text = String(format:"%3.1f °C", curr!)
        }
        
        //let menloFont = UIFont(name: "Menlo", size: 24.0)!
        let menloFont = UIFont.systemFont(ofSize: 24)

        let fontAttrs = [NSAttributedStringKey.font : menloFont, NSAttributedStringKey.foregroundColor:UIColor.red]
        
        let attrString = NSMutableAttributedString(string: text, attributes: fontAttrs)
        
        return attrString
    }
    
    @objc open static var currentTemp: NSString? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: tempKey) as NSString?
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: tempKey)
        }
    }
    
    @objc open static var oldTemp: NSString? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: tempOldKey) as NSString?
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: tempOldKey)
        }
    }
    
}
