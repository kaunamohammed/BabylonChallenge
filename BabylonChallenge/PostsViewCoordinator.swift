//
//  PostsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class PostsViewCoordinator: ChildCoordinator<PostsViewController> {
    
    private var postDetailViewCoordinator: PostDetailViewCoordinator? = nil
    
    override func start() {
        
        if #available(iOS 11.0, *) {
            presenter.navigationBar.prefersLargeTitles = true
        } else {
        }
        
        viewController = .init(viewModel: .init(domainModelGetter: ModelLoader(networkRouter: Router())))
        navigate(to: viewController, with: .set, animated: false)
        
    }
    
}

extension PostsViewCoordinator {
    
    func startPostDetail() {
        postDetailViewCoordinator = PostDetailViewCoordinator(presenter: presenter,
                                                              removeCoordinator: remove)
        add(child: postDetailViewCoordinator!) 
        postDetailViewCoordinator!.start()
    }
    
}
