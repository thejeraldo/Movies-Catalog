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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let _ = self.movie {
      title = self.movie?.title
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
