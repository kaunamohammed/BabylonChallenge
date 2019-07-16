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
        let isRefreshing: Observable<Bool>
    }
    
    struct Output {
        let posts: Driver<[Post]>
        let noPostsToDisplay: Driver<Bool>
        let isInitialLoad: Observable<Bool>
        let loadingState: Observable<LoadingState>
    }
    
    enum LoadingState {
        case none
        case loading
        case loaded
        case failed(title: String, message: String)
    }
    
    // MARK: - Subjects
    private let postsSubject = BehaviorRelay<[Post]>(value: [])
    private let forcedReloadSubject = BehaviorRelay<Bool>(value: false)
    private let loadingStateSubject = BehaviorRelay<LoadingState>(value: .none)
    
    private let disposeBag = DisposeBag()

    private let modelLoader: PostsLoader
    init(modelLoader: PostsLoader) {
        self.modelLoader = modelLoader
        requestPosts()
    } 
    
    func transform(_ input: Input) -> Output {
        
        input.isRefreshing
            .filter { $0 == true } 
            .debug("Refreshing TableView", trimOutput: true)
            .subscribe(onNext: { [weak self] _ in self?.requestPosts(forced: true) })
            .disposed(by: disposeBag)

        let posts = postsSubject.asDriver(onErrorJustReturn: [])
        let noPostsToDisplay = posts.map { $0.isEmpty }
                
        return Output(posts: posts,
                      noPostsToDisplay: noPostsToDisplay,
                      isInitialLoad: forcedReloadSubject.asObservable(),
                      loadingState: loadingStateSubject.asObservable())
    }
    
}

private extension PostsViewModel {
    func requestPosts(forced: Bool = false) {
        loadingStateSubject.accept(.loading)
        forcedReloadSubject.accept(forced)
        
        modelLoader.getModels(from: EndPointFactory.endPoint(for: .posts))
            .subscribe(onSuccess: { [weak self] in
                self?.postsSubject.accept($0)
                self?.loadingStateSubject.accept(.loaded)
                },
                       onError: { [weak self] in
                        self?.loadingStateSubject.accept(.failed(title: "", message: $0.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}
