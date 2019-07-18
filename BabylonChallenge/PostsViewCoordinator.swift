//
//  PostsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostsViewCoordinator: ChildCoordinator<PostsViewController> {
    
    private var fullPostViewCoordinator: FullPostCoordinator? = nil
    private var postDetailViewCoordinator: PostDetailViewCoordinator? = nil
    
    override func start() {

        viewController = .init(viewModel: .init(domainModelGetter: ModelLoader(networkRouter: Router())))
        navigate(to: viewController, with: .set, animated: false)
        
        viewController.goToPostDetail = { [startFullPostCoordinator] post in
            startFullPostCoordinator(post)
        }
        
    }
    
}

extension PostsViewCoordinator {
    
    func startFullPostCoordinator(with post: RMPost) {
        fullPostViewCoordinator = FullPostCoordinator(presenter: presenter,
                                                      removeCoordinator: remove)
        fullPostViewCoordinator!.post = post
        add(child: fullPostViewCoordinator!)
        fullPostViewCoordinator!.start()
    }
    
    func startPostDetail(with post: RMPost) {
        postDetailViewCoordinator = PostDetailViewCoordinator(presenter: presenter,
                                                              removeCoordinator: remove)
        postDetailViewCoordinator!.post = post
        add(child: postDetailViewCoordinator!)
        postDetailViewCoordinator!.start()
    }
    
}