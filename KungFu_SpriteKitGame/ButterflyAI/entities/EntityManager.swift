//
//  EntityManager.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation

class EntityManager {
    class var sharedInstance: EntityManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: EntityManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = EntityManager()
        }
        return Static.instance!
    }
    
    var entityMap: Dictionary<Int, BaseGameEntity>?
    init() {
        entityMap = Dictionary<Int, BaseGameEntity>()
    }
    
    func registerEntity(entity: BaseGameEntity) -> Void {
        entityMap?.updateValue(entity, forKey: entity.entityID!)
    }

    func removeEntity(entity: BaseGameEntity) -> Void {
        entityMap?.removeValueForKey(entity.entityID!)
    }
    
    func entityFromID(entityID: Int) -> BaseGameEntity? {
        if let map = entityMap {
            return map[entityID]
        } else {
            return nil
        }
    }
}