//
//  ViewController.swift
//  PoseGame
//
//  Created by Jihun Kang on 1/12/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        motionManager.deviceMotionUpdateInterval = 3
        // start reading
        var initial = false
        var myPitch: Double?
        var myRoll: Double?
        var myYaw: Double?
        motionManager.startDeviceMotionUpdates(to: opQueue) {
            (data: CMDeviceMotion?, error: Error?) in
            
            if let mydata = data {
                if initial == false {
                    myPitch = self.degrees(mydata.attitude.pitch)
                    myRoll = self.degrees(mydata.attitude.roll)
                    myYaw = self.degrees(mydata.attitude.yaw)
                    initial = true
                    print ("Pitch: ", self.degrees(mydata.attitude.pitch))
                    print ("Roll: ", self.degrees(mydata.attitude.roll))
                    print ("Yaw: ", self.degrees(mydata.attitude.yaw))
                } else {
                    if abs(myPitch! - self.degrees(mydata.attitude.pitch)) > 5 {
                        print ("Pitch", self.degrees(mydata.attitude.pitch))
                    }
                    if abs(myRoll! - self.degrees(mydata.attitude.roll)) > 5 {
                        print ("Roll", self.degrees(mydata.attitude.roll))
                    }
                    if abs(myYaw! - self.degrees(mydata.attitude.yaw)) > 5 {
                        print ("Yaw", self.degrees(mydata.attitude.yaw))
                    } else {
                        print ("No change detected")
                    }
                }
                
                
                //                print ("Pitch: ", self.degrees(mydata.attitude.pitch))
                //                print ("Roll: ", self.degrees(mydata.attitude.roll))
                //                print ("Yaw: ", self.degrees(mydata.attitude.yaw))
                
            }
        }
    }
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
    
}

