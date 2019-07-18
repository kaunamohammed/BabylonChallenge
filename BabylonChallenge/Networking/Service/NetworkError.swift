//
//  NetworkError.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknown
}

enum NoDataError {
  case underlying
}

extension NoDataError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .underlying: return "We couldn't fulfil this request"
    }
  }
}
