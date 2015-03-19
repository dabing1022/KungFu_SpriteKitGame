//
//  TurtlesTestScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/18.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class TurtlesTestScene : GameScene {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        super.changeBackLabelStyle(isBlackStyle: false)
        
        let leo = Leo()
        leo.position = CGPoint(x: 100, y: 100)
        self.addChild(leo)
        
        let raph = Raph()
        raph.position = CGPoint(x: 150, y: 150)
        self.addChild(raph)
        
        let mikey = Mikey()
        mikey.position = CGPoint(x: 200, y: 200)
        self.addChild(mikey)
        
        let don = Don()
        don.position = CGPoint(x: 250, y: 250)
        self.addChild(don)
    }
}