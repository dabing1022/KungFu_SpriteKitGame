//
//  SquareTurtle.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/18.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import SpriteKit

class SquareTurtle : SKSpriteNode {
    
    convenience override init() {
        self.init(texture: nil, color: nil, size: CGSize.zeroSize)
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = nil
        self.size = CGSize(width: 32, height: 32)
        name = "NinjaTurtle"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Leo: SquareTurtle {

    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.color = SKColor(red: 1.0 / 255.0, green: 128.0 / 255.0, blue: 191.0 / 255.0, alpha: 1)
        name = "Turtle_Leo"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Raph: SquareTurtle {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.color =  SKColor(red: 220.0 / 255.0, green: 56.0 / 255.0, blue: 74.0 / 255.0, alpha: 1)
        name = "Turtle_Raph"
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Mikey: SquareTurtle {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.color =  SKColor(red: 249.0 / 255.0, green: 150.0 / 255.0, blue: 25.0 / 255.0, alpha: 1)
        name = "Turtle_Mikey"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Don: SquareTurtle {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.color =  SKColor(red: 113.0 / 255.0, green: 132.0 / 255.0, blue: 191.0 / 255.0, alpha: 1)
        name = "Turtle_Don"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
