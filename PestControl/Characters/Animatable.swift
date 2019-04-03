//
//  Animatable.swift
//  PestControl
//
//  Created by Griffin Healy on 7/30/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import Foundation
import SpriteKit

protocol Animatable: class {
  var animations: [SKAction] { get set }
  
}

extension Animatable {
  func animationDirection(for directionVector: CGVector)
    -> Direction {
      let direction: Direction
      if abs(directionVector.dy) > abs(directionVector.dx) {
        direction = directionVector.dy < 0 ? .forward : .backward // returns direction
        // rawValue gives 0 : 1 & 2 : 3
      } else {
        direction = directionVector.dx < 0 ? .left : .right
      }
      return direction
  }
  func createAnimations(character: String) {
    let actionForward: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_ft1"),
      SKTexture(pixelImageNamed: "\(character)_ft2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionForward))
    let actionBackward: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_bk1"),
      SKTexture(pixelImageNamed: "\(character)_bk2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionBackward))
    let actionLeft: SKAction = SKAction.animate(with: [
      SKTexture(pixelImageNamed: "\(character)_lt1"),
      SKTexture(pixelImageNamed: "\(character)_lt2")
      ], timePerFrame: 0.2)
    animations.append(SKAction.repeatForever(actionLeft))
    animations.append(SKAction.repeatForever(actionLeft))
  }
}
