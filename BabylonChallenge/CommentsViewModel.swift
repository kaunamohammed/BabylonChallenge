//
//  CommentsViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa

struct CommentsViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let user: Driver<Author>
        let comments: Driver<[Comment]>
    }
    
    // MARK: - Subjects
    public let userId = BehaviorRelay<Int>(value: 0)
    public let postId = BehaviorRelay<Int>(value: 0)
    
    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
    }
    
    
    
    func transform(_ input: Input) -> Output {

        let userRequest = domainModelGetter
            .rx_getModels(from: UsersEndPoint.user(by: userId.value), convertTo: Author.self)
            .retry(3)
            .asDriver(onErrorJustReturn: [])
            .map { $0.first! }
        
        let commentsRequest = domainModelGetter
            .rx_getModels(from: CommentsEndPoint.comments(by: postId.value), convertTo: Comment.self)
            .retry(3)
            .asDriver(onErrorJustReturn: [])
        
        let syncronizedRequest = Driver.zip(userRequest, commentsRequest) { (user: $0, comments: $1) }
        
        let user = syncronizedRequest.map { $0.user }
        let comments = syncronizedRequest.map { $0.comments }

        return Output(user: user,
                      comments: comments)
    }
    
}
