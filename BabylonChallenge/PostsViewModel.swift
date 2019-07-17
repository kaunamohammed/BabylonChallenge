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
        let query: Observable<String>
        let isRefreshing: Observable<Bool>
    }
    
    struct Output {
        let posts: Driver<Results<RMPost>>
        let noPostsToDisplay: Driver<Bool>
        let postsLoadedForFirstTime: Observable<Bool>
        let loadingState: Observable<LoadingState>
    }
    
    enum LoadingState {
        case loading
        case loaded
        case failed(title: String, message: String)
    }
    
    // MARK: - Subjects
    private let forcedReloadSubject = BehaviorRelay<Bool>(value: false)
    private let loadingStateSubject = BehaviorRelay<LoadingState>(value: .loading)
    
    private let disposeBag = DisposeBag()
    private let realm = try! Realm()
    private lazy var persistedPosts = realm.objects(RMPost.self)

    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
        #if DEBUG
        print(realm.configuration.fileURL?.absoluteString ?? "")
        try! realm.write {
            realm.delete(persistedPosts)
        }
        #endif
        requestPosts()
    } 
    
    func transform(_ input: Input) -> Output {
        
        input.isRefreshing
            .filter { $0 == true }
            .subscribe(onNext: { [requestPosts] _ in requestPosts(true) })
            .disposed(by: disposeBag)
        
        let posts = Observable
            .collection(from: persistedPosts)
            .map { $0.sorted(byKeyPath: "id") }
            .asDriver(onErrorJustReturn: RMPost())
            .map { $0 as! Results<RMPost> }

        let noPostsToDisplay = posts.map { $0.isEmpty }
        
        return Output(posts: posts,
                      noPostsToDisplay: noPostsToDisplay,
                      postsLoadedForFirstTime: forcedReloadSubject.asObservable(),
                      loadingState: loadingStateSubject.asObservable())
    }
    
}

private extension PostsViewModel {
    func requestPosts(forced: Bool = false) {
        loadingStateSubject.accept(.loading)
        forcedReloadSubject.accept(!forced)
        
        domainModelGetter.rx_getModels(from: EndPointFactory.endPoint(for: .posts), convertTo: Post.self)
            .subscribe(onSuccess: { [realm, loadingStateSubject] posts in
                loadingStateSubject.accept(.loaded)
                let rmObjects = posts.map { $0.convertToRMPost() }
                try! realm.write {
                    realm.add(rmObjects)
                }
                },
                       onError: { [loadingStateSubject] in
                        loadingStateSubject.accept(.failed(title: "", message: $0.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}

