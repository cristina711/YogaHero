//
//  ViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

var audioPlayer = AVAudioPlayer()
var motionManager = CMMotionManager()
let opQueue = OperationQueue()

class ViewController: UIViewController {
    
    var containsAudioHard = false;

    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var images: UIImageView!
    
  
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton){
        audioPlayer.play()
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            containsAudioHard = true
            audioPlayer = try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath:  Bundle.main.path(forResource: "backgroundMusic", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print(error)
        }
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

            }
        }
    }
    
    func degrees(_ radians: Double) -> Double {
        return 180/Double.pi * radians
    }
}
