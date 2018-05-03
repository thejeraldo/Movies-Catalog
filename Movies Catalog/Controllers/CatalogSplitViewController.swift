//
//  CatalogSplitViewController.swift
//  Movies Catalog
//
//  Created by Jeraldo Abille on 5/2/18.
//  Copyright © 2018 Jerald Abille. All rights reserved.
//

import UIKit

class CatalogSplitViewController: UISplitViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.darkGray
    preferredDisplayMode = .allVisible
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
