//
//  Player.swift
//  PestControl
//
//  Created by Griffin Healy on 7/30/18.
//  Copyright © 2018 Griffin Healy. All rights reserved.
//

import SpriteKit

enum PlayerSettings {
  static let playerSpeed: CGFloat = 280.0
}

extension Player : Animatable {
}

class Player: SKSpriteNode {
  
  var animations: [SKAction] = []
  var hasBugspray: Bool = false {
    didSet {
      blink(color: .green, on: hasBugspray)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    animations = aDecoder.decodeObject(
      forKey: "Player.animations") as! [SKAction]
    hasBugspray = aDecoder.decodeBool(
      forKey: "Player.hasBugspray")
    
    if hasBugspray {
      removeAction(forKey: "blink")
      blink(color: .green, on: hasBugspray)
    }
  }
  init() {
    let texture = SKTexture(pixelImageNamed: "player_ft1")
    super.init(texture: texture, color: .white,
               size: texture.size())
    name = "Player"
    zPosition = 50
    physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
    physicsBody?.categoryBitMask = PhysicsCategory.Player
    physicsBody?.contactTestBitMask = PhysicsCategory.All
    physicsBody?.restitution = 1.0
    physicsBody?.linearDamping = 0.5
    physicsBody?.friction = 0
    physicsBody?.allowsRotation = false
    
    createAnimations(character: "player")
  }
  
  override func encode(with aCoder: NSCoder) {
    aCoder.encode(hasBugspray, forKey: "Player.hasBugspray")
    aCoder.encode(animations, forKey: "Player.animations")
    super.encode(with: aCoder)
  }
  
  func move(target: CGPoint) {
    guard let physicsBody = physicsBody else { return }
    let newVelocity = (target - position).normalized()
      * PlayerSettings.playerSpeed
    physicsBody.velocity = CGVector(point: newVelocity)
    //print("* \(animationDirection(for: physicsBody.velocity))")
    checkDirection()
  }
  
  func checkDirection() {
    guard let physicsBody = physicsBody else { return }
    // 1
    let direction =
      animationDirection(for: physicsBody.velocity)
    // 2
    if direction == .left {
      xScale = abs(xScale)
    }
    if direction == .right {
      xScale = -abs(xScale)
    }
    //print("direction: \(direction)")
    // 3
    run(animations[direction.rawValue], withKey: "animation")
  }
  
  func blink(color: SKColor, on: Bool) {
    // 1
    let blinkOff = SKAction.colorize(withColorBlendFactor: 0.0,
      duration: 0.2)
       // 2
      if on {
      let blinkOn = SKAction.colorize(with: color,
      colorBlendFactor: 1.0,
      duration: 0.2)
      let blink = SKAction.repeatForever(SKAction.sequence(
      [blinkOn, blinkOff]))
      xScale = xScale < 0 ? -1.5 : 1.5
      yScale = 1.5
      run(blink, withKey: "blink")
      } else { // 3
      xScale = xScale < 0 ? -1.0 : 1.0
      yScale = 1.0
      removeAction(forKey: "blink")
      run(blinkOff)
    }
  }
}
