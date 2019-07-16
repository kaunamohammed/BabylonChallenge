//
//  Post.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

// MARK: - Post
struct Post: Decodable {
    let userId, id: Int
    let title, body: String
}
