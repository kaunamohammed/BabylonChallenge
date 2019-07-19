//
//  Post.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RealmSwift
import Foundation

// MARK: - Post
struct Post: Decodable {
    let userId, id: Int
    let title, body: String
}

extension Post {
    
    init(rmPost: PostObject) {
        self.userId = rmPost.userId
        self.id = rmPost.id
        self.title = rmPost.title
        self.body = rmPost.body
    }
    
    func convertToRMPost() -> PostObject {
        let rmPost = PostObject()
        rmPost.id = id
        rmPost.userId = userId
        rmPost.title = title
        rmPost.body = body
        return rmPost
    }
        
}


// MARK: - PostObject
class PostObject: Object {
    @objc dynamic var userId = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

