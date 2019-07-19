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
        let authorName: Observable<String>
        let postTitle, postBody, viewCommentsString: Driver<String>
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
        
        // FIXME: - convert to driver, problem with decodable
        //let persistedAuthor = realm.object(ofType: AuthorObject.self, forPrimaryKey: post.value.id) ?? AuthorObject()
        
        //var authorName = Observable.just("")
        //if persistedAuthor != nil {
            //let author = Observable.from(object: persistedAuthor)
            //let authorName = author.map { $0.name }
        //}
        
        //let author = Observable.from(object: persistedAuthor!)
        //let authorName = author.map { $0.name }
        
        let postTitle = post.map { $0.title.capitalizeOnlyFirstCharacters() }.asDriver(onErrorJustReturn: "")
        let postBody = post.map { $0.body }.asDriver(onErrorJustReturn: "")
        
        let viewCommentsString = getComments().map { "view \($0.count) comments" }
        
        return Output(authorName: Observable.just(""),
                      postTitle: postTitle,
                      postBody: postBody,
                      viewCommentsString: viewCommentsString)
    }
    
    
    private func getComments() -> Driver<Results<CommentObject>> {
        return Observable
            .collection(from: realm.objects(CommentObject.self))
            .map { [post] in $0.filter("postId == %@", post.value.id) }
            .asDriver(onErrorJustReturn: CommentObject())
            .map { $0 as! Results<CommentObject> }
    }
    
    private func addToRealm() {
        
        let authorRequest = domainModelGetter
            .rx_getModels(from: UsersEndPoint.user(by: post.value.userId), convertTo: AuthorObject.self)
            .retry(3)
            .map { $0.first! }
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
