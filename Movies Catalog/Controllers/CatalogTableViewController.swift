//
//  CatalogTableViewController.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit
import SVProgressHUD

class CatalogTableViewController: UITableViewController, CategoryTableViewCellDelegate {
  
  var movies = [MovieList]()
  
  // MARK: - View Controller Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Catalog"
    
    setupSplitViewController()
    setupTableView()
    loadInitialMovieList()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Setup UI
  
  func setupSplitViewController() {
    self.splitViewController?.delegate = self
    self.splitViewController?.preferredDisplayMode = .allVisible
  }
  
  func setupTableView() {
    tableView.tableFooterView = UIView()
  }
  
  // MARK: - Load Data
  
  func loadMovies(_ listType: MovieListType, page: Int, success: @escaping (MovieList?) -> (), failure: @escaping (Error) -> ()) {
    Movie.getMovieList(listType, page: page, success: success, failure: failure)
  }
  
  func loadInitialMovieList() {
    loadMovies(.mostPopular, page: 1, success: { [weak self] (mostPopularMovies) in
      if let _ = mostPopularMovies {
        self?.movies.append(mostPopularMovies!)
        let index = self?.movies.index(of: mostPopularMovies!)
        self?.tableView.insertSections(IndexSet(index!...index!), with: .fade)
        
        self?.loadMovies(.topRated, page: 1, success: { (topRatedMovies) in
          if let _ = topRatedMovies {
            self?.movies.append(topRatedMovies!)
            let index = self?.movies.index(of: topRatedMovies!)
            self?.tableView.insertSections(IndexSet(index!...index!), with: .fade)
            
            self?.loadMovies(.highestGrossing, page: 1, success: { (highestGrossingMovies) in
              if let _ = highestGrossingMovies {
                self?.movies.append(highestGrossingMovies!)
                let index = self?.movies.index(of: highestGrossingMovies!)
                self?.tableView.insertSections(IndexSet(index!...index!), with: .fade)
              }
              
            }, failure: { (error) in
              SVProgressHUD.showError(withStatus: "Something went wrong.")
            })
          }
        }, failure: { (error) in
          SVProgressHUD.showError(withStatus: "Something went wrong.")
        })
      }
    }, failure: { (error) in
      SVProgressHUD.showError(withStatus: "Something went wrong.")
    })
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return self.movies.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let movieList = self.movies[section]
    return movieList.listType?.title()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
    let movieList = self.movies[indexPath.section]
    cell.movieList = movieList
    if cell.delegate == nil {
      cell.delegate = self
    }
    return cell
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc: MovieViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
    
    let nav = UINavigationController(rootViewController: vc)
    self.splitViewController?.showDetailViewController(nav, sender: self)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 166
  }
  
  // MARK: -
  
  func didSelectMovie(movie: Movie) {
    let vc: MovieTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieTableViewController") as! MovieTableViewController
    let movieViewModel = MovieViewModel(movie: movie)
    vc.movieViewModel = movieViewModel
    let nav = UINavigationController(rootViewController: vc)
    self.splitViewController?.showDetailViewController(nav, sender: self)
  }
}

// MARK: - UISplitViewControllerDelegate

extension CatalogTableViewController: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
    guard let topAsDetailController = secondaryAsNavController.topViewController as? MovieTableViewController else { return false }
    if topAsDetailController.movie == nil {
      return true
    }
    return false
  }
}
