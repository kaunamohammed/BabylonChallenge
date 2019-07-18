//
//  FullPostViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 18/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa

struct FullPostViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let authorName, postTitle, postBody, viewCommentsString: Driver<String>        
    }
    
    // MARK: - Subjects
    public let post = BehaviorRelay<RMPost>(value: RMPost())
    
    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
    }
    
    func transform(_ input: Input) -> Output {
        
        let authorRequest = domainModelGetter
            .rx_getModels(from: UsersEndPoint.user(by: post.value.userId), convertTo: Author.self)
            .retry(3)
            .asDriver(onErrorJustReturn: [])
            .map { $0.first! }
        
        let commentsRequest = domainModelGetter
            .rx_getModels(from: CommentsEndPoint.comments(by: post.value.id), convertTo: Comment.self)
            .retry(3)
            .asDriver(onErrorJustReturn: [])
        
        let syncronizedRequest = Driver.zip(authorRequest, commentsRequest) { (author: $0, comments: $1) }
        
        let author = syncronizedRequest.map { $0.author }
        let comments = syncronizedRequest.map { $0.comments }
        
        let authorName = author.map { "by \($0.name)" }
        let postTitle = post.map { $0.title }.asDriver(onErrorJustReturn: "")
        let postBody = post.map { $0.body }.asDriver(onErrorJustReturn: "")

        let viewCommentsString = comments.map { "view \($0.count) comments" }
        
        return Output(authorName: authorName,
                      postTitle: postTitle,
                      postBody: postBody,
                      viewCommentsString: viewCommentsString)
    }
    
    
}
