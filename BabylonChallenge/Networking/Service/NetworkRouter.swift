//
//  NetworkRouter.swift
//  ExpensifyCodingTest
//
//  Created by Kauna Mohammed on 05/06/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import RxSwift
import Foundation

protocol NetworkRouter: class {
    func request(endPoint: EndPoint, completion: @escaping ((Result<Data, NetworkError>) -> Void))
    func cancel()
}

