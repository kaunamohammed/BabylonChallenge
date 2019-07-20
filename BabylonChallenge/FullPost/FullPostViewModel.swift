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
    
    struct Input {
        
    }
    
    struct Output {
        let authorName: Driver<String>
        let postTitle, postBody, viewCommentsString: Driver<String>
    }
    
    private var authorName: Driver<String> {
        return Observable
            .collection(from: realm.objects(AuthorObject.self))
            .map { [post] in $0.first(where: { $0.id == post.value.userId})?.name }
            .map { $0.orEmpty }
            .asDriver(onErrorJustReturn: "")
    }
    
    private var totalComments: Driver<String> {
        Observable
            .collection(from: realm.objects(CommentObject.self))
            .map { [post] in $0.filter("postId == %@", post.value.id).count }
            .map { "view \($0) comments" }
            .asDriver(onErrorJustReturn: "")
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
        
        addToRealm()
                
        let postTitle = post.map { $0.title.capitalizeOnlyFirstCharacters() }.asDriver(onErrorJustReturn: "")
        let postBody = post.map { $0.body }.asDriver(onErrorJustReturn: "")
                
        return Output(authorName: authorName,
                      postTitle: postTitle,
                      postBody: postBody,
                      viewCommentsString: totalComments)
    }
            
    private func addToRealm() {
        
        let authorRequest = domainModelGetter
            .rx_getModels(from: UsersEndPoint.user(by: post.value.userId), convertTo: AuthorObject.self)
            .retry(3)
            .map { $0.first ?? .init() }
            .asObservable()
        
        let commentsRequest = domainModelGetter
            .rx_getModels(from: CommentsEndPoint.comments(by: post.value.id), convertTo: CommentObject.self)
            .retry(3)
            .asObservable()
        
        Observable
            .zip(authorRequest, commentsRequest) { (author: $0, comments: $1) }
            .subscribe(onNext: { [realm ] author, comments in
                    try! realm.write {
                        realm.add(author, update: .modified)
                        realm.add(comments, update: .modified)
                    }
            }).disposed(by: disposeBag)
        
    }
    
}