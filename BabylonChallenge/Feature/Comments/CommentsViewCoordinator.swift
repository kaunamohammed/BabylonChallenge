//
//  CommentsViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class CommentsViewCoordinator: NavigationCoordinator<CommentsViewController> {

    var postId: Int!

    private let persistenceManager: Persistable
    
    init(persistenceManager: Persistable,
         presenter: UINavigationController,
         removeCoordinator: @escaping ((Coordinatable) -> Void)) {
        self.persistenceManager = persistenceManager
        super.init(presenter: presenter, removeCoordinator: removeCoordinator)
    }
    
    override func start() {

        let viewModel = CommentsViewModel(persistenceManager: persistenceManager)
        viewModel.postId.accept(postId)
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)

    }

}
