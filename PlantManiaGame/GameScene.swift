//
//  GameScene.swift
//  PlantManiaGame
//
//  Created by William Chen on 5/6/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import AVFoundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var walletAudio = AVAudioPlayer()
    var coins = 0
    var plantNum = 4
    var life = 3
    let coinLabel = SKLabelNode(text: "Coins: 0")
    
    let player = SKSpriteNode(imageNamed: "stanley")
    var plantArray = Array<SKSpriteNode>()
    
    var playerStunned = false
    
    //let spraySound = SKAction.playSoundFileNamed(<#T##soundFile: String##String#>, waitForCompletion: false)
    
    struct PhysicsCategories{
        static let None: UInt32 = 0
        static let Player: UInt32 = 0b1 //1
        static let Spray: UInt32 = 0b10 //2
        static let Plant: UInt32 = 0b100 //4
        static let Bug: UInt32 = 0b1000 //8
    }
    
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    
    
    var gameArea: CGRect
    
    override init(size: CGSize){
        
        let maxRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "sky")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        coinLabel.fontSize = 70
        coinLabel.fontColor = SKColor.black
        coinLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinLabel.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0.9)
        coinLabel.zPosition = 100
        self.addChild(coinLabel)
        
        
        player.setScale(0.3)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.25)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask =  PhysicsCategories.Bug
        self.addChild(player)
        
        let plant1 = SKSpriteNode(imageNamed: "rose")
        let plant2 = SKSpriteNode(imageNamed: "cactus")
        let plant3 = SKSpriteNode(imageNamed: "lilac")
        let plant4 = SKSpriteNode(imageNamed: "sunflower")
        plantArray.append(plant1)
        plantArray.append(plant2)
        plantArray.append(plant3)
        plantArray.append(plant4)
        
        for i in 0..<plantArray.count{
            let plant = plantArray[i]
            plant.setScale(0.25)
            plant.position = CGPoint(x: self.size.width * CGFloat(0.2 * Double(i) + 0.2), y: self.size.height * 0.1)
            plant.zPosition = 2
            plant.physicsBody = SKPhysicsBody(rectangleOf: plant.size)
            plant.physicsBody!.affectedByGravity = false
            plant.physicsBody!.categoryBitMask = PhysicsCategories.Plant
            plant.physicsBody!.collisionBitMask = PhysicsCategories.None
            plant.physicsBody!.contactTestBitMask = PhysicsCategories.Bug
            self.addChild(plant)
        }
        
        startGame()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            body1 = contact.bodyA
            body2 = contact.bodyB
        }
        else{
            body1 = contact.bodyB
            body2 = contact.bodyA
        }
        
        //if player makes contact with bug
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Bug{
            playerStunned = true
            if(body2.node != nil){
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            life -= 1
            
            if life == 0{
                runGameOver()
            }
            
            body2.node?.removeFromParent()
            let scaleOut = SKAction.scale(to: 0, duration: 0.1)
            let scaleIn = SKAction.scale(to: 0.3, duration: 0.1)
            
            
            let deathSequence = SKAction.sequence([scaleIn, scaleOut, scaleIn, scaleOut, scaleIn, scaleOut, scaleIn])
            
            
            player.run(deathSequence)
            playerStunned = false
        }
        
        //if spray hits bug
        if body1.categoryBitMask == PhysicsCategories.Spray && body2.categoryBitMask == PhysicsCategories.Bug && (body2.node?.position.y)! < self.size.height{
            
            addScore()
            
            if(body2.node != nil){
                spawnCoin(spawnPosition: body2.node!.position)
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
        }
        
        //if bug hits a plant
        if body1.categoryBitMask == PhysicsCategories.Plant && body2.categoryBitMask == PhysicsCategories.Bug{
            
            
            if body2.node != nil {
                spawnExplosion(spawnPosition: body2.node!.position)
            }
            
            let emptyPot = SKSpriteNode(imageNamed: "pot")
            emptyPot.setScale(0.25)
            emptyPot.position = (body1.node?.position)!
            emptyPot.zPosition = 2
            self.addChild(emptyPot)
            
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            plantNum -= 1
            
            if plantNum == 0{
                runGameOver()
            }
            
        }
    }
    
    func hitPlayer() {
        
        
        player.setScale(0)
        
    }
    
    func runGameOver(){
        
        self.removeAllActions()
        self.enumerateChildNodes(withName: "Spray"){
            spray, stop in
            
            spray.removeAllActions()
        }
        
        self.enumerateChildNodes(withName: "Bug"){
            bug, stop in
            
            bug.removeAllActions()
        }
        
    }
    
    func spawnCoin(spawnPosition: CGPoint){
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.position = spawnPosition
        coin.zPosition = 3
        coin.setScale(0)
        self.addChild(coin)
        let cashSound = Bundle.main.path(forResource: "Chaching", ofType: "mp3")
        do {
            walletAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: cashSound!))
        } catch {
            print(error)
        }
        walletAudio.play()
        
        let scaleIn = SKAction.scale(to: 0.3, duration: 0.3)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let delete = SKAction.removeFromParent()
        
        let coinSequence = SKAction.sequence([scaleIn,fadeOut,delete])
        
        coin.run(coinSequence)
    }
    
    func spawnExplosion(spawnPosition: CGPoint){
        
        let explosion = SKSpriteNode(imageNamed: "explosition")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([scaleIn,fadeOut,delete])
        
        explosion.run(explosionSequence)
    }
    
    
    func startGame(){
        
        let spawn = SKAction.run(spawnBugs)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    func fireSpray(){
        
//        let spray = SKSpriteNode(imageNamed: "bullet")
//        spray.setScale(1)
        let spray = SKSpriteNode(imageNamed: "spray")
        spray.setScale(0.2)

        spray.position = player.position
        spray.zPosition = 1
        spray.physicsBody = SKPhysicsBody(rectangleOf: spray.size)
        spray.physicsBody!.affectedByGravity = false
        spray.physicsBody!.categoryBitMask = PhysicsCategories.Spray
        spray.physicsBody!.collisionBitMask = PhysicsCategories.None
        spray.physicsBody!.contactTestBitMask =  PhysicsCategories.Bug
        self.addChild(spray)
        
        let moveSpray = SKAction.moveTo(y: self.size.height + spray.size.height, duration: 1)
        let deleteSpray = SKAction.removeFromParent()
//        let spraySequence = SKAction.sequence([spraySound, moveSpray, deleteSpray])
        let spraySequence = SKAction.sequence([moveSpray, deleteSpray])

        spray.run(spraySequence)
        
        
    }
    
    
    func spawnBugs(){
        
        let randomStartX = random(min: gameArea.minX, max: gameArea.maxX)
        let randomEndX = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomStartX, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomEndX, y: self.size.height * 0.1)
        
//        let bug = SKSpriteNode(imageNamed: "enemyShip")
//        bug.setScale(0.7)
        let bug = SKSpriteNode(imageNamed: "bug")
        bug.setScale(0.2)
        bug.position = startPoint
        bug.zPosition = 2
        bug.physicsBody = SKPhysicsBody(rectangleOf: bug.size)
        bug.physicsBody!.affectedByGravity = false
        bug.physicsBody!.categoryBitMask = PhysicsCategories.Bug
        bug.physicsBody!.collisionBitMask = PhysicsCategories.None
        bug.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Spray | PhysicsCategories.Plant
        self.addChild(bug)
        
        let moveBug = SKAction.move(to: endPoint, duration: 1.5)
        let deleteBug = SKAction.removeFromParent()
        let bugSequence = SKAction.sequence([moveBug, deleteBug])
        bug.run(bugSequence)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        let rotate = atan2(dy, dx)
        bug.zRotation = rotate
        
    }
    
    func addScore(){
        coins += 1
        coinLabel.text = "Coins: \(coins)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!playerStunned){
            fireSpray()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            player.position.x += amountDragged
            
            if player.position.x > gameArea.maxX - player.size.width/2{
                player.position.x = gameArea.maxX - player.size.width/2
            }
            
            if player.position.x < gameArea.minX + player.size.width/2{
                player.position.x = gameArea.minX + player.size.width/2
            }
        }
    }
    
}
