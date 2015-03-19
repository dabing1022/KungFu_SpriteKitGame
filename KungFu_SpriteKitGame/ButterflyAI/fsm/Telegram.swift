//
//  Telegram.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation

struct Telegram {
    static var sameTimeInterval: CFTimeInterval = 250
    
    var sender: Int?
    var receiver: Int?
    var message: Int?
    var dispatchTime: CFTimeInterval?
    var extroInfo: AnyObject?
    
    init(sender: Int, receiver: Int, dispatchTime: CFTimeInterval, message: Int, extroInfo: AnyObject) {
        self.sender = sender
        self.receiver = receiver
        self.dispatchTime = dispatchTime
        self.message = message
        self.extroInfo = extroInfo
    }
    
    func compareTo(anotherTelegram: Telegram) -> Int {
        if (self.sender! == anotherTelegram.sender!
            && self.receiver! == anotherTelegram.receiver!
            && abs(self.dispatchTime! - anotherTelegram.dispatchTime!) <= Telegram.sameTimeInterval
            && self.message! == anotherTelegram.message!) {
                return 1
        } else {
            return self.dispatchTime! <= anotherTelegram.dispatchTime! ? -1 : 1
        }
    }
}