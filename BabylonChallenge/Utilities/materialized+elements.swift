//
//  materialized+elements.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 13/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift

extension ObservableType where Element: EventConvertible {
    
    func elements() -> Observable<Element.Element> {
        return filter { $0.event.element != nil }.map { $0.event.element! }
    }
    
    func errors() -> Observable<Swift.Error> {
        return filter { $0.event.error != nil }.map { $0.event.error! }
    }
    
}
