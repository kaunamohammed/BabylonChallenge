//
//  Comment.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RealmSwift

// MARK: - CommentObject
class CommentObject: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var postId: Int = 0
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
