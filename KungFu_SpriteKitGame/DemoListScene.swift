//
//  DemoListScene.swift
//  KungFu_SpriteKitGame
//
//  Created by ChildhoodAndy on 15/3/11.
//  Copyright (c) 2015年 ChildhoodAndy. All rights reserved.
//

import UIKit
import SpriteKit

class DemoListScene: SKScene, UITableViewDataSource, UITableViewDelegate {
    let demos = ["GameScene/swift" : GameScene.self,
        "TurtlesTestScene/swift" : TurtlesTestScene.self,
        "SKSTestScene/sks" : SKSTestScene.self,
        "InverseKinematicsTestScene/sks" : InverseKinematicsTestScene.self,
        "PhysicsFieldTestScene/sks" : PhysicsFieldTestScene.self,
        "PhysicsMagneticFieldTestScene/swift" : PhysicsMagneticFieldTestScene.self]
    let cellReuseID = "demoCell"
    let BACK_BUTTON_TAG = 100
    
    override func didMoveToView(view: SKView) {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        self.view?.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.removeFromSuperview()
        let transition = SKTransition.crossFadeWithDuration(1.0)
        let text = demos.keys.array[indexPath.row] as String

        let array = text.pathComponents
        let SceneCls = demos.values.array[indexPath.row] as SKScene.Type
        var scene: SKScene!
        if array[1] == "sks" {
            scene = SceneCls.unarchiveFromFile(array[0])
            scene.scaleMode = .AspectFill
        } else {
            scene = SceneCls(size: self.size)
        }
        self.view?.presentScene(scene, transition: transition)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = demos.keys.array[indexPath.row]
        
        return cell
    }
}