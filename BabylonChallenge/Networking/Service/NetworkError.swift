//
//  NetworkError.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

enum NetworkError {
    case unknown
    case outdated
    case badRequest
    case failed
    case authError
    case noData
    case unableToDecode
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .unknown: return "We couldn't fulfil this request"
    case .outdated: return "The url you requested is outdated"
    case .badRequest: return "Bad Request"
    case .authError: return "You need to be authenticated first"
    case .failed: return "Network request failed"
    case .noData: return "Nothing to display at the moment"
    case .unableToDecode: return "unable to show posts"
    }
  }
}
