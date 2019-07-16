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
    
    private lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Child
    private lazy var loadingViewController: LoadingViewController = .init()
    
    private var disposeBag: DisposeBag?
    private lazy var refreshControl = RefreshControl(holder: postsTableView)
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
        setUpTableView()
        disposeBag = DisposeBag()
        bindToRx()
    }
    
    private func setUpTableView() {
        view.addSubview(postsTableView)
        postsTableView.pin(to: view)
        postsTableView.register(PostTableViewCell.self)
    }
    
}

private extension PostsViewController {
    
    func bindToRx() {
        let input = PostsViewModel.Input(isRefreshing: refreshControl.isRefreshing.asObservable())
        let output = viewModel.transform(input)
                
        disposeBag?.insert (
            
            output.posts
                .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
                .drive(postsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, post, cell in
                    cell.configure(with: post)
            },
            
            output.loadingState.subscribe(onNext: { [weak self] state in
                guard let `self` = self else { return }
                switch state {
                case .none:
                    print("Nothing")
                case .loading:
                    self.add(self.loadingViewController)
                case .loaded:
                    self.remove(self.loadingViewController)
                case .failed(title: _, message: let message):
                    self.remove(self.loadingViewController)
                    self.refreshControl.endRefreshing()
                    print(message)
                }
            }),

            output.isInitialLoad.debug("Initial load", trimOutput: true).subscribe(onNext: { [weak self] isInitialLoad in
                guard let `self` = self else { return }
                isInitialLoad ? self.add(self.loadingViewController) : self.remove(self.loadingViewController)
            })
            
        )
        
    }
    
}
