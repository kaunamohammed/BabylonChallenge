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
        let relatedComments: Observable<[PostObject]>
    }
    
    // MARK: - Subjects
    public let post = BehaviorRelay<PostObject>(value: PostObject())
    
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    
    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
    }
    
    func transform(_ input: Input) -> Output {
        
        Observable
            .zip(author, comments) { (author: $0, comments: $1) }
            .subscribe(onNext: { [realm ] author, comments in
                try! realm.write {
                    realm.add(author, update: .modified)
                    realm.add(comments, update: .modified)
                }
            }).disposed(by: disposeBag)
        
        
        return Output(authorName: authorName,
                      postTitle: postTitle,
                      postBody: postBody,
                      numberOfComments: totalComments,
                      relatedComments: relatedPosts)
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
        return Observable
            .collection(from: realm.objects(AuthorObject.self))
            .map { [post] in $0.first(where: { $0.id == post.value.userId})?.name }
            .map { "by \($0.orEmpty)" }
            .asDriver(onErrorJustReturn: "")
    }
    
    var commentsSource: Observable<Results<CommentObject>> {
        return Observable
            .collection(from: realm.objects(CommentObject.self))
            .share()
    }
    
    var totalComments: Driver<String> {
        return commentsSource
            .map { [post] in $0.filter("postId == %@", post.value.id).count }
            .map { "view \($0) comments" }
            .asDriver(onErrorJustReturn: "")
    }
    
    var relatedPosts: Observable<[PostObject]> {
        return Observable
            .collection(from: realm.objects(PostObject.self))
            .map { Array($0.shuffled().prefix(5)) }
            .share()
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
