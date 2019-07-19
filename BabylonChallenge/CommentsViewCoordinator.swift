//
//  CommentsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class CommentsViewCoordinator: NavigationCoordinator<CommentsViewController> {
    
    var post: PostObject!
    
    override func start() {
        
        // TODO: - Possibly reuse router
        
        let viewModel = CommentsViewModel(domainModelGetter: ModelLoader(networkRouter: Router()))
        viewModel.userId.accept(post.userId)
        viewModel.postId.accept(post.id)
        
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)
        
    }
    
}
