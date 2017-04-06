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
    return article.section.name.localizedUppercase
  }
  
  var sectionURL:URL {
    return self.article.section.url
  }
  
  var title:String {
    return article.title
  }
  
  var subTitle:String? {
    return article.subTitle
  }
  
  var text:String? {
    return article.text
  }
  
  var imageCaption:String? {
    guard let caption = article.images.first?.caption else {
      return nil
    }
    
    let trimmed = caption.trimmingCharacters(in: CharacterSet.newlines)
    
    guard let source = article.images.first?.source else {
      return trimmed
    }
    
    return "\(trimmed). Fonte: \(source)"
  }
  
  var author:String? {
    return article.authors?.first?.localizedUppercase
  }
  
  var publishedDate:String {
    return DateUtils.readableDate(date: article.published)
  }
}
