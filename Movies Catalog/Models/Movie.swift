//
//  Movie.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import Foundation

class Movie: Codable {
  var movieID: Int
  var title: String
  var posterPath: String?
  var backdropPath: String?
  var overview: String
  var voteAverage: Float?
  var releaseDate: String?
  
  init(movieID: Int, title: String, overview: String) {
    self.movieID = movieID
    self.title = title
    self.overview = overview
  }
  
  enum CodingKeys: String, CodingKey {
    case movieID = "id"
    case title = "title"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case overview = "overview"
    case voteAverage = "vote_average"
    case releaseDate = "release_date"
  }
}

struct MovieList: Codable {
  var page: Int
  var totalResults: Int
  var totalPages: Int
  var movies: [Movie]?
  
  enum CodingKeys: String, CodingKey {
    case page = "page"
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}

// MARK: - Enums

enum MovieListType {
  case mostPopular
  case topRated
  case highestGrossing
  
  func paramsForList(page: Int = 1) -> [String: Any] {
    var params = [
      "api_key": TMDB.apiKey,
      "page": "\(page)"
    ]
    switch self {
    case .mostPopular:
      params["sort_by"] = "popularity.desc"
    case .topRated:
      params["sort_by"] = "vote_count.desc"
    case .highestGrossing:
      params["sort_by"] = "revenue.desc"
    }
    return params
  }
}

// MARK: - Data Requests

extension Movie {
  typealias successHandler = (_ movieList: MovieList?) -> Void
  typealias failureHandler = (_ error: Error) -> Void
  
  class func getMovieList(_ listType: MovieListType, page: Int, success: @escaping successHandler, failure: @escaping failureHandler) {
    if let url = URL(string: TMDB.baseURL)?.appendingPathComponent(TMDB.discoverMovie) {
      let params = listType.paramsForList(page: page)
      Client.request(url: url, method: .get, params: params, responseType: MovieList.self, success: { (movieList) in
        success(movieList)
      }, failure: { (error) in
        failure(error)
      })
    }
  }
}
