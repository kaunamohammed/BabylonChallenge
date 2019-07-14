//
//  extensions.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 09/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import Foundation

/// small helper for testing purposes
func delay(seconds: Double, _ block: @escaping (() -> Void)) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    block()
  }
}

public extension Optional where Wrapped == String {
  var orEmpty: String {
    switch self {
    case .some(let value):
      return value
    case .none:
      return ""
    }
  }
}

extension String {
  
  var asInt: Int {
    return Int(self) ?? 0
  }
  
  var asDouble: Double {
    return Double(self) ?? 0.0
  }
  
  func truncate(by length: Int, trailing: String = "...") -> String {
    return count > length ? String(prefix(length)) + trailing : self
  }
  
}

extension Int {
  
  var asString: String {
    return String(self)
  }
  
  var asDouble: Double {
    return Double(self)
  }
  
}

