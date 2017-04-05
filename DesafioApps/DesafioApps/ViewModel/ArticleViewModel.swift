//
//  ArticleViewModel.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 05/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation

class ArticleViewModel {
  
  public private(set) var article:Article
  
  init(article:Article) {
    self.article = article
  }
  
  var imageURL:URL? {
    return article.images.first?.url
  }
  
  var section:String {
    return article.section.name
  }
  
  var sectionURL:URL {
    return self.article.section.url
  }
  
  var title:String {
    return article.title
  }
}
