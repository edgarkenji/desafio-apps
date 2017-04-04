//
//  Article.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import Unbox

struct Article {
  
  struct ArticleSection {
    var name:String
    var url:URL
  }
  
  enum ArticleType: String {
    case materia
    case linkExterno
  }

  struct ArticleImage {
    var author:String // autor
    var source:String // fonte
    var caption:String // legenda
    var url:URL
  }
  
  var id:Int64
  var authors:[String]? // autores
  var isAdvertisement:Bool? // informePublicitario
  var subTitle:String? // subTitulo
  var text:String? // texto
  var videos:[String]?
  var lastUpdated:Date // atualizadoEm
  var published:Date // publicadoEm
  
  var section:ArticleSection // secao
  var type:ArticleType // tipo
  var title:String // titulo
  var url:URL
  var originalURL:URL // urlOriginal
  var images:[ArticleImage] // imagens
}

extension Article : Unboxable {
  init(unboxer: Unboxer) throws {
    self.id = try unboxer.unbox(key: "id")
    self.authors = unboxer.unbox(key: "autores")
    self.isAdvertisement = unboxer.unbox(key: "informePublicitario")
    self.subTitle = unboxer.unbox(key: "subTitulo")
    self.text = unboxer.unbox(key: "texto")
    self.videos = unboxer.unbox(key: "videos")
    self.lastUpdated = try unboxer.unbox(key: "atualizadoEm", formatter: DateUtils.ISO8601Formatter)
    self.published = try unboxer.unbox(key: "publicadoEm", formatter: DateUtils.ISO8601Formatter)
    self.section = try unboxer.unbox(key: "secao")
    self.type = try unboxer.unbox(key: "tipo")
    self.title = try unboxer.unbox(key: "titulo")
    self.url = try unboxer.unbox(key: "url")
    self.originalURL = try unboxer.unbox(key: "urlOriginal")
    self.images = try unboxer.unbox(key: "imagens")
  }
}

extension Article.ArticleSection : Unboxable {
  init(unboxer: Unboxer) throws {
    self.name = try unboxer.unbox(key: "nome")
    self.url = try unboxer.unbox(key: "url")
  }
}

extension Article.ArticleType: UnboxableEnum {
}

extension Article.ArticleImage : Unboxable {
  init(unboxer: Unboxer) throws {
    self.author = try unboxer.unbox(key: "autor")
    self.source = try unboxer.unbox(key: "fonte")
    self.caption = try unboxer.unbox(key: "legenda")
    self.url = try unboxer.unbox(key: "url")
  }
}
