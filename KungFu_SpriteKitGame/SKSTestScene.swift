//
//  SKSTestScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/18.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class SKSTestScene : GameScene {
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        super.changeBackLabelStyle(isBlackStyle: false)
        
        let ship = self.childNodeWithName("ship") as! SKSpriteNode
        let light = ship.childNodeWithName("light2") as! SKLightNode
        
        let greenSquare = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 10, height: 10))
        greenSquare.name = "greenSquare"
        greenSquare.position = self.convertPoint(light.position, fromNode: ship)
        self.addChild(greenSquare)
        
        // add constraints
        let angleConstraint = SKConstraint.orientToNode(greenSquare, offset: SKRange(value: 0, variance: 0))
        let distanceConstraint = SKConstraint.distance(SKRange(value: 120, variance: 100), toNode: greenSquare)
        ship.constraints = [angleConstraint, distanceConstraint]
    }
    
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let ship = self.childNodeWithName("ship") as! SKSpriteNode
        let light = ship.childNodeWithName("light2") as! SKLightNode
        let pos = touch.locationInNode(ship)
        
        let greenSquare = self.childNodeWithName("greenSquare") as! SKSpriteNode
        light.position = pos
        greenSquare.position = self.convertPoint(light.position, fromNode: ship)
        
        super.touchesMoved(touches, withEvent: event)
    }
}
