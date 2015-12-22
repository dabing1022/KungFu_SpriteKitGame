//
//  SKSTestScene2.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/12/22.
//  Copyright © 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class SKSTestScene2: GameScene {
    var player: SKSpriteNode?
    var zombies: [SKSpriteNode] = []
    var goal: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        super.changeBackLabelStyle(isBlackStyle: false)
        
        player = self.childNodeWithName("player") as? SKSpriteNode
        
        for child in self.children {
            if (child.name == "zombie") {
                if let child = child as? SKSpriteNode {
                    zombies.append(child)
                }
            }
        }
        
        goal = self.childNodeWithName("goal") as? SKSpriteNode
        
    }
}