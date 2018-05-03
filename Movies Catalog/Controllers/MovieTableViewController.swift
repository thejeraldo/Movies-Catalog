//
//  MovieTableViewController.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/3/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewController: UITableViewController {
  
  var movieViewModel: MovieViewModel?
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var voteAverageLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView()
    
    title = movieViewModel?.titleString
    
    customizeViews()
    
    tableView.rowHeight = self.tableView.frame.width / (16/9)
    tableView.estimatedRowHeight = self.tableView.frame.width / (16/9)
    
    if let movieViewModel = self.movieViewModel {
      self.titleLabel.text = movieViewModel.titleString
      self.releaseDateLabel.text = movieViewModel.releaseDateString
      self.voteAverageLabel.text = movieViewModel.voteAverageString
      if let backdropURL = movieViewModel.backdropURL {
        self.backdropImageView.af_setImage(withURL: backdropURL)
      }
      if let posterURL = movieViewModel.posterURL {
        self.posterImageView.af_setImage(withURL: posterURL, placeholderImage: #imageLiteral(resourceName: "placeholder")) { (image) in
          // self.tableView.reloadData()
        }
      }
      self.overviewLabel.text = movieViewModel.overViewString
    }
  }
  
  func customizeViews() {
    self.posterImageView.layer.borderColor = UIColor.lightGray.cgColor
    self.posterImageView.layer.borderWidth = 1
    applyShadowToLabel(self.titleLabel)
    applyShadowToLabel(self.releaseDateLabel)
    applyShadowToLabel(self.voteAverageLabel)
  }
  
  func applyShadowToLabel(_ label: UILabel) {
    label.layer.shadowColor = UIColor.black.cgColor
    label.layer.shadowRadius = 3.0
    label.layer.shadowOpacity = 1.0
    label.layer.shadowOffset = CGSize(width: 0, height: 0)
    label.layer.masksToBounds = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if self.movieViewModel != nil {
      return 1
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.movieViewModel != nil {
      return 2
    }
    return 0
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      let height = self.tableView.frame.width / (16/9)
      if height <= 220 { return height } else { return 220 }
    }
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
