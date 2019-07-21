//
//  RefreshControl.swift
//  OutNow
//
//  Created by Kauna Mohammed on 25/05/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxRelay

class RefreshControl: NSObject {

  let isRefreshing = BehaviorRelay<Bool>(value: false)
  private let refreshControl = UIRefreshControl()

  init(holder: RefreshControlHoldable) {
    super.init()

    holder.add(refreshControl)
    refreshControl.addTarget(self, action: #selector(refreshControlDidRefresh), for: .valueChanged)
  }

  @objc private func refreshControlDidRefresh(_ control: UIRefreshControl) {
    startRefreshing()
  }

  func startRefreshing() {
    isRefreshing.accept(true)
    refreshControl.beginRefreshing()
  }

  func endRefreshing() {
    isRefreshing.accept(false)
    refreshControl.endRefreshing()
  }

}
