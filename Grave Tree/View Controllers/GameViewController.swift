//
//  GameViewController.swift
//  Grave Tree
//
//  Created by Max on 16.11.2019.
//  Copyright © 2019 maximgavrilovich. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene = GameScene(size: CGSize(width: 1334, height: 750))
    let textureAtlas = SKTextureAtlas(named: "scene.atlas")
    
    //Variables
    var gVCBgChoosing: BgChoosing!
    var gVCDifficulty: DifficultyChoosing!
    
    @IBOutlet weak var reloadGameBtn: UIButton!
    @IBOutlet weak var returnMainBtn: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = false
        SwiftSpinner.show(title: "Loading...", animated: true)
        reloadGameBtn.isHidden = true
        let view = self.view as! SKView
        
        view.ignoresSiblingOrder = true
        view.showsPhysics = false
        
        scene.scaleMode = .aspectFill
        scene.gSceneBg = gVCBgChoosing
        scene.gSceneDifficulty = gVCDifficulty
        scene.gameViewControllerBridge = self
        
        textureAtlas.preload {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.loadingView.isHidden = true
                SwiftSpinner.hide()
                view.presentScene(self.scene)
            })
        }
    }
    
    @IBAction func reloadGameButton(sender: UIButton) {
        SKTAudio.sharedInstance().playSoundEffect(filename: "button_press.mp3")
        scene.reloadGame()
        scene.gameViewControllerBridge = self
        reloadGameBtn.isHidden = true
    }
    
    @IBAction func returnSelectBackGround(sender: UIButton) {
        navigationController?.popViewController(animated: false)
        navigationController?.dismiss(animated: false, completion: nil)
        
        DispatchQueue.main.async {
            self.scene.removeAll()
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
