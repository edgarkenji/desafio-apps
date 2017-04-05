//
//  MockData.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 05/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import Moya
@testable import DesafioApps

class MockData {
  var data:Data? {
    guard let path = Bundle(for: type(of: self)).path(forResource: "capa", ofType: "json") else {
      return nil
    }
    
    do {
      let url = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: url)
      return data
    } catch _ {
      return nil
    }
  }
  
  var provider:RxMoyaProvider<GloboAPI> {
    let endpoint = { (target:GloboAPI) -> Endpoint<GloboAPI> in
      let url = target.baseURL.appendingPathComponent(target.path).absoluteString
      return Endpoint<GloboAPI>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
    
    let provider = RxMoyaProvider(endpointClosure: endpoint, stubClosure: MoyaProvider.immediatelyStub)
    return provider
  }
}
