//
//  MovieViewController.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
  
  var movie: Movie?
  var movieViewModel: MovieViewModel?
  
  @IBOutlet weak var backdropImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var voteAverageLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = movieViewModel?.titleString
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
