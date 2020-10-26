//
//  GameScene_Touches.swift
//  SpriteKitTest
//
//  Created by Константин on 04.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //heroEmitter2.isHidden = false
    if gameover == 0 {
        if tabToPlayLabel.isHidden == false {
            tabToPlayLabel.isHidden = true
        }
        
            if gameover == 0 {
                
            hero.physicsBody?.velocity = CGVector.zero
            hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
            
            heroFlyTexturesArray = [SKTexture(imageNamed: "Fly0.png"), SKTexture(imageNamed: "Fly1.png"), SKTexture(imageNamed: "Fly2.png"), SKTexture(imageNamed: "Fly3.png"), SKTexture(imageNamed: "Fly4.png")]
            
            let heroFlyAnimation = SKAction.animate(with: heroFlyTexturesArray, timePerFrame: 0.1)
            let flyHero = SKAction.repeatForever(heroFlyAnimation)
            hero.run(flyHero)
            
            bot.physicsBody?.velocity = CGVector.zero
            bot.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120))
            
            botFlyTexturesArray = [SKTexture(imageNamed: "botJ01.png"), SKTexture(imageNamed: "botJ02.png"), SKTexture(imageNamed: "botJ03.png"), SKTexture(imageNamed: "botJ04.png"), SKTexture(imageNamed: "botJ05.png"), SKTexture(imageNamed: "botJ06.png"), SKTexture(imageNamed: "botJ07.png"), SKTexture(imageNamed: "botJ08.png"), SKTexture(imageNamed: "botJ09.png"), SKTexture(imageNamed: "botJ10.png")]
            
            let botFlyAnimation = SKAction.animate(with: botFlyTexturesArray, timePerFrame: 0.1)
            let flyBot = SKAction.repeatForever(botFlyAnimation)
            bot.run(flyBot)
            }
        }
    }
}
