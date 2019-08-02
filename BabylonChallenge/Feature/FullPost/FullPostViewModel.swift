//
//  FullPostViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 18/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class FullPostViewModel: ViewModelType {

    struct Input {}

    struct Output {
        let authorName, postTitle, postBody, numberOfComments: Driver<String>
        let relatedPosts: Driver<[PostObject]>
    }

    // MARK: - Subjects
    public let post = BehaviorRelay<PostObject>(value: PostObject())

    // MARK: - Properties (Private)
    private let realm = try! Realm()
    private lazy var disposeBag = DisposeBag()

    private let domainModelGetter: DomainModelGettable
    private let persistenceManager: Persistable
    // MARK: - Init
    init(domainModelGetter: DomainModelGettable, persistenceManager: Persistable) {
        self.domainModelGetter = domainModelGetter
        self.persistenceManager = persistenceManager
    }

    func transform(_ input: Input) -> Output {

        Observable
            .zip(author, comments) { (author: $0, comments: $1) }
            .subscribe(onNext: { [persistenceManager] author, comments in
                    persistenceManager.insert([author])
                    persistenceManager.insert(comments)
            }).disposed(by: disposeBag)

        return Output(authorName: authorName,
                      postTitle: postTitle,
                      postBody: postBody,
                      numberOfComments: totalComments,
                      relatedPosts: relatedPosts)
    }

}

private extension FullPostViewModel {

    var postTitle: Driver<String> {
        return post
            .map { $0.title.capitalizeOnlyFirstCharacters() }
            .asDriver(onErrorJustReturn: "")
    }

    var postBody: Driver<String> {
        return post
            .map { $0.body }
            .asDriver(onErrorJustReturn: "")
    }

    var authorName: Driver<String> {
        return persistenceManager
            .fetch(AuthorObject.self)
            .map { [post] in $0.first(where: { $0.id == post.value.userId })?.name }
            .map { $0.orEmpty }
            .asDriver(onErrorJustReturn: "")
    }

    var totalComments: Driver<String> {
        return persistenceManager
            .fetch(CommentObject.self)
            .map { [post] in $0.filter { $0.postId == post.value.id }.count }
            .map { "view \($0) comments" }
            .asDriver(onErrorJustReturn: "")
    }

    var relatedPosts: Driver<[PostObject]> {
        return persistenceManager
            .fetch(PostObject.self)
            .map { Array($0.shuffled().prefix(5)) }
            .asDriver(onErrorJustReturn: [])
    }

    var author: Observable<AuthorObject> {
        return domainModelGetter
            .rx_getModels(from: UsersEndPoint.user(by: post.value.userId), convertTo: AuthorObject.self)
            .retry(3)
            .map { $0.first ?? .init() }
            .asObservable()
    }

    var comments: Observable<[CommentObject]> {
        return domainModelGetter
            .rx_getModels(from: CommentsEndPoint.comments(by: post.value.id), convertTo: CommentObject.self)
            .retry(3)
            .asObservable()
    }

}
