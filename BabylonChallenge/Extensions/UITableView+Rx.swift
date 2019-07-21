//
//  UITableView+Rx.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 17/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    var unHighlightAtIndexPathAfterSelection: Binder<IndexPath> {
        return Binder(base) { list, indexPath in
            list.deselectRow(at: indexPath, animated: true)
        }
    }
}
