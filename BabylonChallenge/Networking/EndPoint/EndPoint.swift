//
//  EndPoint.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

class EndPoint: RESTComponent, URLProducer {
        
    var path: String {
        return ""
    }

    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    var queryItems: [URLQueryItem]
    
    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }
    
}

extension EndPoint {
    static func query(withID id: Int) -> EndPoint {
        return EndPoint(queryItems: [
            URLQueryItem(name: "id", value: id.asString)
            ])
    }
}

class PostsEndPoint: EndPoint {
    
    override var path: String {
        return  "/posts"
    }
    
    static func post(by id: Int) -> PostsEndPoint {
        
        return PostsEndPoint(queryItems: [
            
            URLQueryItem(name: "id", value: id.asString)
            
            
            ])
        
    }
    
}

class UsersEndPoint: EndPoint {

    override var path: String {
        return "/users"
    }

}

class CommentsEndPoint: EndPoint {

    override var path: String {
        return "/comments"
    }

}

class EndPointFactory {

    enum EndPointType: String {
        case posts
        case users
        case comments
    }
    
    static func endPoint(for type: EndPointType) -> EndPoint {
        switch type {
        case .posts:
            return PostsEndPoint()
        case .users:
            return UsersEndPoint()
        case .comments:
            return CommentsEndPoint()
        }
    }
    
}
