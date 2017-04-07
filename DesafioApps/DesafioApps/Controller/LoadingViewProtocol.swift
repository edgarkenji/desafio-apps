//
//  LoadingViewProtocol.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 07/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoadingViewProtocol {
  var state:Variable<LoadingState> { get set }
  
  var disposeBag:DisposeBag { get }
  
  func setState(_ state:LoadingState)
}

extension LoadingViewProtocol {
  func setState(_ state:LoadingState) {
    self.state.value = state
  }
}
