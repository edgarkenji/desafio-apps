//
//  ArticleCellTableViewCell.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 05/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit

class ArticleCellTableViewCell: UITableViewCell {
  
  @IBOutlet weak var articleView: ArticleView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
