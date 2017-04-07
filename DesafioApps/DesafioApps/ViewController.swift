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
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingView: LoadingView!
  
  enum Section: Int {
    case cover
    case articles
  }
  
  struct ArticleSection: SectionModelType {
    typealias Item = Article
    var items:[Item]
    
    init(items:[ArticleSection.Item]) {
      self.items = items
    }
    
    init(original: ArticleSection, items: [ArticleSection.Item]) {
      self = original
      self.items = items
    }
  }
  
  var homeViewModel:HomeViewModel!
  var loadingViewModel:LoadingViewModel!
  
  let disposeBag = DisposeBag()
  
  var dataSource:RxTableViewSectionedReloadDataSource<ArticleSection>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if homeViewModel == nil {
      homeViewModel = HomeViewModel()
    }
    if loadingViewModel == nil {
      loadingViewModel = LoadingViewModel()
    }
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 94
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    loadingViewModel.state
      .asDriver()
      .drive(onNext: { (loadingState) in
        self.updateLoading(loadingState: loadingState)
      })
      .addDisposableTo(disposeBag)

    dataSource = RxTableViewSectionedReloadDataSource<ArticleSection>()
    dataSource.configureCell = { (dataSource, tableView, indexPath, item) in
      if indexPath.section == Section.cover.rawValue {
        return self.configureCoverCell(tableView: tableView, indexPath: indexPath, article: item)
      } else {
        return self.configureArticleCell(tableView: tableView, indexPath: indexPath, article: item)
      }
    }
    
    self.loadingView.reloadButtonTapped
      .drive(onNext: { _ in
        self.requestArticles()
      })
      .addDisposableTo(disposeBag)
    
    self.requestArticles()
    
    tableView.rx.modelSelected(Article.self).asDriver()
      .drive(onNext: { (article) in
        self.performSegue(withIdentifier: "showArticle", sender: article)
      })
      .addDisposableTo(disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func requestArticles() {
    Observable.combineLatest(homeViewModel.cover, homeViewModel.articles) { (cover, articles) -> [ArticleSection] in
      return [
        ArticleSection(items:[cover]),
        ArticleSection(items:articles)
      ]
      }
      .do(onNext: { sections in
        if sections[Section.cover.rawValue].items.isEmpty && sections[Section.articles.rawValue].items.isEmpty {
          self.loadingViewModel.setState(.empty)
        } else {
          self.loadingViewModel.setState(.loaded)
        }
      }, onError: { _ in
        self.loadingViewModel.setState(.error)
      })
      .bindTo(tableView.rx.items(dataSource: dataSource))
      .addDisposableTo(disposeBag)
  }

  func configureCoverCell(tableView:UITableView, indexPath:IndexPath, article:Article) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoverArticleCell", for: indexPath) as! CoverArticleTableViewCell
    self.updateCover(cover: article, view: cell.coverArticleView)
    return cell
  }

  func configureArticleCell(tableView:UITableView, indexPath:IndexPath, article:Article) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
    self.updateArticle(article: article, view: cell.articleView)
    return cell
  }
  
  func updateCover(cover:Article, view:CoverArticleView) {
    let viewModel = ArticleViewModel(article: cover)
    view.imageView.kf.indicatorType = .activity
    view.imageView.kf.setImage(with: viewModel.imageURL)
    view.sectionLabel.text = viewModel.section
    view.titleLabel.text = viewModel.title
  }
  
  func updateArticle(article:Article, view:ArticleView) {
    let viewModel = ArticleViewModel(article: article)
    if let imageURL = viewModel.imageURL {
      view.imageView.kf.setImage(with: imageURL)
    }
    view.sectionLabel.text = viewModel.section
    view.titleLabel.text = viewModel.title
  }
  
  func updateLoading(loadingState:LoadingState) {
    loadingView.updateUI(isHidden: loadingViewModel.isHidden,
                         showLoading: loadingViewModel.isLoading,
                         showRefreshing: loadingViewModel.showRefreshing,
                         message: loadingViewModel.message)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }
    
    switch identifier {
    case "showArticle":
      if let vc = segue.destination as? ArticleTableViewController, let article = sender as? Article {
        vc.article = article
      }
    default: break
    }
  }
}

