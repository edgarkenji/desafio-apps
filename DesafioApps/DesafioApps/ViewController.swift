//
//  ViewController.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 04/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxDataSources

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var coverArticleView: CoverArticleView!
  
  var homeViewModel:HomeViewModel!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if homeViewModel == nil {
      homeViewModel = HomeViewModel()
    }
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 94
    
    homeViewModel.cover
      .observeOn(MainScheduler.instance)
      .subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "background"))
      .subscribe(onNext: { [unowned self] article in
        self.updateCover(cover: article)
      })
      .addDisposableTo(disposeBag)
    
    homeViewModel.articles
      .bindTo(tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCellTableViewCell.self)) { [unowned self] index, model, cell in
        self.updateArticle(article: model, view: cell.articleView)
      }
      .addDisposableTo(disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  func updateCover(cover:Article) {
    let viewModel = ArticleViewModel(article: cover)
    coverArticleView.imageView.kf.indicatorType = .activity
    coverArticleView.imageView.kf.setImage(with: viewModel.imageURL)
    coverArticleView.sectionLabel.text = viewModel.section
    coverArticleView.titleLabel.text = viewModel.title
  }
  
  func updateArticle(article:Article, view:ArticleView) {
    let viewModel = ArticleViewModel(article: article)
    if let imageURL = viewModel.imageURL {
      view.imageView.kf.setImage(with: imageURL)
    }
    view.sectionLabel.text = viewModel.section
    view.titleLabel.text = viewModel.title
  }
}

