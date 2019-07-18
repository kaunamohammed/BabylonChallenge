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

extension String {
    
    var asInt: Int {
        return Int(self) ?? 0
    }
    
    func truncate(by length: Int, trailing: String = "...") -> String {
        return count > length ? String(prefix(length)) + trailing : self
    }
    
    func capitalizeOnlyFirstCharacters() -> String {
        
        let componentsSeparatedBySpace = self.components(separatedBy: " ")
        
        var newNewStr = String()
        
        componentsSeparatedBySpace.forEach { string in
            let stringWithFirstCharacterCap = string.prefix(1).capitalized + string.dropFirst()
            newNewStr.append(stringWithFirstCharacterCap + " ")
        }
        
        return newNewStr.trimmingCharacters(in: .whitespaces)
    }
    
}

extension Int {
    
    var asString: String {
        return String(self)
    }
    
}

