//
//  ArticleHeaderView.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 06/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit
import NibDesignable

@IBDesignable
class ArticleHeaderView : NibDesignable {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var publishedDateLabel: UILabel!
  
  var author:String? {
    didSet {
      if let author = author {
        let prefix = "Por: ".localizedUppercase
        let attributedAuthor = NSAttributedString(string: author, attributes: [NSForegroundColorAttributeName: AppColors.highlight.color])
        let formatted = NSMutableAttributedString(string: prefix)
        formatted.append(attributedAuthor)
        authorLabel?.attributedText = formatted
      }
    }
  }
  
  var publishedDate:String? {
    didSet {
      if let publishedDate = publishedDate {
        let formatted = "🕘 \(publishedDate)"
        publishedDateLabel.text = formatted
      }
    }
  }
}

