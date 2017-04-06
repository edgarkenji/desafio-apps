//
//  AppColors.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 06/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit

enum AppColors {
  case highlight
  
  var color:UIColor {
    switch self {
    case .highlight: return UIColor(hex6:0x1294C7)
    }
  }
}
