//
//  SecondViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class SecondViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
    var challengeCount = 1
    let poses = [
        
        ("yogaone","place phone on your hand face-up","flat"),
        ("yogatwo", "place phone between your hands","vertical"),
        ("yogafive", "place phone on your non-dominant hand face-up","flat"),
        ("yogaeight","place phone on your stomach","flat"),
        ("yoganine", "place phone on your knee","flat")
    ]
    
    
    
    var poseIndex = 0
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var poseImage: UIImageView!
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        if poseIndex < poses.count-1 {
            poseIndex += 1
            challengeCount += 1
        } else {
            poseIndex = 0
            challengeCount = 1
        }
        updateUI()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        startReadingMotionData()
        
        // Do any additional setup after loading the view.
    }

    
    func updateUI() {
        levelLabel.text = "YOGA HERO CHALLENGE " + String(challengeCount)
        poseImage.image = UIImage(named: poses[poseIndex].0)
        gameStateLabel.text = poses[poseIndex].1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func startReadingMotionData() {
        // set read speed
        motionManager.deviceMotionUpdateInterval = 1
        self.motionManager.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
        self.motionManager.startAccelerometerUpdates()
        // start reading
        var initial = false
        var myPitch: Double?
        var myRoll: Double?
        var myYaw: Double?
        var keepSteady = 0
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
                    if abs(myPitch! - self.degrees(mydata.attitude.pitch)) > 4 {
                        print ("Pitch", self.degrees(mydata.attitude.pitch))
                    }
                    if abs(myRoll! - self.degrees(mydata.attitude.roll)) > 4 {
                        print ("Roll", self.degrees(mydata.attitude.roll))
                        keepSteady += 1
                        DispatchQueue.main.async {
                            self.gameStateLabel.text = "You have held it for \(keepSteady) seconds."
                        }
                    }
                    if abs(myYaw! - self.degrees(mydata.attitude.yaw)) > 4 {
                        print ("Yaw", self.degrees(mydata.attitude.yaw))
                    } else {
                        print ("No change detected")
                        keepSteady = 0
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        DispatchQueue.main.async {
                            self.gameStateLabel.text = "Keeo it straightefr"
                        }
                    }
                }
                if keepSteady >= 10{
                    DispatchQueue.main.async {
                        self.gameStateLabel.text = "You Got it"
                    }
                }
                
            }
        }
    }
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
}
