//
//  CommentsViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

struct CommentsViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        let comments: Observable<Results<CommentObject>>
    }
    
    // MARK: - Subjects
    public let postId = BehaviorRelay<Int>(value: 0)
    
    private let realm = try! Realm()
        
    func transform(_ input: Input) -> Output {
        
        let commentsFilter = realm.objects(CommentObject.self).filter("postId == %@", postId.value)

        let comments = Observable.collection(from: commentsFilter)
        
        return Output(comments: comments)
    }
    
}
