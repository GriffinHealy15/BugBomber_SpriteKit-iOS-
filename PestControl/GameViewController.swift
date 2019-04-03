//
//  GameViewController.swift
//  PestControl
//
//  Created by Griffin Healy on 7/30/18.
//  Copyright © 2018 Griffin Healy. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      if let scene = GameScene.loadGame()
        ?? SKScene(fileNamed: "Level1") as? GameScene {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        // Present the scene
        view.presentScene(scene)
      }
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
      view.showsPhysics = true
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
