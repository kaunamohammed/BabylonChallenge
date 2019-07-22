//
//  AlertDisplayable.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 17/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

/**
 
 Displays an alert on a `UIViewController`
 
 - note:
 Here we're making the protocol only accessible to instances of `UIViewController`. For two reasons
 - To restrict the types that can display an alert
 - To give us access to properties/methods/functions available to `UIViewController`
 */
public protocol AlertDisplayable: UIViewController {
    func displayAlert(title: String?, message: String?, action: (() -> ())?)
}

public extension AlertDisplayable {
    func displayAlert(title: String? = nil, message: String?, action: (() -> ())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        if presentedViewController == nil {
            navigationController?.present(alertController, animated: true, completion: action)
        }
    }
}
