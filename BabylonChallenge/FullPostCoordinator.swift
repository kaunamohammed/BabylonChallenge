//
//  FullPost.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 18/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class FullPostCoordinator: NavigationCoordinator<FullPostViewController> {
    
    var post: PostObject!
    
    override func start() {
        
        let viewModel = FullPostViewModel(domainModelGetter: ModelLoader(networkRouter: Router()))
        viewModel.post.accept(post)
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)
        
    }
    
}
