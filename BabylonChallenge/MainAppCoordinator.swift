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
 
 It inherits from the `ChildCoordinator` base class which encapsulates the implementation details having to do with navigation and child coordinator management i.e adding/removing a child coordinator
 
 I could mark this class as `final` but incase I want to kick of a different navigation flow based on business logic I'll like to inherit from this class
 */
public class MainAppCoordinator: AppCoordinator {
    
    private var postsViewCoordinator: PostsViewCoordinator? = nil
    
    override public func start() {
        
        startPostsViewCoordinator()
        
    }
    
}

// MARK: - Child Coordinators
private extension MainAppCoordinator {
    
    func startPostsViewCoordinator() {
        postsViewCoordinator = .init(presenter: presenter,
                                     removeCoordinator: remove)
        add(child: postsViewCoordinator!)
        postsViewCoordinator?.start()
    }
    
}
