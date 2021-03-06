//
//  GloboAPI.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import Moya

enum GloboAPI {
  case cover
}

extension GloboAPI: TargetType {
  var baseURL: URL { return URL(string: "https://raw.githubusercontent.com/Infoglobo/desafio-apps/master")! }
  var path: String {
    switch self {
    case .cover:
      return "/capa.json"
    }
  }
  var method: Moya.Method {
    switch self {
    default:
      return .get
    }
  }
  var parameters: [String: Any]? {
    switch self {
    default:
      return nil
    }
  }
  
  var parameterEncoding: ParameterEncoding {
    switch self {
    default:
      return URLEncoding.default // Send parameters in URL
    }
  }
  
  var sampleData: Data {
    switch self {
    case .cover:
      let path = Bundle(for: type(of:GloboService())).path(forResource: "capa", ofType: "json")
      let url = URL(fileURLWithPath: path!)
      return try! Data(contentsOf: url)
    }
  }
  var task: Task {
    switch self {
    default:
      return .request
    }
  }
}
