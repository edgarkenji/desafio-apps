//
//  ArticleTableViewController.swift
//  DesafioApps
//
//  Created by Edgar Kenji Yamamoto on 06/04/17.
//  Copyright © 2017 ikusagami. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewController: UITableViewController {
  
  enum Section: Int {
    case header
    case image
    case text
  }
  
  var article:Article!
  var viewModel:ArticleViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 94
    
    viewModel = ArticleViewModel(article: article)
    navigationItem.title = viewModel.section
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case Section.header.rawValue:
      let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleHeaderCell", for: indexPath) as! ArticleHeaderTableViewCell
      cell.headerView.author = viewModel.author
      cell.headerView.publishedDate = viewModel.publishedDate
      cell.headerView.titleLabel.text = viewModel.title
      cell.headerView.subTitleLabel.text = viewModel.subTitle
      return cell
    case Section.image.rawValue:
      let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleImageCell", for: indexPath) as! ArticleImageTableViewCell
      cell.articleImageView.captionLabel.text = viewModel.imageCaption
      cell.articleImageView.imageView.kf.setImage(with: viewModel.imageURL)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTextCell", for: indexPath) as! ArticleTextTableViewCell
      cell.textView.text = viewModel.text
      cell.textView.sizeToFit()
      cell.textView.layoutIfNeeded()
      return cell
    }
   }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
