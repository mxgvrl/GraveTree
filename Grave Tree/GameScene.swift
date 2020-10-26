//
//  GameScene.swift
//  Grave Tree
//
//  Created by Max on 16.11.2019.
//  Copyright © 2019 maximgavrilovich. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Animations
    var animations = AnimationClass()
    
    //Variables
    var sound = true
    var gameViewControllerBridge: GameViewController!
    var moveElectricGateY = SKAction()
    var shieldBool = false
    var gameover = 0
    var rangeRocket :CGFloat = 0.50
    var gSceneDifficulty: DifficultyChoosing!
    var gSceneBg: BgChoosing!
    
    //Texture
    var bgTexture: SKTexture!
    var flyHeroTex: SKTexture!
    var flyBotTex: SKTexture!
    var runHeroTex: SKTexture!
    var runBotTex: SKTexture!
    var coinTexture: SKTexture!
    var redCoinTexture: SKTexture!
    var coinHeroTex: SKTexture!
    var redCoinHeroTex: SKTexture!
    var electricGateTex: SKTexture!
    var deadHeroTex: SKTexture!
    var shieldTexture: SKTexture!
    var shieldItemTexture: SKTexture!
    var mineTexture1: SKTexture!
    var mineTexture2: SKTexture!
    var box1Texture: SKTexture!
    var box2Texture: SKTexture!
    var box3Texture: SKTexture!
    var bush1Texture: SKTexture!
    var bush2Texture: SKTexture!
    var bush3Texture: SKTexture!
    var moderatorTex: SKTexture!

    // Label nodes
    var tabToPlayLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var highscoreLabel = SKLabelNode()
    var highscoreTextLabel = SKLabelNode()
    var stageLabel = SKLabelNode()
    
    //Sprite Nodes
    var bg = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    var moderator = SKSpriteNode()
    var hero = SKSpriteNode()
    var bot = SKSpriteNode()
    var coin = SKSpriteNode()
    var redCoin = SKSpriteNode()
    var electricGate = SKSpriteNode()
    var shield = SKSpriteNode()
    var shieldItem = SKSpriteNode()
    var mine = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var bush1 = SKSpriteNode()
    var bush2 = SKSpriteNode()
    var bush3 = SKSpriteNode()
    var labelObject = SKNode()
    
    //Sprite Objects
    var bgObject = SKNode()
    var groundObject = SKNode()
    var moderatorObject = SKNode()
    var movingObject = SKNode()
    var heroObject = SKNode()
    var botObject = SKNode()
    var coinObject = SKNode()
    var redCoinObject = SKNode()
    var shieldObject = SKNode()
    var shieldItemObject = SKNode()
    
    //Bit masks
    var heroGroup: UInt32 = 0x1 << 1
    var groundGroup: UInt32 = 0x1 << 2
    var coinGroup: UInt32 = 0x1 << 3
    var redCoinGroup: UInt32 = 0x1 << 4
    var objectGroup: UInt32 = 0x1 << 5
    var shieldGroup: UInt32 = 0x1 << 6
    var botGroup: UInt32 = 0x1 << 7
    var moderatorGroup: UInt32 = 0x1 << 8
    
    //Textures Array for animateWithTextures
    var heroFlyTexturesArray = [SKTexture]()
    var heroRunTexturesArray = [SKTexture]()
    var botFlyTexturesArray = [SKTexture]()
    var botRunTexturesArray = [SKTexture]()
    var coinTexturesArray = [SKTexture]()
    var electricGateTexturesArray = [SKTexture]()
    var heroDeathTexturesArray = [SKTexture]()
    
    //Timers
    var timerAddCoin = Timer()
    var timerAddRedCoin = Timer()
    var timerAddElectricGate = Timer()
    var timerAddShieldItem = Timer()
    var timerAddMine = Timer()
    var timerAddBox1 = Timer()
    var timerAddBox2 = Timer()
    var timerAddBox3 = Timer()
    var timerAddBush1 = Timer()
    var timerAddBush2 = Timer()
    var timerAddBush3 = Timer()
    
    //Sounds
    var pickCoinPreload = SKAction()
    var electricGateCreatePreload = SKAction()
    var electricGateDeadPreload = SKAction()
    var shieldOnPreload = SKAction()
    var shieldOffPreload = SKAction()

    override func didMove(to view: SKView) {
        //Background texture
        bgTexture = SKTexture(imageNamed: "bg01.png")
        
        //Hero texture
        flyHeroTex = SKTexture(imageNamed: "Fly0.png")
        runHeroTex = SKTexture(imageNamed: "Run0.png")
        
        //Bot texture
        flyBotTex = SKTexture(imageNamed: "botJ01.png")
        runBotTex = SKTexture(imageNamed: "botR01.png")
        
        //Coin texture
        coinTexture = SKTexture(imageNamed: "coin.jpg")
        redCoinTexture = SKTexture(imageNamed: "coin.jpg")
        coinHeroTex = SKTexture(imageNamed: "Coin0.png")
        redCoinHeroTex = SKTexture(imageNamed: "Coin0.png")
        
        //ElectricGate texture
        electricGateTex = SKTexture(imageNamed: "ElectricGate01.png")
        
        //Shields and shield item texture
        shieldTexture = SKTexture(imageNamed: "shield.png")
        shieldItemTexture = SKTexture(imageNamed: "shieldItem.png")
        
        //Mines texture
        mineTexture1 = SKTexture(imageNamed: "mine1.png")
        mineTexture2 = SKTexture(imageNamed: "mine2.png")
        
        //Boxes texture
        box1Texture = SKTexture(imageNamed: "box1.png")
        box2Texture = SKTexture(imageNamed: "box2.png")
        box3Texture = SKTexture(imageNamed: "box3.png")
        
        //Bush texture
        bush1Texture = SKTexture(imageNamed: "bush1.png")
        bush2Texture = SKTexture(imageNamed: "bush2.png")
        bush3Texture = SKTexture(imageNamed: "bush3.png")
        
        //Moderator texture
        moderatorTex = SKTexture(imageNamed: "moderator.png")
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        //createGame()
        
        if UserDefaults.standard.object(forKey: "highScore") != nil {
            Model.sharedInstance.highscore = UserDefaults.standard.object(forKey: "highScore") as! Int
            highscoreLabel.text = "\(Model.sharedInstance.highscore)"
        }
        
        if UserDefaults.standard.object(forKey: "totalscore") != nil {
            Model.sharedInstance.totalscore = UserDefaults.standard.object(forKey: "totalscore") as! Int
        }
        
        if gameover == 0 {
            createGame()
        }
        
        pickCoinPreload = SKAction.playSoundFileNamed("pickCoin.mp3", waitForCompletion: false)
        electricGateCreatePreload = SKAction.playSoundFileNamed("electricCreate.wav", waitForCompletion: false)
        electricGateDeadPreload = SKAction.playSoundFileNamed("electricDead.mp3", waitForCompletion: false)
        shieldOnPreload = SKAction.playSoundFileNamed("shieldOn.mp3", waitForCompletion: false)
        shieldOffPreload = SKAction.playSoundFileNamed("shieldOff.mp3", waitForCompletion: false)
    }
    
    func createObjects() {
        self.addChild(bgObject)
        self.addChild(groundObject)
        self.addChild(movingObject)
        self.addChild(heroObject)
        self.addChild(botObject)
        self.addChild(coinObject)
        self.addChild(redCoinObject)
        self.addChild(shieldObject)
        self.addChild(shieldItemObject)
        self.addChild(moderatorObject)
        self.addChild(labelObject)
    }
    
    func createGame() {
        createBg()
        createGround()
        createSky()
        createModerator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.createHero()
            self.createBot()
            self.timerFunc()
//            self.addElectricGate()
        }
        showTapToPlay()
        showScore()
        showStage()
        highscoreTextLabel.isHidden = true
        
        gameViewControllerBridge.reloadGameBtn.isHidden = true
        gameViewControllerBridge.returnMainBtn.isHidden = true
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
    }
    
    func createBg() {
            //bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * CGFloat(i), y: size.height/2.0)
        
        var correctHeight: CGFloat = 0
        switch gSceneBg.rawValue {
        case 0:
            bgTexture = SKTexture(imageNamed: "bg01.png")
            correctHeight = 2.0
        case 1:
            bgTexture = SKTexture(imageNamed: "bg02.png")
            correctHeight = 1.8
        default:
            break
        }
        
        let moveBg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 5)
        let replaceBg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, replaceBg]))
        
        for i in 0..<3 {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * CGFloat(i), y: size.height/correctHeight)
            bg.size.height = self.frame.height
            bg.run(moveBgForever)
            bg.zPosition = -1
            
            bgObject.addChild(bg)
        }
    }
    
    func createGround() {
        ground = SKSpriteNode()
        ground.position = CGPoint.zero
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width + 300, height: self.frame.height/4))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        ground.zPosition = 1
        
        groundObject.addChild(ground)
    }
    
    func createSky() {
        sky = SKSpriteNode()
        sky.position = CGPoint(x: 0, y: self.frame.maxX)
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 500, height: self.frame.size.height + 550))
        sky.physicsBody?.isDynamic = false
        sky.zPosition = 1
        
        movingObject.addChild(sky)
    }
    
    func createModerator() {
        moderator = SKSpriteNode()
        moderator.size.width = 140
        moderator.size.height = (scene?.size.height)!
        moderator.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: moderator.size.width - 20, height: moderator.size.height))
        moderator.position = CGPoint(x: self.size.width/4 + 550, y: 0 + flyHeroTex.size().height + 400)//CGPoint(x: self.frame.size.width - 550, y: self.frame.size.height / 4 - self.frame.size.height / 24 + 30)
        
        //moderator.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 400, height: 400))
        moderator.physicsBody?.categoryBitMask = moderatorGroup
        moderator.physicsBody?.isDynamic = false
        moderator.zPosition = 1
        
        moderatorObject.addChild(moderator)
    }

    
    func addHero(heroNode: SKSpriteNode, atPosition position: CGPoint) {
        hero = SKSpriteNode(texture: flyHeroTex)
        
        //Anim hero
        heroFlyTexturesArray = [SKTexture(imageNamed: "Fly0.png"), SKTexture(imageNamed: "Fly1.png"), SKTexture(imageNamed: "Fly2.png"), SKTexture(imageNamed: "Fly3.png"), SKTexture(imageNamed: "Fly4.png")]
        let heroFlyAnimation = SKAction.animate(with: heroFlyTexturesArray, timePerFrame: 0.1)
        let flyHero = SKAction.repeatForever(heroFlyAnimation)
        hero.run(flyHero)
        
        hero.position = position
        hero.size.height = 84
        hero.size.width = 120
        
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hero.size.width - 40, height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = heroGroup
        hero.physicsBody?.contactTestBitMask = groundGroup | coinGroup | redCoinGroup | objectGroup | shieldGroup | moderatorGroup
        hero.physicsBody?.collisionBitMask = groundGroup
        
        hero.physicsBody?.isDynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        let moveHeroX = SKAction.moveTo(x: -self.frame.size.width / 20, duration: 15)
        
        let removeAction = SKAction.removeFromParent()
        let heroMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveHeroX, removeAction]))
        
        hero.run(heroMoveBgForever)
        
        heroObject.addChild(hero)
    }
    
    func createHero() {
        addHero(heroNode: hero, atPosition: CGPoint(x: self.size.width/4 + 300, y: 0 + flyHeroTex.size().height + 400))
    }
    
    func addBot(botNode: SKSpriteNode, atPosition position: CGPoint) {
        bot = SKSpriteNode(texture: flyBotTex)
        
        //Anim hero
        botFlyTexturesArray = [SKTexture(imageNamed: "botJ01.png"), SKTexture(imageNamed: "botJ02.png"), SKTexture(imageNamed: "botJ03.png"), SKTexture(imageNamed: "botJ04.png"), SKTexture(imageNamed: "botJ05.png"), SKTexture(imageNamed: "botJ06.png"), SKTexture(imageNamed: "botJ07.png"), SKTexture(imageNamed: "botJ08.png"), SKTexture(imageNamed: "botJ09.png"), SKTexture(imageNamed: "botJ10.png")]
        let botFlyAnimation = SKAction.animate(with: botFlyTexturesArray, timePerFrame: 0.1)
        let flyBot = SKAction.repeatForever(botFlyAnimation)
        bot.run(flyBot)
        
        bot.position = position
        bot.size.height = 84
        bot.size.width = 120
        
        bot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bot.size.width - 40, height: bot.size.height - 30))
        
        bot.physicsBody?.categoryBitMask = objectGroup
        //bot.physicsBody?.contactTestBitMask = heroGroup
        bot.physicsBody?.collisionBitMask = heroGroup | groundGroup
        
        bot.physicsBody?.isDynamic = true
        bot.physicsBody?.allowsRotation = false
        bot.zPosition = 1
    
        mine.zPosition = 1
        botObject.addChild(bot)
    }
    
    func createBot() {
        addBot(botNode: bot, atPosition: CGPoint(x: self.size.width/4 - 100, y: 0 + flyHeroTex.size().height + 400))
    }
    
    @objc func addCoin() {
        coin = SKSpriteNode(texture: coinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Coin0.png"), SKTexture(imageNamed: "Coin1.png"), SKTexture(imageNamed: "Coin2.png"), SKTexture(imageNamed: "Coin3.png")]
        
        let coinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let coinHero = SKAction.repeatForever(coinAnimation)
        coin.run(coinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 8
        coin.size.width = 60
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width, height: coin.size.height))
        coin.physicsBody?.restitution = 0
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 120 + pipeOffset)
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 8)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        coin.run(coinMoveBgForever)
        
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinGroup
        coin.zPosition = 1
        coinObject.addChild(coin)
    }
    
    @objc func redCoinAdd() {
        redCoin = SKSpriteNode(texture: redCoinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Coin0.png"), SKTexture(imageNamed: "Coin1.png"), SKTexture(imageNamed: "Coin2.png"), SKTexture(imageNamed: "Coin3.png")]
        
        let redCoinAnimation = SKAction.animate(with: coinTexturesArray, timePerFrame: 0.1)
        let redCoinHero = SKAction.repeatForever(redCoinAnimation)
        redCoin.run(redCoinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        redCoin.size.width = 40
        redCoin.size.height = 40
        redCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: redCoin.size.width - 10, height: redCoin.size.height - 10))
        redCoin.physicsBody?.restitution = 0
        redCoin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffset)
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 8)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        redCoin.run(coinMoveBgForever)
        animations.scaleZdirection(sprite: redCoin)
        animations.redColorAnimation(sprite: redCoin, animDuration: 0.5)
        redCoin.setScale(1.3)
        redCoin.physicsBody?.isDynamic = false
        redCoin.physicsBody?.categoryBitMask = redCoinGroup
        redCoin.zPosition = 1
        redCoinObject.addChild(redCoin)
    }
    
