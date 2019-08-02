//
//  RealmPersistenceStorage.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 02/08/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxRealm
import RxSwift
import RealmSwift

class RealmPersistenceStorage: Persistable {

    private let realm = try! Realm()

    private let disposeBag = DisposeBag()

    func insert<T>(_ objects: [T]) where T: Storable {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        guard let realmObject = objects as? [Object] else { return }
        try! realm.write { realm.add(realmObject, update: .modified) }
    }

    func fetch<T>(_ object: T.Type, completion: @escaping ((Result<[T], PersistenceError>) -> Void)) where T: Storable {

        guard let realmObjectType = object as? Object.Type else { completion(.failure(.unrecognizedPersistedObject)); return
        }

        Observable.collection(from: realm.objects(realmObjectType))
            .filter { !$0.isEmpty }
            .subscribe(onNext: { completion(.success(Array($0.compactMap { $0 as? T }))) },
                       onError: { e in })
            .disposed(by: disposeBag)

    }

}
