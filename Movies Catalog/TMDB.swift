//
//  TMDB.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import Foundation

struct TMDB {
  
  // MARK: - Base URL and Keys
  
  static let apiKey = "92902f3b6e447dc1b5ae67621de4db57"
  static let baseURL = "https://api.themoviedb.org/3"
  
  // MARK: - Endpoints
  
  static let discoverMovie = "discover/movie"
  
  // MARK: - Images
  
  static let imageURL = "https://image.tmdb.org/t/p/w500"
}
