//
//  State.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation

class State : NSObject {
    var name: String?
    
    func enter(owner: BaseGameEntity) -> Void {}
//    func execute(owner: BaseGameEntity, deltaTime: Double, world: World) -> Void {}
    func execute(owner: BaseGameEntity) -> Void {}
    func exit(owner: BaseGameEntity) -> Void {}
    func onMessage(owner: BaseGameEntity, telegram: Telegram) -> Bool { return true }
}