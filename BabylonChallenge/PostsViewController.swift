//
//  PostsViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var refreshControl = RefreshControl(holder: tableView)
    
    private var disposeBag: DisposeBag?
    
    private let viewModel: PostsViewModel
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposeBag = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        view.addSubview(tableView)
        tableView.pin(to: view)
        tableView.register(PostTableViewCell.self)
        
        viewModel.requestPosts()
        disposeBag = DisposeBag()
        bindToRx()
    }
    
}

private extension PostsViewController {
    
    func bindToRx() {
        let input = PostsViewModel.Input(isRefreshing: refreshControl.isRefreshing.asObservable())
        let output = viewModel.transform(input)
                
        disposeBag?.insert (
            
            refreshControl.isRefreshing
                .filter { $0 == true }
                .subscribe(onNext: { [weak self] _ in
                    self?.viewModel.requestPosts()
                }),
            
            output.posts
                .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
                .drive(tableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, post, cell in
                    cell.configure(with: post)
            },
            
            output.errorMessage.subscribe(onNext: { [weak self] message in
                self?.refreshControl.endRefreshing()
                print(message)
            })
            
        )
        
    }
    
}
