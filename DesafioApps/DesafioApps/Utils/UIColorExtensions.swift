//
//  UIColorExtensions.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 06/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit

extension UIColor {
  public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
    let divisor = CGFloat(15)
    let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
    let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
    let blue    = CGFloat( hex3 & 0x00F      ) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
  public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
    let divisor = CGFloat(255)
    let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
    let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
    let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

