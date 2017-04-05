//
//  HomeViewModel.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 05/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
  
  var service:GloboService
  
  init(service:GloboService) {
    self.service = service
  }
  
  convenience init() {
    self.init(service: GloboService())
  }
  
  var cover:Observable<Article> {
    return service.contents
      .map({ (contents) -> Article in
        guard let article = contents.articles.first else {
          throw GloboService.ServiceError.noCover
        }
        return article
      })
  }
  
  var articles:Observable<[Article]> {
    return service.contents
      .map({ (contents) -> [Article] in
        guard contents.articles.count > 1 else {
          throw GloboService.ServiceError.noArticles
        }
        var articles = contents.articles
        _ = articles.removeFirst()
        return articles
      })
  }
}
