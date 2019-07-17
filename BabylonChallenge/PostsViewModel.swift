//
//  PostsViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa

class PostsViewModel: ViewModelType {
    
    struct Input {
        let query: Observable<String>
        let isRefreshing: Observable<Bool>
    }
    
    struct Output {
        let posts: Driver<[Post]>
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
    private let postsSubject = BehaviorRelay<[Post]>(value: [])
    private let forcedReloadSubject = BehaviorRelay<Bool>(value: false)
    private let loadingStateSubject = BehaviorRelay<LoadingState>(value: .loading)
    
    private let disposeBag = DisposeBag()

    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
        requestPosts()
    } 
    
    func transform(_ input: Input) -> Output {
        
        input.isRefreshing
            .filter { $0 == true }
            .subscribe(onNext: { [weak self] _ in self?.requestPosts(forced: true) })
            .disposed(by: disposeBag)

        let posts = postsSubject.asDriver(onErrorJustReturn: [])
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
            .subscribe(onSuccess: { [postsSubject, loadingStateSubject] in
                postsSubject.accept($0)
                loadingStateSubject.accept(.loaded)
                },
                       onError: { [loadingStateSubject] in
                        loadingStateSubject.accept(.failed(title: "", message: $0.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}
