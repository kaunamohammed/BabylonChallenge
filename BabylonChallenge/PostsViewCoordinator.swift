//
//  PostsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostsViewCoordinator: NavigationCoordinator<PostsViewController> {
    
    override func start() {
        
        viewController = .init(viewModel: .init(modelLoader: .init(networkRouter: Router())))
        navigate(to: viewController, with: .set, animated: false)
        
    }
    
}
