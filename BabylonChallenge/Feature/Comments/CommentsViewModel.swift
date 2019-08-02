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

    struct Input {}

    struct Output {
        let comments: Driver<[CommentObject]>
    }

    // MARK: - Subjects
    public let postId = BehaviorRelay<Int>(value: 0)

    private let persistenceManager: Persistable
    // MARK: - Init
    init(persistenceManager: Persistable) {
        self.persistenceManager = persistenceManager
    }

    func transform(_ input: Input) -> Output {

        let comments = persistenceManager
            .fetch(CommentObject.self)
            .map { [postId] in $0.filter { $0.postId == postId.value } }
            .asDriver(onErrorJustReturn: [])

        return Output(comments: comments)
    }

}
