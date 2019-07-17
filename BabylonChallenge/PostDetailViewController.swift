//
//  PostDetailViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    private let viewModel: PostDetailViewModel
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Detail", comment: "title")

        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }

}
