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
    let demos: [String] = ["demo1",
                           "demo2",
                           "demo3"]
    let cellReuseID = "demoCell"
    
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
        
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseID, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = demos[indexPath.row]
        
        return cell
    }
}