//    @objc func addElectricGate() {
//        if sound == true {
//            run(electricGateCreatePreload)
//        }
//
//        electricGate = SKSpriteNode(texture: electricGateTex)
//
//        electricGateTexturesArray = [SKTexture(imageNamed: "ElectricGate01.png"), SKTexture(imageNamed: "ElectricGate02.png"), SKTexture(imageNamed: "ElectricGate03.png"), SKTexture(imageNamed: "ElectricGate04.png")]
//
//        let electricGateAnimation = SKAction.animate(with: electricGateTexturesArray, timePerFrame: 0.1)
//        let electricGateAnimationForever = SKAction.repeatForever(electricGateAnimation)
//        electricGate.run(electricGateAnimationForever)
//
//        let randomPosition = arc4random() % 2
//        let movementAmount = arc4random() % UInt32(self.frame.size.height / 5)
//        let pipeOffset = self.frame.size.height / 4 + 30 - CGFloat(movementAmount)
//
//        if randomPosition == 0 {
//            electricGate.position = CGPoint(x: self.size.width + 50, y: 0 + electricGateTex.size().height/2 + 90 + pipeOffset)
//            electricGate.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
//        } else {
//            electricGate.position = CGPoint(x: self.size.width + 50, y: self.frame.size.height - electricGateTex.size().height/2 - 90 - pipeOffset)
//            electricGate.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
//        }
//
//        //Rotate
//        electricGate.run(SKAction.repeatForever(SKAction.sequence([SKAction.run({
//            self.electricGate.run(SKAction.rotate(byAngle: CGFloat(M_PI * 2), duration: 0.5))
//        }), SKAction.wait(forDuration: 20.0)])))
//
//        //Move
//        let moveAction = SKAction.moveBy(x: -self.frame.width - 300, y: 0, duration: 6)
//        electricGate.run(moveAction)
//
//        //Scale
//        var scaleValue: CGFloat = 0.3
//
//
//        let scaleRandom = arc4random() % UInt32(5)
//        if scaleRandom == 1 { scaleValue = 0.9 }
//        else if scaleRandom == 2 { scaleValue = 0.6 }
//        else if scaleRandom == 3 { scaleValue = 0.8 }
//        else if scaleRandom == 4 { scaleValue = 0.7 }
//        else if scaleRandom == 0 { scaleValue = 1.0 }
//
//        electricGate.setScale(scaleValue)
//
//        let movementRandom = arc4random() % 9
//        if movementRandom == 0 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 220, duration: 4)
//        } else if movementRandom == 1 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 220, duration: 5)
//        } else if movementRandom == 2 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 150, duration: 4)
//        } else if movementRandom == 3 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 150, duration: 5)
//        } else if movementRandom == 4 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 + 50, duration: 4)
//        } else if movementRandom == 5 {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2 - 50, duration: 5)
//        } else {
//            moveElectricGateY = SKAction.moveTo(y: self.frame.height / 2, duration: 4)
//        }
//
//        electricGate.run(moveElectricGateY)
//
//        electricGate.physicsBody?.restitution = 0
//        electricGate.physicsBody?.isDynamic = false
//        electricGate.physicsBody?.categoryBitMask = objectGroup
//        electricGate.zPosition = 1
//        movingObject.addChild(electricGate)
//    }
    
    @objc func addbox1() {

        box1 = SKSpriteNode(texture: box1Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        box1.size.width = 80
        box1.size.height = 240
        box1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: box1.size.width - 20, height: box1.size.height - 20))
        box1.physicsBody?.restitution = 0
        box1.position = CGPoint(x: self.size.width + 400, y: frame.size.height - box1.size.width - 100)
        
        let movebox1 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let box1MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebox1, removeAction]))
        box1.run(box1MoveBgForever)
        
        box1.physicsBody?.isDynamic = false
        box1.physicsBody?.categoryBitMask = objectGroup
        box1.zPosition = 1
        movingObject.addChild(box1)
    }
    
    @objc func addbox2() {

        box2 = SKSpriteNode(texture: box2Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        box2.size.width = 80
        box2.size.height = 80
        box2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: box2.size.width - 20, height: box2.size.height - 20))
        box2.physicsBody?.restitution = 0
        box2.position = CGPoint(x: self.size.width + 800, y: frame.size.height - box2.size.width - 20)
        
        let movebox2 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let box2MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebox2, removeAction]))
        box2.run(box2MoveBgForever)
        
        box2.physicsBody?.isDynamic = false
        box2.physicsBody?.categoryBitMask = objectGroup
        box2.zPosition = 1
        movingObject.addChild(box2)
    }
    
    @objc func addbox3() {

        box3 = SKSpriteNode(texture: box3Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        box3.size.width = 80
        box3.size.height = 160
        box3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: box3.size.width - 20, height: box3.size.height - 20))
        box3.physicsBody?.restitution = 0
        box3.position = CGPoint(x: self.size.width + 1200, y: frame.size.height - box3.size.width - 60)
        
        let movebox3 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let box3MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebox3, removeAction]))
        box3.run(box3MoveBgForever)
        
        box3.physicsBody?.isDynamic = false
        box3.physicsBody?.categoryBitMask = objectGroup
        box3.zPosition = 1
        movingObject.addChild(box3)
    }
    
    @objc func addBush1() {

        bush1 = SKSpriteNode(texture: bush1Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        bush1.size.width = 80
        bush1.size.height = 80
        bush1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bush1.size.width - 20, height: bush1.size.height - 20))
        bush1.physicsBody?.restitution = 0
        bush1.position = CGPoint(x: self.frame.size.width + 400, y: self.frame.size.height / 8 + 10)
        
        let movebush1 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let bush1MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebush1, removeAction]))
        bush1.run(bush1MoveBgForever)
        
        bush1.physicsBody?.isDynamic = false
        bush1.physicsBody?.categoryBitMask = objectGroup
        bush1.zPosition = 1
        movingObject.addChild(bush1)
    }
    
    @objc func addBush2() {

        bush2 = SKSpriteNode(texture: bush2Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        bush2.size.width = 80
        bush2.size.height = 240
        bush2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bush2.size.width - 20, height: bush2.size.height - 20))
        bush2.physicsBody?.restitution = 0
        bush2.position = CGPoint(x: self.frame.size.width + 800, y: self.frame.size.height / 4 )
        
        let movebush2 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let bush2MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebush2, removeAction]))
        bush2.run(bush2MoveBgForever)
        
        bush2.physicsBody?.isDynamic = false
        bush2.physicsBody?.categoryBitMask = objectGroup
        bush2.zPosition = 1
        movingObject.addChild(bush2)
    }
    
    @objc func addBush3() {

        bush3 = SKSpriteNode(texture: bush3Texture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        bush3.size.width = 80
        bush3.size.height = 160
        bush3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bush3.size.width - 20, height: bush3.size.height - 20))
        bush3.physicsBody?.restitution = 0
        bush3.position = CGPoint(x: self.frame.size.width + 1200, y: self.frame.size.height / 4 - 40)
        
        let movebush3 = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 7)
        let removeAction = SKAction.removeFromParent()
        let bush3MoveBgForever = SKAction.repeatForever(SKAction.sequence([movebush3, removeAction]))
        bush3.run(bush3MoveBgForever)
        
        bush3.physicsBody?.isDynamic = false
        bush3.physicsBody?.categoryBitMask = objectGroup
        bush3.zPosition = 1
        movingObject.addChild(bush3)
    }
    
