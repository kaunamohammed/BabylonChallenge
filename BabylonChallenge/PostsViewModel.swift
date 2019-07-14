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
        let errorMessage: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    private let postsSubject = BehaviorRelay<[Post]>(value: [])
    private let errorMessageSubject = BehaviorRelay<String>(value: "")

    
    private let networkRouter: NetworkRouter
    init(networkRouter: NetworkRouter) {
        self.networkRouter = networkRouter
    } 
    
    func transform(_ input: Input) -> Output {        
        
        let posts = postsSubject.asDriver(onErrorJustReturn: [])
        let noPostsToDisplay = posts.map { $0.isEmpty }
        
        return Output(posts: posts,
                      noPostsToDisplay: noPostsToDisplay,
                      errorMessage: errorMessageSubject.asObservable())
    }
    
    func requestPosts() {
        
        networkRouter
            .request(type: Post.self, from: EndPointFactory.endPoint(for: .posts))
            .debug("Post Request", trimOutput: true)
            .subscribe(onSuccess: { [weak self] in self?.postsSubject.accept($0) },
                       onError: { [weak self] in self?.errorMessageSubject.accept($0.localizedDescription) })
            .disposed(by: disposeBag)
        
    }
    
}
