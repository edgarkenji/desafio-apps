//
//  Contents.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import Unbox

struct Contents {
  var articles:[Article]
  var product:String
  
  init(articles:[Article], product:String) {
    self.articles = articles
    self.product = product
  }
}

extension Contents: Unboxable {
  init(unboxer: Unboxer) throws {
    self.articles = try unboxer.unbox(key: "conteudos")
    self.product = try unboxer.unbox(key: "produto")
  }
}
