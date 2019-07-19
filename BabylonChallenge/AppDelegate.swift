//
//  AppDelegate.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RealmSwift
import CoordinatorLibrary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // keeping a reference so that it lasts the entirety of the app lifecycle
    // Although I have initialized it from here, it is still possible to just keep a reference and then inherit from `AppCoordinator`
    // and start different flows based oon business logic i.e a notification or deeplink
    private lazy var appCoordinator: AppCoordinator = {
        let coordinator = MainAppCoordinator(presenter: AppNavigationController(), window: window!)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        // start the navigation
        appCoordinator.start()
        
//        let config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 1,
//
//            // Set the block which will be called automatically when opening a Realm with
//            // a schema version lower than the one set above
//            migrationBlock: { migration, oldSchemaVersion in
//                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion < 1) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//        })
//
//        // Tell Realm to use this new configuration object for the default Realm
//        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
        
        return true
    }

}

