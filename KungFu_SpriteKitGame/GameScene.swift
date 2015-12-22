//
//  GameScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/11.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let LABEL_NAME = "backToDemoList"
    
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Back";
        myLabel.fontColor = SKColor.blackColor()
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x: 120, y: 50);
        myLabel.name = LABEL_NAME
        
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if node.name == LABEL_NAME {
                let transition = SKTransition.crossFadeWithDuration(1.0)
                let scene = DemoListScene(size: self.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
    
    func changeBackLabelStyle(isBlackStyle black: Bool) -> Void {
        let label = self.childNodeWithName(LABEL_NAME) as! SKLabelNode
        label.fontColor = black ? SKColor.blackColor() : SKColor.whiteColor()
    }
}
