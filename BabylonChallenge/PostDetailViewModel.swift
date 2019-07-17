//
//  PostDetailViewModel.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import RxCocoa

struct PostDetailViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private let domainModelGetter: DomainModelGettable
    init(domainModelGetter: DomainModelGettable) {
        self.domainModelGetter = domainModelGetter
    }
    
    func transform(_ input: Input) -> Output {
        
        
        
        return Output()
    }
    
}
