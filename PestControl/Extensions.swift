//
//  Extensions.swift
//  PestControl
//
//  Created by Griffin Healy on 8/1/18.
//  Copyright © 2018 Griffin Healy. All rights reserved.
//

import SpriteKit
extension SKTexture {
  convenience init(pixelImageNamed: String) {
    self.init(imageNamed: pixelImageNamed)
    self.filteringMode = .nearest
  }
}
