//
//  GameScene_Physics.swift
//  SpriteKitTest
//
//  Created by Константин on 04.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    @objc(didBeginContact:)
    func didBegin(_ contact: SKPhysicsContact) {
        
        if Model.sharedInstance.score > Model.sharedInstance.highscore {
        Model.sharedInstance.highscore = Model.sharedInstance.score / 2
        }
        UserDefaults.standard.set(Model.sharedInstance.highscore, forKey: "highScore")
        
        let objectNode = contact.bodyA.categoryBitMask == objectGroup ? contact.bodyA.node : contact.bodyB.node
        
        if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB.categoryBitMask == objectGroup {
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            if shieldBool == false {
                animations.shakeAndFlashAnimation(view: self.view!)
                
                if Model.sharedInstance.sound == true {
                    run(electricGateDeadPreload)
                }
                
                Model.sharedInstance.totalscore = (Model.sharedInstance.totalscore + Model.sharedInstance.score) 

                hero.physicsBody?.allowsRotation = false
                
                //heroEmitterObject.removeAllChildren()
                coinObject.removeAllChildren()
                redCoinObject.removeAllChildren()
                groundObject.removeAllChildren()
                moderatorObject.removeAllChildren()
                movingObject.removeAllChildren()
                shieldObject.removeAllChildren()
                shieldItemObject.removeAllChildren()
                
                stopGameObject()
                
                timerAddCoin.invalidate()
                timerAddRedCoin.invalidate()
                timerAddElectricGate.invalidate()
                timerAddMine.invalidate()
                timerAddShieldItem.invalidate()
                
                heroDeathTexturesArray =  [SKTexture(imageNamed: "Dead0.png"), SKTexture(imageNamed: "Dead1.png"), SKTexture(imageNamed: "Dead2.png"), SKTexture(imageNamed: "Dead3.png"), SKTexture(imageNamed: "Dead4.png"), SKTexture(imageNamed: "Dead5.png"), SKTexture(imageNamed: "Dead6.png")]
                let heroDeathAnimation = SKAction.animate(with: heroDeathTexturesArray, timePerFrame: 0.2)
                hero.run(heroDeathAnimation)
                
                showHighscore()
                gameover = 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { 
                    self.scene?.isPaused = true
                    self.heroObject.removeAllChildren()
                    self.botObject.removeAllChildren()
                    self.showHighscoreText()
                    
                    self.gameViewControllerBridge.reloadGameBtn.isHidden = false
                    self.gameViewControllerBridge.returnMainBtn.isHidden = false
                    
                    self.stageLabel.isHidden = true
                    
                    if Model.sharedInstance.score > Model.sharedInstance.highscore {
                        Model.sharedInstance.highscore = Model.sharedInstance.score
                    }
                    
                    self.highscoreLabel.isHidden = false
                    self.highscoreTextLabel.isHidden = false
                    self.highscoreLabel.text = "\(Model.sharedInstance.highscore)"
                })
                
                SKTAudio.sharedInstance().pauseBackgroundMusic()

            } else {
                objectNode?.removeFromParent()
                shieldObject.removeAllChildren()
                shieldBool = false
                if Model.sharedInstance.sound == true { run(shieldOffPreload) }
            }
        }
        
        if contact.bodyA.categoryBitMask == shieldGroup || contact.bodyB.categoryBitMask == shieldGroup {
            levelUp()
             let shieldNode = contact.bodyA.categoryBitMask == shieldGroup ? contact.bodyA.node : contact.bodyB.node
            
            if shieldBool == false {
                if Model.sharedInstance.sound == true { run(pickCoinPreload) }
                shieldNode?.removeFromParent()
                addShield()
                shieldBool = true
            }
        }
        
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
                        
            heroRunTexturesArray =  [SKTexture(imageNamed: "Run0.png"), SKTexture(imageNamed: "Run1.png"), SKTexture(imageNamed: "Run2.png"), SKTexture(imageNamed: "Run3.png"), SKTexture(imageNamed: "Run4.png"), SKTexture(imageNamed: "Run5.png"), SKTexture(imageNamed: "Run6.png")]
            let heroRunAnimation = SKAction.animate(with: heroRunTexturesArray, timePerFrame: 0.1)
            let heroRun = SKAction.repeatForever(heroRunAnimation)
            hero.run(heroRun)
            
            botRunTexturesArray = [SKTexture(imageNamed: "botR01.png"), SKTexture(imageNamed: "botR02.png"), SKTexture(imageNamed: "botR03.png"), SKTexture(imageNamed: "botR04.png"), SKTexture(imageNamed: "botR05.png"), SKTexture(imageNamed: "botR06.png"), SKTexture(imageNamed: "botR07.png"), SKTexture(imageNamed: "botR08.png"), SKTexture(imageNamed: "botR09.png"), SKTexture(imageNamed: "botR10.png")]
            let botRunAnimation = SKAction.animate(with: botRunTexturesArray, timePerFrame: 0.1)
            let runBot = SKAction.repeatForever(botRunAnimation)
            bot.run(runBot)
        }
        
        if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
            levelUp()
            let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
            let moveHeroX =  SKAction.moveTo(x: self.frame.size.width * 20, duration: 450)
            let removeAction = SKAction.removeFromParent()
            let heroMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveHeroX, removeAction]))
            self.hero.run(heroMoveBgForever)
            
             if Model.sharedInstance.sound == true {
                 run(pickCoinPreload)
             }
             
             switch stageLabel.text! {
                 case "Stage 1":
                     if gSceneDifficulty.rawValue == 0 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 1
                     } else if gSceneDifficulty.rawValue == 1 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 2
                     } else if gSceneDifficulty.rawValue == 2 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 3
                     }
                 case "Stage 2":
                     if gSceneDifficulty.rawValue == 0 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 2
                     } else if gSceneDifficulty.rawValue == 1 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 3
                     } else if gSceneDifficulty.rawValue == 2 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 4
                 }
                 case "Stage 3":
                     if gSceneDifficulty.rawValue == 0 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 3
                     } else if gSceneDifficulty.rawValue == 1 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 4
                     } else if gSceneDifficulty.rawValue == 2 {
                         Model.sharedInstance.score = Model.sharedInstance.score + 5
                 }
             default:break
             }
             
             scoreLabel.text = "\(Model.sharedInstance.score)"
             
             coinNode?.removeFromParent()
            
            if sound == true {
                run(pickCoinPreload)
            }
            coinNode?.removeFromParent()
        }
        
        if contact.bodyA.categoryBitMask == moderatorGroup || contact.bodyB.categoryBitMask == moderatorGroup {
                let moveHeroX = SKAction.moveTo(x: -self.frame.size.width / 20, duration: 15)
                let removeAction = SKAction.removeFromParent()
                let heroMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveHeroX, removeAction]))
                
                hero.run(heroMoveBgForever)
                heroObject.removeAllChildren()
                addHero(heroNode: hero, atPosition: CGPoint(x: hero.position.x - 1, y: hero.position.y))
            
            botObject.removeAllChildren()
            addBot(botNode: bot, atPosition: CGPoint(x: bot.position.x - 1, y: hero.position.y))
        }
        
        if contact.bodyA.categoryBitMask == redCoinGroup || contact.bodyB.categoryBitMask == redCoinGroup {
            let redCoinNode = contact.bodyA.categoryBitMask == redCoinGroup ? contact.bodyA.node : contact.bodyB.node
            
            if sound == true {
                run(pickCoinPreload)
            }
            
            redCoinNode?.removeFromParent()
        }
    }
}
