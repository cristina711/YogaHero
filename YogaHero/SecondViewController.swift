//
//  SecondViewController.swift
//  YogaHero
//
//  Created by Qian Yang on 1/13/18.
//  Copyright © 2018 Qian Yang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var levelLabel: UILabel!
    
    

    @IBOutlet weak var yogaoneImage: UIImageView!
    
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "seguethree", sender: self)
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        levelLabel.text = "YOGA HERO CHALLENGE 1 "
        
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
