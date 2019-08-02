//
//  AuthorViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa

struct AuthorViewModel: ViewModelType {

    struct Input {}

    struct Output {
        let author: Driver<AuthorObject>
    }

    // MARK: - Subjects
    public let userId = BehaviorRelay<Int>(value: 0)

    private let persistenceManager: Persistable
    // MARK: - Init
    init(persistenceManager: Persistable) {
        self.persistenceManager = persistenceManager
    }

    func transform(_ input: Input) -> Output {

        //let auhorFilter = realm.object(ofType: AuthorObject.self, forPrimaryKey: userId.value)

        let author =  persistenceManager
            .fetch(AuthorObject.self)
            .map { [userId] in $0.first(where: { $0.id == userId.value }) ?? AuthorObject() }
            .asDriver(onErrorJustReturn: AuthorObject())

        return Output(author: author)
    }

}
