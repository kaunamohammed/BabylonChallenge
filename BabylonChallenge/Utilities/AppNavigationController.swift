//
//  AppNavigationController.swift
//  Drip
//
//  Created by Kauna Mohammed on 20/12/2018.
//  Copyright © 2018 Kauna Mohammed. All rights reserved.
//

import UIKit

public class AppNavigationController: UINavigationController {
  
  override public func viewDidLoad() {
    super.viewDidLoad()

    navigationBar.barTintColor = #colorLiteral(red: 0.06274509804, green: 0.05882352941, blue: 0.05882352941, alpha: 1)
    navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    navigationBar.isTranslucent = false
    navigationBar.shadowImage = .init()
    navigationBar.addTitleTextAttributes(attributes: [.foregroundColor: UIColor.white])
  }
  
  override public var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}


