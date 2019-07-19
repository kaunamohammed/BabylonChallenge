//
//  Author.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RealmSwift

// MARK: - AuthorObject
final class AuthorObject: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var address: AddressObject? = .init()
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var company: CompanyObject? = .init()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// MARK: - AddressObject
class AddressObject: Object, Decodable {
    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""
    
    override static func primaryKey() -> String? {
        return "city"
    }
    
}


// MARK: - CompanyObject
class CompanyObject: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var catchPhrase: String = ""
    @objc dynamic var bs: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
