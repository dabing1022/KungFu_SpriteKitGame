//
//  Dispatcher.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation
import UIKit

class MessageDispatcher {
    class var sharedInstance: MessageDispatcher {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: MessageDispatcher? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = MessageDispatcher()
        }
        return Static.instance!
    }
    
    private var telegrams: Dictionary<Int, Telegram>
    private var priorityQ: Array<Telegram>
    init() {
        telegrams = Dictionary<Int, Telegram>()
        priorityQ = Array<Telegram>()
    }


    
    func dispatch(delay: CFTimeInterval, sender: Int, receiver: Int, message: Int, extroInfo: AnyObject) -> Void {
        var receiverEntity = EntityManager.sharedInstance.entityFromID(receiver)
        if (receiverEntity != nil && receiverEntity?.fsm != nil) {
            var telegram = Telegram(sender: sender, receiver: receiver, dispatchTime: CACurrentMediaTime() + delay, message: message, extroInfo: extroInfo)
                telegrams.updateValue(telegram, forKey: receiver)
            
            if delay <= 0 {
                sendTelegram(receiverEntity!, telegram: telegram)
            } else {
                priorityQ.append(telegram)
                priorityQ.sort({ (telegramA: Telegram, telegramB: Telegram) -> Bool in
                    return telegramA.dispatchTime <= telegramB.dispatchTime
                })
            }
        }
    }
    
    func sendTelegram(receiver: BaseGameEntity, telegram: Telegram) -> Void {
        if receiver.fsm != nil {
            
        }
    }
    
    func update(receiver: Int, telegram: Telegram) -> Void {
        while (priorityQ.first?.dispatchTime < CACurrentMediaTime() && priorityQ.count > 0) {
            var telegram = priorityQ.first!
            var receiverEntity = EntityManager.sharedInstance.entityFromID(telegram.receiver!)
            if let entity = receiverEntity {
                sendTelegram(entity, telegram: telegram)
                priorityQ.removeAtIndex(0)
            }
        }
    }
        
    func deleteAllTelegrams() -> Void {
        telegrams.removeAll(keepCapacity: false)
    }
}