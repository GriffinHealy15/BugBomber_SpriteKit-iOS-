//
//  Bug.swift
//  PestControl
//
//  Created by Griffin Healy on 8/1/18.
//  Copyright © 2018 Griffin Healy. All rights reserved.
//

import SpriteKit

enum BugSettings {
  static let bugDistance: CGFloat = 16
}

class Bug: SKSpriteNode {
  
  var animations: [SKAction] = []
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    animations = aDecoder.decodeObject(forKey: "Bug.animations")
      as! [SKAction]
  }
  
  init() {
    let texture = SKTexture(pixelImageNamed: "bug_ft1")
    super.init(texture: texture, color: .white,
               size: texture.size())
    name = "Bug"
    zPosition = 50
    physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
    physicsBody?.categoryBitMask = PhysicsCategory.Bug
    physicsBody?.restitution = 0.5
    physicsBody?.allowsRotation = false
    createAnimations(character: "bug")
  }
  
  override func encode(with aCoder: NSCoder) {
    aCoder.encode(animations, forKey: "Bug.animations")
    super.encode(with: aCoder)
  }
  
  @objc func moveBug() {
    // 1
    let randomX = CGFloat(Int.random(min: -1, max: 1))
    let randomY = CGFloat(Int.random(min: -1, max: 1))
    let vector = CGVector(dx: randomX * BugSettings.bugDistance,
                          // 2
      dy: randomY * BugSettings.bugDistance)
    let moveBy = SKAction.move(by: vector, duration: 1)
    let moveAgain = SKAction.perform(#selector(moveBug),
                                     onTarget: self)
    // 1
    let direction = animationDirection(for: vector)
    // 2
    if direction == .left {
      xScale = abs(xScale)
    } else if direction == .right {
      xScale = -abs(xScale)
    }
    // 3
    run(animations[direction.rawValue], withKey: "animation")
    run(SKAction.sequence([moveBy, moveAgain]))
  }
  
  func die() {
    // 1
    removeAllActions()
    texture = SKTexture(pixelImageNamed: "bug_lt1")
    yScale = -1
    // 2
    physicsBody = nil
    // 3
    run(SKAction.sequence([SKAction.fadeOut(withDuration: 3),
    SKAction.removeFromParent()]))
  }
  
}

extension Bug : Animatable {}
