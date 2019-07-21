//
//  Post.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RealmSwift

// MARK: - PostObject
class PostObject: Object, Decodable {
    @objc dynamic var userId = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
