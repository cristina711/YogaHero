//
//  ViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer = AVAudioPlayer()

class ViewController: UIViewController {

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
            audioPlayer = try AVAudioPlayer(contentsOf:URL.init(fileURLWithPath:  Bundle.main.path(forResource: "backgroundMusic", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch{
            print(error)
        }
    }
}
