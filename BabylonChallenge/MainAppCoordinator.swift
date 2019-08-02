//
//  MainAppCoordinator.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import CoordinatorLibrary

/**
 'MainAppCoordinator' is similar to the 'AppDelegate' class in the sense that it starts all other coordinators used in the app. It is also used to pass dependencies down the hierachies
 
 */
public class MainAppCoordinator: AppCoordinator {

    // MARK: - Child Coordinators
    private var postsViewCoordinator: PostsViewCoordinator?

    override public func start() {

        startPostsViewCoordinator()

    }
}

private extension MainAppCoordinator {

    func startPostsViewCoordinator() {
        postsViewCoordinator = .init(persistenceManager: RealmPersistenceStorage(),
                                     presenter: presenter,
                                     removeCoordinator: remove)
        add(child: postsViewCoordinator!)
        postsViewCoordinator?.start()
    }
}
