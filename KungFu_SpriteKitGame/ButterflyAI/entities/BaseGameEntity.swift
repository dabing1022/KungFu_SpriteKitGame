//
//  BaseEntity.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation

class BaseGameEntity {
    private struct NextValidIDStruct {
        static var nextValidID = Int.min
    }
    
    class var nextValidID: Int {
        get {
            return NextValidIDStruct.nextValidID
        }
        
        set {
            NextValidIDStruct.nextValidID = newValue
        }
    }
    
    
    var entityID: Int?
    var name: String?
    var tag: String?
    var tagNo: Int = 0
    var visible: Bool = true;
    var pos: Point?
    var colRadius: Double?
    var fsm: FiniteStateMachine?
    var z: Int = 0
    var overlapAllowed: Bool = false
    
    init(entityID: Int) {
        self.entityID = entityID
        BaseGameEntity.nextValidID = self.entityID! + 1
    }
}