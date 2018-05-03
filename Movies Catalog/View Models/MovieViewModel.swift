//
//  MovieViewModel.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/3/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
  var movie: Movie
  var titleString: String
  var overViewString: String?
  var posterURL: URL?
  var backdropURL: URL?
  var voteAverageString: String?
  var releaseDateString: String?
  
  lazy var numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    return nf
  }()
  
  lazy var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MMM dd, yyyy"
    return df
  }()
  
  init(movie: Movie) {
    self.movie = movie
    self.titleString = movie.title
    self.overViewString = movie.overview
    if let posterURL = URL(string: TMDB.imageURL)?.appendingPathComponent(movie.posterPath!) {
      self.posterURL = posterURL
    }
    if let backdropURL = URL(string: TMDB.backdropURL)?.appendingPathComponent(movie.backdropPath!) {
      self.backdropURL = backdropURL
    }
    if let voteAverage = movie.voteAverage {
      let number = NSNumber(value: voteAverage)
      let numberString = self.numberFormatter.string(from: number)
      self.voteAverageString = "\(numberString ?? "0") / 10"
    }
    if let releaseDate = movie.releaseDate {
      let df = DateFormatter()
      df.dateFormat = "yyyy-MM-dd"
      if let date = df.date(from: releaseDate) {
        self.releaseDateString = "Release Date: \(self.dateFormatter.string(from: date))"
      }
    } else {
      self.releaseDateString = "TBA"
    }
  }
}
