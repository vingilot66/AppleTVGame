//
//  GameScene.swift
//  Assignment2Game
//
//  Created by Christopher Reynolds on 2019-11-26.
//  Copyright © 2019 Christopher Reynolds. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory{
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Baddy : UInt32 = 0b1
    static let Hero : UInt32 = 0b10
    static let Projectile : UInt32 = 0b11
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    private var label : SKLabelNode?
    var background = SKSpriteNode(imageNamed: "space2.jpg")
    var sportNode : SKSpriteNode?
    var lives :Int?
    var score : Int?
    var livesIncrement = -1
    var lblLives : SKLabelNode?
    var lblGameover : SKLabelNode?
    var lblHighscore : SKLabelNode?
    var lblScore : SKLabelNode?
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width/2-150, y: frame.size.height/2-150)
        background.alpha = 0.2
        addChild(background)
        
        sportNode = SKSpriteNode(imageNamed: "enterprise2.png")
        sportNode?.position = CGPoint(x: 0 - frame.size.width/2.3, y: 10)
        addChild(sportNode!)
        
        lblGameover = self.childNode(withName: "//gameover") as! SKLabelNode
        lblGameover?.alpha = 0
        
        lblHighscore = self.childNode(withName: "//highscore") as! SKLabelNode
        lblHighscore?.alpha = 0

        score = 0
        lblScore = self.childNode(withName: "//score") as! SKLabelNode
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        physicsWorld.contactDelegate = self
        
        sportNode?.physicsBody = SKPhysicsBody(circleOfRadius: sportNode!.size.width/2)
        sportNode?.physicsBody?.isDynamic = true
        sportNode?.physicsBody?.categoryBitMask = PhysicsCategory.Hero
        sportNode?.physicsBody?.contactTestBitMask = PhysicsCategory.Baddy
        sportNode?.physicsBody?.collisionBitMask = PhysicsCategory.None
        sportNode?.physicsBody?.usesPreciseCollisionDetection = true
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBaddy), SKAction.wait(forDuration: 0.5)])))
        
        lives = 3
        lblLives = self.childNode(withName: "//lives") as! SKLabelNode
        lblLives?.text = "Lives: \(lives!)"
        if let slabel = self.lblLives{
            slabel.alpha = 0
            slabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func addBaddy(){
        if (lives! != 0 || lives! < 0){
            var baddy = SKSpriteNode(imageNamed: "klingon3.png")
            
            baddy.xScale = baddy.xScale * -1
            let actualy = random(min: baddy.size.height/2-350, max: size.height - baddy.size.height)
            baddy.position = CGPoint(x: size.width+baddy.size.width/2, y: actualy)
            addChild(baddy)
            
            baddy.physicsBody = SKPhysicsBody(rectangleOf: baddy.size)
            baddy.physicsBody?.isDynamic = true
            baddy.physicsBody?.categoryBitMask = PhysicsCategory.Baddy
            baddy.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
            baddy.physicsBody?.collisionBitMask = PhysicsCategory.None
            

            
            let actualDirection = random(min: 3.0, max: 5.0)
            
            let actionMove = SKAction.move(to: CGPoint(x: -baddy.size.width/2-500, y: actualy), duration: TimeInterval(actualDirection))
            
            let actionMoveDone = SKAction.removeFromParent()
            baddy.run(SKAction.sequence([actionMove, actionMoveDone]))
            score = score! + 1
            lblScore?.text = "Score: \(score!)"
        }
    }
    
    func heroDidCollideWithBaddy(){
        if (lives! != 0){
            lives = lives! + livesIncrement
            lblLives?.text = "Lives: \(lives!)"
        }
            
        if let llabel = self.lblLives{
            llabel.alpha = 0
            llabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        if lives == 0{
            lblGameover?.alpha = 1
            lblHighscore?.text = "Submitted Score of \(score!) to Highscores"
            lblHighscore?.alpha = 1
            let texture1 = SKTexture(imageNamed: "boom.png")
            let action = SKAction.setTexture(texture1, resize: true)
            sportNode?.run(action)
            let actionMoveDone = SKAction.rotate(byAngle: 360.0, duration: 1.0)
            sportNode?.run(SKAction.sequence([actionMoveDone]))
            sportNode!.run(SKAction.fadeOut(withDuration: 2.0))
        }
            
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Baddy != 0) && (secondBody.categoryBitMask & PhysicsCategory.Hero != 0)){
            heroDidCollideWithBaddy()
        }
    }
    
    func random(min: CGFloat, max : CGFloat) -> CGFloat {
        return random() * (max-min) + min
    }
    
    func moveGoodGuy(toPoint pos : CGPoint){
        if lives! > 0{
            let actionMove = SKAction.move(to: pos, duration: 2.0)
        
            sportNode!.run(SKAction.sequence([actionMove]))
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        moveGoodGuy(toPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        moveGoodGuy(toPoint: pos)
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
