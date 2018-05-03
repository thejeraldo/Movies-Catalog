//
//  CategoryTableViewCell.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellDelegate: class {
  func didSelectMovie(movie: Movie)
  func loadNext(_ movieList: MovieList)
}

class CategoryTableViewCell: UITableViewCell {
  
  weak var delegate: CategoryTableViewCellDelegate?
  
  var movieList: MovieList?
  var isLoading: Bool = false
  let layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 8
    layout.minimumLineSpacing = 8
    let height: Double = 150
    let width: Double = 100
    layout.itemSize = CGSize(width: width, height: height)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    return layout
  }()
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self as UICollectionViewDataSource
      collectionView.delegate = self as UICollectionViewDelegate
      collectionView.showsHorizontalScrollIndicator = false
      collectionView.collectionViewLayout = layout
      collectionView.backgroundColor = UIColor(named: "dark")
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = self.movieList?.movies?.count {
      return count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
    let movie = self.movieList?.movies![indexPath.row]
    cell.setupWithMovie(movie!)
    return cell
  }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let count = self.movieList?.movies?.count
    let last = count! - 1
    if indexPath.row == last && !isLoading {
      let next = (count! / 20) + 1
      print("Load next page: \(next) \(movieList?.listType?.title() ?? "")")
      isLoading = true
      self.delegate?.loadNext(self.movieList!)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = self.movieList?.movies![indexPath.row]
    self.delegate?.didSelectMovie(movie: movie!)
  }
}
