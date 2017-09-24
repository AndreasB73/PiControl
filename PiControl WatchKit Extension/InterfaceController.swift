//
//  InterfaceController.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 10.06.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import WatchKit
import Foundation
import PiLibsWatch

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var tempImage: WKInterfaceImage!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        performUpdate()
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func performUpdate() {
        if let url = URL(string:"http://pi.bachmaier.cc/tempwatch.png") {
            URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if (data != nil && error == nil) {
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.tempImage.setImage(image)
                    }
                }
            }) .resume()
        }
    }
    
}
