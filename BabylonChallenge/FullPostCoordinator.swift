//
//  FullPost.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 18/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class FullPostCoordinator: ChildCoordinator<FullPostViewController> {
    
    var post: PostObject!
    
    private var commentsViewCoordinator: CommentsViewCoordinator? = nil
    private var authorViewCoordinator: AuthorViewCoordinator? = nil
    
    override func start() {
        
        let viewModel = FullPostViewModel(domainModelGetter: ModelLoader(networkRouter: Router()))
        viewModel.post.accept(post)
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)
        
        viewController.didTapViewComments = { [startCommentsViewCoordinator] id in
            startCommentsViewCoordinator(id)
        }
        
        viewController.didTapViewAuthor = { [startAuthorViewCoordinator] id in
            startAuthorViewCoordinator(id)
        }
        
    }
    
    func startCommentsViewCoordinator(with postId: Int) {
        commentsViewCoordinator = CommentsViewCoordinator(presenter: presenter,
                                                          removeCoordinator: remove)
        commentsViewCoordinator!.postId = postId
        add(child: commentsViewCoordinator!) 
        commentsViewCoordinator!.start()
    }
    
    func startAuthorViewCoordinator(with userId: Int) {
        authorViewCoordinator = AuthorViewCoordinator(presenter: presenter,
                                                      removeCoordinator: remove)
        authorViewCoordinator!.userId = userId
        add(child: authorViewCoordinator!)
        authorViewCoordinator!.start()
    }
    
}
