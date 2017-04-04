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

class GloboService {
  public private (set) var provider:RxMoyaProvider<GloboAPI>
  
  init(provider:RxMoyaProvider<GloboAPI>) {
    self.provider = provider
  }
  
  convenience init() {
    self.init(provider:RxMoyaProvider<GloboAPI>())
  }

}
