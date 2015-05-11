//
//  PhysicsMagneticFieldTestScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/19.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class PhysicsMagneticFieldTestScene : GameScene {
    
    let magneticFieldNode = SKFieldNode.magneticField()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        super.changeBackLabelStyle(isBlackStyle: false)
        
        let wallBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9)
        self.physicsBody = wallBody
        
        for var index = 0; index < 100; ++index {
            let shape = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 25, height: 25))
            let posX = CGFloat(arc4random() % (UInt32((self.size.width - 20))))
            let posY = CGFloat(arc4random() % 200) + self.size.height/2
            shape.position = CGPoint(x: posX, y: posY)
            shape.physicsBody = SKPhysicsBody(rectangleOfSize: shape.frame.size)
            shape.physicsBody?.dynamic = true
            shape.physicsBody?.affectedByGravity = true
            shape.physicsBody?.allowsRotation = true
            shape.physicsBody?.mass = 0.9
            self.addChild(shape)
        }
        
        magneticFieldNode.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        magneticFieldNode.position = CGPoint(x: 100, y: 100)
        magneticFieldNode.strength = 3
        self.addChild(magneticFieldNode)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches {
            let touch = touch as! UITouch
            magneticFieldNode.position = touch.locationInNode(self)
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
}
