//
//  ArticleImageView.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 06/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit
import NibDesignable

@IBDesignable
class ArticleImageView : NibDesignable {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var captionLabel: InsetLabel!
  
}
