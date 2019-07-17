//
//  PostDetailViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostDetailViewCoordinator: NavigationCoordinator<PostDetailViewController> {
    
    override func start() {
        
        // TODO: - Possibly reuse router
        viewController = .init(viewModel: .init(domainModelGetter: ModelLoader(networkRouter: Router())))
        navigate(to: viewController, with: .set, animated: false)
        
    }
    
}
