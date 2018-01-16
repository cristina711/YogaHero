//
//  SecondViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import CoreMotion

class SecondViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    
    var challengeCount = 1
    let poses = [
        
        ("yogaone","place phone on your hand face-up"),
        ("yogatwo", "place phone between your hands"),
        ("yogafive", "place phone on your non-dominant hand face-up"),
        ("yogaeight","place phone on your stomach"),
        ("yoganine", "place phone on your knee")
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
    
}
