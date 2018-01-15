//
//  ViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import CoreMotion



var motionManager = CMMotionManager()
let opQueue = OperationQueue()

// variables that need in all the views  have to be here for global use 

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()

    
    var poseimages = [""]

    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var images: UIImageView!
    
  
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton){
        
       performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if motionManager.isDeviceMotionAvailable {
            print("We can detect device motion")
            startReadingMotionData()
        }
        else {
            print("We cannot detect device motion")
        }
    }

    
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 1
        // start reading
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            
            if let mydata = data {
                print("mydata", mydata.attitude)
                print("pitch", self.degrees(mydata.attitude.pitch))
            }
        }
    }
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
}
       


//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }




