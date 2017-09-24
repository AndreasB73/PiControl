//
//  PiLib.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 31.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit

open class PiLib: NSObject {
    
    open static func getCurrentRequest() -> URLRequest? {
        let url = URL(string: "http://pi.bachmaier.cc/current.txt")
        return URLRequest(url: url!)
    }
    
    open static func loadTempHourImage() -> UIImage? {
        return loadImage("http://pi.bachmaier.cc/temphour.png")
    }
    
    open static func loadTempDayImage() -> UIImage? {
        return loadImage("http://pi.bachmaier.cc/tempday.png")
    }
    
    open static func loadTempWeekImage() -> UIImage? {
        return loadImage("http://pi.bachmaier.cc/tempweek.png")
    }
    
    open static func getPiControlUrl() -> URL {
        return URL(string: "picontrol://home")!
    }
    
    fileprivate static func loadImage(_ urlString: String) -> UIImage? {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!)
        {
            return UIImage(data: data)
        }
        return nil
    }
    
    /*
    public static func formatCurrentValue(current: NSString) -> NSAttributedString {
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
        
        let menloFont = UIFont(name: "Menlo", size: 24.0)!
        let fontAttrs = [NSFontAttributeName : menloFont, NSForegroundColorAttributeName:UIColor.redColor()]
        
        let attrString = NSMutableAttributedString(string: text, attributes: fontAttrs)
        
        return attrString
    }
    

    
    private static let tempKey = "Temperatur"
    private static let tempOldKey = "TemperaturOld"
    
    public static var currentTemp: NSString? {
        get {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(tempKey)
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newValue, forKey: tempKey)
        }
    }
    
    public static var oldTemp: NSString? {
        get {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(tempOldKey)
        }
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newValue, forKey: tempOldKey)
        }
    }
*/
    
}
