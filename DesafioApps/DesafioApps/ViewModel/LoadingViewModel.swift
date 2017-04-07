//
//  LoadingViewModel.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 07/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoadingViewModel : LoadingViewProtocol {
  internal var disposeBag = DisposeBag()
  internal var state:Variable<LoadingState> = Variable(.loading)
  internal var messages:[LoadingState:String] = [:]

  init() {
    messages = [
      .loading: "Carregando, aguarde...",
      .loaded: "",
      .empty: "Nenhum resultado encontrado",
      .error: "Ocorreu um erro, por favor tente novamente mais tarde"
    ]
  }
  
  var isHidden:Bool {
    return state.value == .loaded
  }
  
  var isLoading:Bool {
    return state.value == .loading
  }
  
  var showRefreshing:Bool {
    return state.value == .error || state.value == .empty
  }
  
  var message:String {
    return messages[state.value]!
  }
}
