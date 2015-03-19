//
//  FiniteStateMachine.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/15.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import Foundation

class FiniteStateMachine {
    var owner: BaseGameEntity
    var currentState: State?
    var previousState: State?
    var globalState: State?
    
    
    init(owner: BaseGameEntity) {
        self.owner = owner
    }
    
    func update() -> Void {
        if (globalState != nil) {
            globalState!.execute(owner)
        }
        
        if (currentState != nil) {
            currentState!.execute(owner)
        }
    }
    
    func changeState(newState: State) -> Void {
        previousState = currentState
        currentState?.exit(owner)
        currentState = newState
        currentState?.enter(owner)
    }
    
    func revertToPreviousState() -> Void {
        changeState(previousState!)
    }
    
    func handleMessage(message: Telegram) -> Bool {
        if (currentState != nil && currentState!.onMessage(owner, telegram: message)) {
            return true
        }
        
        if (globalState != nil && globalState!.onMessage(owner, telegram: message)) {
            return true
        }
        
        return false
    }
    
    func isInState(state: State) -> Bool {
        return (currentState != nil && currentState!.isKindOfClass(state.classForCoder))
    }
    
    func isUsingState(state: State) -> Bool {
        return (currentState != nil && currentState == state)
    }
    
    func nameOfCurrentState() -> String? {
        if (currentState != nil) {
            return NSStringFromClass(currentState!.classForCoder)
        } else {
            return nil
        }
    }
}