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

    // MARK: - Child Coordinators
    private var fullPostViewCoordinator: FullPostCoordinator?
    private var commentsViewCoordinator: CommentsViewCoordinator?
    private var authorViewCoordinator: AuthorViewCoordinator?

    override func start() {

        let viewModel = FullPostViewModel(domainModelGetter: ModelLoader(networkRouter: Router()))
        viewModel.post.accept(post)
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)

        viewController.didTapViewComments = { [startCommentsViewCoordinator] postId in
            startCommentsViewCoordinator(postId)
        }

        viewController.didTapViewAuthor = { [startAuthorViewCoordinator] postId in
            startAuthorViewCoordinator(postId)
        }

        viewController.didTapToViewFullPost = { [startFullPostViewCoordinator] post in
            startFullPostViewCoordinator(post)
        }

    }

}

private extension FullPostCoordinator {

    func startFullPostViewCoordinator(with post: PostObject) {
        fullPostViewCoordinator = .init(presenter: presenter,
                                        removeCoordinator: remove)
        fullPostViewCoordinator!.post = post
        add(child: fullPostViewCoordinator!)
        fullPostViewCoordinator!.start()
    }

    func startCommentsViewCoordinator(with postId: Int) {
        commentsViewCoordinator = .init(presenter: presenter,
                                        removeCoordinator: remove)
        commentsViewCoordinator!.postId = postId
        add(child: commentsViewCoordinator!)
        commentsViewCoordinator!.start()
    }

    func startAuthorViewCoordinator(with userId: Int) {
        authorViewCoordinator = .init(presenter: presenter,
                                      removeCoordinator: remove)
        authorViewCoordinator!.userId = userId
        add(child: authorViewCoordinator!)
        authorViewCoordinator!.start()
    }

}