//    @objc func addMine() {
//        mine = SKSpriteNode(texture: mineTexture1)
//        let minesRandom = arc4random() % UInt32(2)
//        if minesRandom == 0 {
//            mine = SKSpriteNode(texture: mineTexture1)
//        } else {
//            mine = SKSpriteNode(texture: mineTexture2)
//        }
//
//        mine.size.width = 70
//        mine.size.height = 62
//        mine.position = CGPoint(x: self.frame.size.width + 150, y: self.frame.size.height / 4 - self.frame.size.height / 24 + 30)
//
//        let moveMineX = SKAction.moveTo(x: -self.frame.size.width / 4, duration: 4)
//        mine.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: mine.size.width - 40, height: mine.size.height - 30))
//        mine.physicsBody?.categoryBitMask = objectGroup
//        mine.physicsBody?.isDynamic = false
//
//        let removeAction = SKAction.removeFromParent()
//        let mineMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveMineX, removeAction]))
//
//        animations.rotateAnimationToAngle(sprite: mine, animDuration: 0.2)
//
//        mine.run(mineMoveBgForever)
//        mine.zPosition = 1
//        movingObject.addChild(mine)
//    }
    
    func addShield() {
        shield = SKSpriteNode(texture: shieldTexture)
        if sound == true { run(shieldOnPreload) }
        shield.zPosition = 1
        shieldObject.addChild(shield)
    }
    
    @objc func addShieldItem() {
        shieldItem = SKSpriteNode(texture: shieldItemTexture)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        shieldItem.position = CGPoint(x: self.size.width + 50, y: 0 + shieldItemTexture.size().height + self.size.height / 2 + pipeOffset)
        shieldItem.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shieldItem.size.width - 20, height: shieldItem.size.height - 20))
        shieldItem.physicsBody?.restitution = 0
        
        let moveShield = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let shieldItemMoveBgForever = SKAction.repeatForever(SKAction.sequence([moveShield, removeAction]))
        shieldItem.run(shieldItemMoveBgForever)
        
        animations.scaleZdirection(sprite: shieldItem)
        shieldItem.setScale(1.1)
        
        shieldItem.physicsBody?.isDynamic = false
        shieldItem.physicsBody?.categoryBitMask = shieldGroup
        shieldItem.zPosition = 1
        shieldItemObject.addChild(shieldItem)
        
    }
    
    func showTapToPlay() {
        tabToPlayLabel.text = "Tap to Fly!!!"
        tabToPlayLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        tabToPlayLabel.fontSize = 50
        tabToPlayLabel.fontColor = UIColor.white
        tabToPlayLabel.fontName = "Chalkduster"
        tabToPlayLabel.zPosition = 1
        self.addChild(tabToPlayLabel)
    }
    
    func showScore() {
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
    }
    
    func showHighscore() {
        highscoreLabel = SKLabelNode()
        highscoreLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 210)
        highscoreLabel.fontSize = 50
        highscoreLabel.fontName = "Chalkduster"
        highscoreLabel.fontColor = UIColor.white
        highscoreLabel.isHidden = true
        highscoreLabel.zPosition = 1
        labelObject.addChild(highscoreLabel)
    }
    
    func showHighscoreText() {
        //highscoreTextLabel = SKLabelNode()
        highscoreTextLabel.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.maxY - 150)
        highscoreTextLabel.fontSize = 30
        highscoreTextLabel.fontName = "Chalkduster"
        highscoreTextLabel.fontColor = UIColor.white
        highscoreTextLabel.text = "HighScore"
        highscoreTextLabel.zPosition = 1
        labelObject.addChild(highscoreTextLabel)
    }
    
    func showStage() {
        stageLabel.position = CGPoint(x: self.frame.maxX - 60, y: self.frame.maxY - 140)
        stageLabel.fontSize = 30
        stageLabel.fontName = "Chalkduster"
        stageLabel.fontColor = UIColor.white
        stageLabel.text = "Stage 1"
        stageLabel.zPosition = 1
        self.addChild(stageLabel)
    }
    
    func levelUp() {
        if 1 <= Model.sharedInstance.score && Model.sharedInstance.score < 20 {
            stageLabel.text = "Stage 1"
            coinObject.speed = 1.05
            redCoinObject.speed = 1.1
            movingObject.speed = 1.05
            self.speed = 1.05
        } else if 20 <= Model.sharedInstance.score && Model.sharedInstance.score < 36 {
            stageLabel.text = "Stage 2"
            coinObject.speed = 1.22
            redCoinObject.speed = 1.32
            movingObject.speed = -1.22
            self.speed = 1.22
        } else if 36 <= Model.sharedInstance.score && Model.sharedInstance.score < 56 {
            stageLabel.text = "Stage 3"
            coinObject.speed = 1.3
            redCoinObject.speed = 1.35
            movingObject.speed = 1.3
            self.speed = 1.3
        }
    }
    
    func timerFunc() {
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        
        
        switch gSceneDifficulty.rawValue {
        case 0: //easy mode
            timerAddCoin = Timer.scheduledTimer(timeInterval: 2.64, target: self, selector: #selector(GameScene.addCoin), userInfo: nil, repeats: true)
            timerAddRedCoin = Timer.scheduledTimer(timeInterval: 100.246, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
            timerAddBox1 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox1), userInfo: nil, repeats: true)
            timerAddBox2 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox2), userInfo: nil, repeats: true)
            timerAddBox3 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox3), userInfo: nil, repeats: true)
            timerAddBush1 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush1), userInfo: nil, repeats: true)
            timerAddBush2 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush2), userInfo: nil, repeats: true)
            timerAddBush3 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush3), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 10.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        case 1: //medium mode
            timerAddCoin = Timer.scheduledTimer(timeInterval: 3.64, target: self, selector: #selector(GameScene.addCoin), userInfo: nil, repeats: true)
            timerAddRedCoin = Timer.scheduledTimer(timeInterval: 800.246, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
            timerAddBox1 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox1), userInfo: nil, repeats: true)
            timerAddBox2 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox2), userInfo: nil, repeats: true)
            timerAddBox3 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addbox3), userInfo: nil, repeats: true)
            timerAddBush1 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush1), userInfo: nil, repeats: true)
            timerAddBush2 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush2), userInfo: nil, repeats: true)
            timerAddBush3 = Timer.scheduledTimer(timeInterval: 3.245, target: self, selector: #selector(GameScene.addBush3), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 15.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        case 2: //hard mode
            timerAddCoin = Timer.scheduledTimer(timeInterval: 3.64, target: self, selector: #selector(GameScene.addCoin), userInfo: nil, repeats: true)
            timerAddRedCoin = Timer.scheduledTimer(timeInterval: 1000.246, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
            timerAddBox1 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addbox1), userInfo: nil, repeats: true)
            timerAddBox2 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addbox2), userInfo: nil, repeats: true)
            timerAddBox3 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addbox3), userInfo: nil, repeats: true)
            timerAddBush1 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addBush1), userInfo: nil, repeats: true)
            timerAddBush2 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addBush2), userInfo: nil, repeats: true)
            timerAddBush3 = Timer.scheduledTimer(timeInterval: 2.245, target: self, selector: #selector(GameScene.addBush3), userInfo: nil, repeats: true)
            timerAddShieldItem = Timer.scheduledTimer(timeInterval: 18.246, target: self, selector: #selector(GameScene.addShieldItem), userInfo: nil, repeats: true)
        default: break
        }
    }
    
    func stopGameObject() {
        coinObject.speed = 0
        redCoinObject.speed = 0
        movingObject.speed = 0
        heroObject.speed = 0
    }
    
    func reloadGame() {
        
        if Model.sharedInstance.sound == true {
            SKTAudio.sharedInstance().resumeBackgroundMusic()
        }
        
        coinObject.removeAllChildren()
        redCoinObject.removeAllChildren()
        
        stageLabel.text = "Stage 1"
        gameover = 0
        scene?.isPaused = false
        
        movingObject.removeAllChildren()
        heroObject.removeAllChildren()
        botObject.removeAllChildren()
        
        coinObject.speed = 1
        heroObject.speed = 1
        botObject.speed = 1
        movingObject.speed = 1
        self.speed = 1
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
        
        createGround()
        createSky()
        createModerator()
        createHero()
        createBot()
        
        gameViewControllerBridge.returnMainBtn.isHidden = true
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        stageLabel.isHidden = false
        highscoreTextLabel.isHidden = true
        showHighscore()

        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        timerAddBox1.invalidate()
        timerAddBox2.invalidate()
        timerAddBox3.invalidate()

        timerAddBush1.invalidate()
        timerAddBush2.invalidate()
        timerAddBush3.invalidate()
        
        timerFunc()
    }
    
    override func didFinishUpdate() {
        shield.position = hero.position + CGPoint(x: 0, y: 0)
    }
    
    func removeAll() {
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameover = 0
        
        if labelObject.children.count != 0 {
            labelObject.removeAllChildren()
        }
        
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        timerAddMine.invalidate()
        timerAddShieldItem.invalidate()
        
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
        gameViewControllerBridge = nil
    }
}
