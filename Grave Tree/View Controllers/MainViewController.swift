//
//  MainViewController.swift
//  SpriteKitTest
//
//  Created by Константин on 12.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "totalscore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
        }
        
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgroundMusic.mp3")
        }
    }
    
    @IBAction func startGame(sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "button_press.mp3")
        if let storyboard = storyboard {
            let difficultyViewController = storyboard.instantiateViewController(withIdentifier: "DifficultyViewController") as! DifficultyViewController
            navigationController?.pushViewController(difficultyViewController, animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
