//
//  SKSTestScene2.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/12/22.
//  Copyright © 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class SKSTestScene2: GameScene {
    let playerSpeed: CGFloat = 150.0
    let zombieSpeed: CGFloat = 75.0
    
    var player: SKSpriteNode?
    var stars: [SKSpriteNode] = []
    var goal: SKSpriteNode?
    var lastTouchLoc: CGPoint?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        super.changeBackLabelStyle(isBlackStyle: false)
        
        player = self.childNodeWithName("player") as? SKSpriteNode
        
        for child in self.children {
            if (child.name == "star") {
                if let child = child as? SKSpriteNode {
                    stars.append(child)
                }
            }
        }
        
        goal = self.childNodeWithName("goal") as? SKSpriteNode
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handleTouches(touches)
    }
    
    func handleTouches(touches: Set<UITouch>) {
        for touch in touches {
            let touchLoc = touch.locationInNode(self)
            lastTouchLoc = touchLoc
        }
    }
    
    private func shouldMove(currentPosition currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
        return abs(currentPosition.x - touchPosition.x) > player!.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > player!.frame.height/2
    }
    
    override func didSimulatePhysics() {
        if let _ = player {
            updatePlayer()
        }
    }
    
    private func updatePlayer() {
        if let touchLoc = lastTouchLoc {
            let playerLoc = player!.position
            if shouldMove(currentPosition: playerLoc, touchPosition: touchLoc) {
                let angle = atan2(playerLoc.y - touchLoc.y, playerLoc.x - touchLoc.x) + CGFloat(M_PI)
                let rotateAction = SKAction.rotateToAngle(angle + CGFloat(M_PI*0.5), duration: 0)
                
                player!.runAction(rotateAction)
                
                let velocotyX = playerSpeed * cos(angle)
                let velocityY = playerSpeed * sin(angle)
                
                let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                player!.physicsBody!.velocity = newVelocity;
                updateCamera()
            } else {
                player!.physicsBody!.resting = true
            }
        }
    }
    
    private func updateCamera() {
        if let camera = camera {
            camera.position = CGPoint(x: player!.position.x, y: player!.position.y)
        }
    }
}