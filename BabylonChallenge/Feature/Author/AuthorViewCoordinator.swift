//
//  AuthorViewCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

final class AuthorViewCoordinator: NavigationCoordinator<AuthorViewController> {

    var userId: Int!

    private let persistenceManager: Persistable

    init(persistenceManager: Persistable,
        presenter: UINavigationController,
        removeCoordinator: @escaping ((Coordinatable) -> Void)) {
        self.persistenceManager = persistenceManager
        super.init(presenter: presenter, removeCoordinator: removeCoordinator)
    }

    override func start() {

        let viewModel = AuthorViewModel(persistenceManager: persistenceManager)
        viewModel.userId.accept(userId)
        viewController = .init(viewModel: viewModel)
        navigate(to: viewController, with: .push, animated: true)

    }

}
