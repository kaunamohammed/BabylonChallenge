//
//  AuthorViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

struct AuthorViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let author: Observable<AuthorObject>
    }
    
    // MARK: - Subjects
    public let userId = BehaviorRelay<Int>(value: 0)
        
    private let realm = try! Realm()
    
    func transform(_ input: Input) -> Output {
        
        let auhorFilter = realm.object(ofType: AuthorObject.self, forPrimaryKey: userId.value)
        
        let author = Observable.from(object: auhorFilter!)
        
        return Output(author: author)
    }
    
    
}