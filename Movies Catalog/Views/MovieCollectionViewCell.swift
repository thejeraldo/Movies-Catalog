//
//  MovieCollectionViewCell.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {
  
  private var movie: Movie?
  @IBOutlet weak var posterImageView: UIImageView!
  
  func setupWithMovie(_ movie: Movie) {
    self.movie = movie
    if let posterURL = URL(string: TMDB.imageURL)?.appendingPathComponent(movie.posterPath!) {
      posterImageView.af_setImage(withURL: posterURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
  }
}
