//
//  Firebug.swift
//  PestControl
//
//  Created by Griffin Healy on 8/2/18.
//  Copyright © 2018 Griffin Healy. All rights reserved.
//

import SpriteKit
class Firebug: Bug {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  override init() {
    super.init()
    name = "Firebug"
    color = .red
    colorBlendFactor = 0.8
    physicsBody?.categoryBitMask = PhysicsCategory.Firebug
  } }
