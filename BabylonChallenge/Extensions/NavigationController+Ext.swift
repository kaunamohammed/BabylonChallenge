//
//  NavigationController+Ext.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 10/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func addTitleTextAttributes(attributes: [NSAttributedString.Key: Any]) {
        if #available(iOS 11.0, *) {
            largeTitleTextAttributes = attributes
        } else {
            titleTextAttributes = attributes
        }
        titleTextAttributes = attributes
    }
    
}

extension UINavigationItem {
    
    func add(_ searchController: UISearchController) {
        if #available(iOS 11.0, *) {
            self.searchController = searchController
        } else {
            titleView = searchController.searchBar
        }
    }
    
}
