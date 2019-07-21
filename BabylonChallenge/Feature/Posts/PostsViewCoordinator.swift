//
//  PostsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostsViewCoordinator: ChildCoordinator<PostsViewController> {
    
    // MARK: - Child Coordinators
    private var fullPostViewCoordinator: FullPostCoordinator? = nil
    
    override func start() {

        viewController = .init(viewModel: .init(domainModelGetter: ModelLoader(networkRouter: Router())))
        navigate(to: viewController, with: .set, animated: false)
        
        viewController.goToFullPost = { [startFullPostCoordinator] post in
            startFullPostCoordinator(post)
        }
        
    }
    
}

extension PostsViewCoordinator {
    
    func startFullPostCoordinator(with post: PostObject) {
        fullPostViewCoordinator = FullPostCoordinator(presenter: presenter,
                                                      removeCoordinator: remove)
        fullPostViewCoordinator!.post = post
        add(child: fullPostViewCoordinator!)
        fullPostViewCoordinator!.start()
    }
        
}
