//
//  LoadingView.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 07/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NibDesignable

@IBDesignable
public class LoadingView: NibDesignable {
  
  @IBOutlet var messageLabel:UILabel!
  @IBOutlet var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var reloadButton: UIButton!
  
  override public func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func updateUI(isHidden:Bool,
                showLoading:Bool,
                showRefreshing:Bool,
                message:String) {
    
    if isHidden {
      self.superview?.sendSubview(toBack: self)
      self.isHidden = true
    } else {
      self.superview?.bringSubview(toFront: self)
      self.isHidden = false
    }
    
    if showLoading {
      self.loadingView.startAnimating()
      self.loadingView.isHidden = false
    } else {
      self.loadingView.stopAnimating()
      self.loadingView.isHidden = true
    }
    
    self.reloadButton.isHidden = !showRefreshing
    self.messageLabel.text = message    

  }
  
  var reloadButtonTapped:Driver<Void> {
    return reloadButton.rx.tap.asDriver()
  }
  
}
