//
//  AppSearchController.swift
//  Common
//
//  Created by Kauna Mohammed on 23/04/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

public class AppSearchController: UISearchController {
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    dimsBackgroundDuringPresentation = false
    hidesNavigationBarDuringPresentation = false
    searchBar.barStyle = .black
    searchBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    searchBar.textField?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    searchBar.keyboardAppearance = .dark
    
  }
  
}


extension UISearchBar {
    
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }
}
