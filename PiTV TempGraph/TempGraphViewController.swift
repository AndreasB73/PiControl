//
//  TempGraphViewController.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 05.12.15.
//  Copyright © 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit

class TempGraphViewController: UIViewController {

    @IBOutlet weak var imgHour: UIImageView!
    @IBOutlet weak var imgDay: UIImageView!
    @IBOutlet weak var imgWeek: UIImageView!
    @IBOutlet weak var imgPiCpu: UIImageView!
    
    var timer: NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImages()
        startTimer()
    }

    override func viewWillDisappear(animated: Bool) {
        stopTimer()
        super.viewWillDisappear(true)
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target:self, selector: Selector("loadImages"), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }

    func loadImages() {
        loadImage(urlString: "http://pi.bachmaier.cc/temphour.png", imgView: imgHour)
        loadImage(urlString: "http://pi.bachmaier.cc/tempday.png", imgView: imgDay)
        loadImage(urlString: "http://pi.bachmaier.cc/tempweek.png", imgView: imgWeek)
        loadImage(urlString: "http://pi.bachmaier.cc/tempcpu.png", imgView: imgPiCpu)
    }
    
    func loadImage(urlString urlString : String, imgView: UIImageView) {
        if let url = NSURL(string: urlString) {
            NSURLSession.sharedSession().dataTaskWithURL(url) {
                data, response, error in
                if (data != nil && error == nil) {
                    let image = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue()) {
                        imgView.image = image
                    }
                }
            }.resume()
        }
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
