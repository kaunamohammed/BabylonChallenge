//
//  PostsViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class PostsViewModel: ViewModelType {

    struct Input {
        let isRefreshing: Observable<Bool>
    }

    struct Output {
        let posts: Observable<Results<PostObject>>
        let noPostsToDisplay: Observable<Bool>
        let loadingState: Observable<LoadingState>
    }

    enum LoadingState {
        case loading
        case loaded
        case failed(title: String, message: String)
    }

    // MARK: - Subjects
    private let loadingState = BehaviorRelay<LoadingState>(value: .loading)

    // MARK: - Properties (Private)
    private let disposeBag = DisposeBag()
    private let realm = try! Realm()
    private lazy var persistedPosts = realm.objects(PostObject.self)

    private let domainModelGetter: DomainModelGettable

    // MARK: - Init
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
        #if DEBUG
        print(realm.configuration.fileURL?.absoluteString ?? "")
        try! realm.write {
            realm.delete(persistedPosts)
        }
        #endif
    }

    func transform(_ input: Input) -> Output {

        input.isRefreshing
            .filter { $0 == true }
            .subscribe(onNext: { [requestPosts] _ in requestPosts() })
            .disposed(by: disposeBag)

        let posts = Observable
            .collection(from: persistedPosts)
            .map { $0.sorted(byKeyPath: "id") }
            //.asDriver(onErrorJustReturn: PostObject())
            //.map { $0 as! Results<PostObject> }

        let noPostsToDisplay = posts.map { $0.isEmpty }

        return Output(posts: posts,
                      noPostsToDisplay: noPostsToDisplay,
                      loadingState: loadingState.asObservable())
    }

}

extension PostsViewModel {
    func requestPosts() {
        loadingState.accept(.loading)

        domainModelGetter.rx_getModels(from: EndPointFactory.endPoint(for: .posts), convertTo: PostObject.self)
            .subscribe(onSuccess: { [realm, loadingState] posts in
                loadingState.accept(.loaded)
                try! realm.write {
                    realm.add(posts, update: .modified)
                }
                },
                       onError: { [loadingState] in
                        loadingState.accept(.failed(title: "", message: $0.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}
