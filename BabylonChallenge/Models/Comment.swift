//
//  Comment.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

// MARK: - Comment
struct Comment: Decodable {
    let id: Int
    let name, email: String
    let postId: Int
    let body: String
}
