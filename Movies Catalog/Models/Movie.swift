//
//  Movie.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import Foundation

// MARK: - Movie

class Movie: Codable, Equatable {
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
  
  static func == (lhs: Movie, rhs: Movie) -> Bool {
    return lhs.movieID == rhs.movieID
  }
}

// MARK: - Movie List

class MovieList: Codable, Equatable {
  var listType: MovieListType?
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
  
  static func == (lhs: MovieList, rhs: MovieList) -> Bool {
    return
      lhs.listType == rhs.listType &&
      lhs.page == rhs.page &&
      lhs.totalPages == rhs.totalPages &&
      lhs.totalResults == rhs.totalResults
  }
}

// MARK: - Enums

enum MovieListType {
  case mostPopular
  case topRated
  case highestGrossing
  case topComedy
  case topHorror
  case topRomance
  
  func title() -> String {
    switch self {
    case .mostPopular:
      return "Most Popular"
    case .topRated:
      return "Top Rated"
    case .highestGrossing:
      return "Highest Grossing"
    case .topComedy:
      return "Top Comedy"
    case .topHorror:
      return "Top Horror"
    case .topRomance:
      return "Top Romance"
    }
  }
  
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
    case .topComedy:
      params["with_genres"] = "35"
      params["sort_by"] = "vote_count.desc"
    case .topHorror:
      params["with_genres"] = "27"
      params["sort_by"] = "vote_count.desc"
    case .topRomance:
      params["with_genres"] = "10749"
      params["sort_by"] = "vote_count.desc"
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
        let movieList = movieList
        movieList.listType = listType
        success(movieList)
      }, failure: { (error) in
        failure(error)
      })
    }
  }
}
