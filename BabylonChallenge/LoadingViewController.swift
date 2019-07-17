//
//  LoadingViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 15/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(loadingIndicator)
        loadingIndicator.center(in: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
    
}
