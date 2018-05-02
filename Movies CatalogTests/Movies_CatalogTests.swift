//
//  Movies_CatalogTests.swift
//  Movies CatalogTests
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import XCTest
import Alamofire

@testable import Movies_Catalog

class Movies_CatalogTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testMostPopular() {
    let exp = XCTestExpectation(description: "MostPopular")
    Movie.getMovieList(.topRated, page: 1, success: { (movieList) in
      if let movies = movieList?.movies {
        print(movies)
      }
      exp.fulfill()
      XCTAssert(movieList?.movies != nil, "Movies must not be empty.")
    }) { (error) in
      print(error)
      exp.fulfill()
      XCTFail(error.localizedDescription)
    }
    wait(for: [ exp ], timeout: 10)
  }
}
