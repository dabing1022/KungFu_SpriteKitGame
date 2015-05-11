//
//  BoxNinjaScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/20.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class BoxNinjaScene : GameScene, SKPhysicsContactDelegate {
    let leo = Leo()
    var lWall: SKSpriteNode!
    var lWall2: SKSpriteNode!
    var rWall: SKSpriteNode!
    var rWall2: SKSpriteNode!
    var obstacles = [SquareTurtle]()
    var tick: Int = 0
    
    struct Constants {
        static let impulseX: Int = 50
        static let wallWidth: CGFloat = 20.0
        static let wallColor: SKColor = SKColor(red: 132.0/255.0, green: 56.0/255.0, blue: 105.0/255.0, alpha: 1.0)
        static let wallSpeed: CGVector = CGVector(dx: 0, dy: -200)
        static let obstacleSpeed: CGVector = CGVector(dx: 0, dy: -200)
        static let wallName = "wall"
    }
    
    enum ColliderType : UInt32 {
        case Leo = 0x01
        case Wall = 0x02
        case Obstacle = 0x04
    }
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        self.backgroundColor = SKColor(red: 46.0/255.0, green: 38.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        
        setPhysicsWorld()
        setHero()
        
        leo.position = CGPoint(x: Constants.wallWidth + leo.size.width/2, y: 30.0)
        leo.physicsBody = SKPhysicsBody(rectangleOfSize: leo.size)
        leo.physicsBody?.dynamic = true
        leo.physicsBody?.allowsRotation = false
        leo.physicsBody?.restitution = 0
        leo.physicsBody?.categoryBitMask = ColliderType.Leo.rawValue
        leo.physicsBody?.collisionBitMask = ColliderType.Wall.rawValue
        leo.physicsBody?.contactTestBitMask = ColliderType.Wall.rawValue | ColliderType.Obstacle.rawValue
        self.addChild(leo)
        
        lWall = SKSpriteNode(color: Constants.wallColor, size: CGSize(width: Constants.wallWidth, height: self.size.height))
        lWall.physicsBody = SKPhysicsBody(rectangleOfSize: lWall.size)
        lWall.physicsBody?.dynamic = false
        lWall.physicsBody?.restitution = 0
        lWall.physicsBody?.categoryBitMask = ColliderType.Wall.rawValue
        lWall.physicsBody?.collisionBitMask = ColliderType.Leo.rawValue
        lWall.physicsBody?.contactTestBitMask = ColliderType.Leo.rawValue
        lWall.position = CGPoint(x: Constants.wallWidth/2, y: self.size.height/2)
        lWall.name = Constants.wallName
        self.addChild(lWall)
        
        lWall2 = SKSpriteNode(color: Constants.wallColor, size: CGSize(width: Constants.wallWidth, height: self.size.height))
        lWall2.physicsBody = SKPhysicsBody(rectangleOfSize: lWall.size)
        lWall2.physicsBody?.dynamic = false
        lWall2.physicsBody?.restitution = 0
        lWall2.physicsBody?.categoryBitMask = ColliderType.Wall.rawValue
        lWall2.physicsBody?.collisionBitMask = ColliderType.Leo.rawValue
        lWall2.physicsBody?.contactTestBitMask = ColliderType.Leo.rawValue
        lWall2.position = CGPoint(x: Constants.wallWidth/2, y: self.size.height/2 + self.size.height)
        lWall2.name = Constants.wallName
        self.addChild(lWall2)
        
        rWall = SKSpriteNode(color: Constants.wallColor, size: lWall.size)
        rWall.physicsBody = SKPhysicsBody(rectangleOfSize: rWall.size)
        rWall.physicsBody?.dynamic = false
        rWall.physicsBody?.restitution = 0
        rWall.physicsBody?.categoryBitMask = ColliderType.Wall.rawValue
        rWall.physicsBody?.collisionBitMask = ColliderType.Leo.rawValue
        rWall.physicsBody?.contactTestBitMask = ColliderType.Leo.rawValue
        rWall.position = CGPoint(x: self.size.width-Constants.wallWidth/2, y: self.size.height/2)
        rWall.name = Constants.wallName
        self.addChild(rWall)
        
        rWall2 = SKSpriteNode(color: Constants.wallColor, size: lWall.size)
        rWall2.physicsBody = SKPhysicsBody(rectangleOfSize: rWall.size)
        rWall2.physicsBody?.dynamic = false
        rWall2.physicsBody?.restitution = 0
        rWall2.physicsBody?.categoryBitMask = ColliderType.Wall.rawValue
        rWall2.physicsBody?.collisionBitMask = ColliderType.Leo.rawValue
        rWall2.physicsBody?.contactTestBitMask = ColliderType.Leo.rawValue
        rWall2.position = CGPoint(x: self.size.width-Constants.wallWidth/2, y: self.size.height/2 + self.size.height)
        rWall2.name = Constants.wallName
        self.addChild(rWall2)
    }
    
    func setPhysicsWorld() {
        physicsWorld.gravity = CGVector.zeroVector
        physicsWorld.contactDelegate = self
    }
    
    func setHero() {
        leo.state = SquareTurtle.HeroState.RUNNING_L_STATE
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        if leo.state == SquareTurtle.HeroState.FLYING_ON_AIR_STATE {
            return
        }
        
        let touch = touches.first as! UITouch
        var impulse: CGVector!
        let actionDuration = 0.5
        if leo.state == SquareTurtle.HeroState.RUNNING_L_STATE {
            impulse = CGVector(dx: Constants.impulseX, dy: 0)
        } else if leo.state == SquareTurtle.HeroState.RUNNING_R_STATE {
            impulse = CGVector(dx: -Constants.impulseX, dy: 0)
        }
        leo.physicsBody?.applyImpulse(impulse)
        leo.state = SquareTurtle.HeroState.FLYING_ON_AIR_STATE
        
        super.touchesBegan(touches, withEvent: event)
    }

    
    override func update(currentTime: NSTimeInterval) {
        updateWallPos()
        
        tick++
        if tick % 50 == 0 {
            tick = 0
            let obstacle = Raph()
            let left = arc4random_uniform(2)
            var posX: CGFloat!
            if left == 0 {
                posX = Constants.wallWidth + obstacle.size.width/2
            } else {
                posX = self.size.width - Constants.wallWidth - obstacle.size.width/2
            }
            obstacle.position = CGPoint(x: posX, y: self.size.height + 100)
            obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: leo.size)
            obstacle.physicsBody?.dynamic = true
            obstacle.physicsBody?.allowsRotation = false
            obstacle.physicsBody?.restitution = 0
            obstacle.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
            obstacle.physicsBody?.collisionBitMask = ColliderType.Wall.rawValue
            obstacle.physicsBody?.contactTestBitMask = ColliderType.Leo.rawValue | ColliderType.Wall.rawValue
            obstacle.name = "obstacle"
            self.addChild(obstacle)
        }
        enumerateChildNodesWithName("obstacle", usingBlock: { (node: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            node.position.y += Constants.obstacleSpeed.dy * 1.0 / 60.0
            if node.position.y <= -200 {
                node.removeFromParent()
            }
        })
        
    }
    
    func updateWallPos() {
        lWall.position.y += Constants.wallSpeed.dy * 1.0 / 60.0
        lWall2.position.y += Constants.wallSpeed.dy * 1.0 / 60.0
        rWall.position.y += Constants.wallSpeed.dy * 1.0 / 60.0
        rWall2.position.y += Constants.wallSpeed.dy * 1.0 / 60.0
        
        if lWall.position.y <= -self.size.height * 0.5 {
            lWall.position.y = lWall2.position.y + lWall.size.height
        } else if lWall2.position.y <= -self.size.height * 0.5 {
            lWall2.position.y = lWall.position.y + lWall2.size.height
        }
        if rWall.position.y <= -self.size.height * 0.5 {
            rWall.position.y = rWall2.position.y + rWall.size.height
        } else if rWall2.position.y <= -self.size.height * 0.5 {
            rWall2.position.y = rWall.position.y + rWall2.size.height
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody!
        var secondBody: SKPhysicsBody!
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask == ColliderType.Leo.rawValue) && (secondBody.categoryBitMask == ColliderType.Wall.rawValue) {
            let leo = firstBody.node as! Leo
            if leo.position.x > self.size.width / 2 {
                leo.state = SquareTurtle.HeroState.RUNNING_R_STATE
            } else {
                leo.state = SquareTurtle.HeroState.RUNNING_L_STATE
            }
        }
        
        if (firstBody.categoryBitMask == ColliderType.Leo.rawValue) && (secondBody.categoryBitMask == ColliderType.Obstacle.rawValue) {
            if contact.contactNormal.dy == 0 {
                let node = secondBody.node
                node?.removeFromParent()
            } else if contact.contactNormal.dx == 0 {
                leo.removeFromParent()
            }
        }
    }
}
