//
//  GloboService.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Unbox

class GloboService {
  
  enum ServiceError: Swift.Error {
    case invalidResponse
    case emptyContents
    case noCover
    case noArticles
  }
  
  public private (set) var provider:RxMoyaProvider<GloboAPI>
  
  init(provider:RxMoyaProvider<GloboAPI>) {
    self.provider = provider
  }
  
  convenience init() {
    self.init(provider:RxMoyaProvider<GloboAPI>())
  }

  var contents:Observable<Contents> {
    return provider.request(.cover)
      .single()
      .map({ (response) -> Contents in
        let contents:[Contents] = try unbox(data:response.data)
        guard let first = contents.first else {
          throw ServiceError.emptyContents
        }
        return first
      })
  }  
}
