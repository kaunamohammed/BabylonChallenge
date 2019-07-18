//
//  PostDetailViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostDetailViewCoordinator: NavigationCoordinator<PostDetailViewController> {
    
    var post: RMPost!
    
    override func start() {
        
        // TODO: - Possibly reuse router
        
        let viewModel = PostDetailViewModel(domainModelGetter: ModelLoader(networkRouter: Router()))
        viewModel.userId.accept(post.userId)
        viewModel.postId.accept(post.id)
        
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)
        
    }
    
}
