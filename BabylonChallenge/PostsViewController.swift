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
        table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var searchController: AppSearchController = {
        let controller = AppSearchController(searchResultsController: nil)
        controller.searchBar.placeholder = NSLocalizedString("posts", comment: "title")
        return controller
    }()
    
    // MARK: - Child
    private lazy var loadingViewController: LoadingViewController = .init()
    
    private var disposeBag: DisposeBag?
    var goToPostDetail: (() -> ())?
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
        title = NSLocalizedString("Posts", comment: "title")
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        definesPresentationContext = true
        
        navigationItem.add(searchController)
        
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
        
        let input = PostsViewModel.Input(query: searchController.searchBar.rx.text.orEmpty.asObservable(),
                                         isRefreshing: refreshControl.isRefreshing.asObservable())
        let output = viewModel.transform(input)
                
        disposeBag?.insert (
            
            output.posts
                .do(onNext: { [refreshControl] _ in refreshControl.endRefreshing() })
                .drive(postsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, rmPost, cell in
                    let post = Post(rmPost: rmPost)
                    cell.configure(with: post)
            },
            
//            output.posts
//                .do(onNext: { [refreshControl] _ in refreshControl.endRefreshing() })
//                .drive(postsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, post, cell in
//                    cell.configure(with: post)
//            },
//
            output.loadingState
                .subscribe(onNext: { [add, remove, loadingViewController, refreshControl] state in
                    switch state {
                    case .loading:
                        add(loadingViewController)
                    case .loaded:
                        remove(loadingViewController)
                    case .failed(title: _, message: let message):
                        remove(loadingViewController)
                        refreshControl.endRefreshing()
                        print(message)
                    }
                }),
            
            output.postsLoadedForFirstTime
                .subscribe(onNext: { [add, remove, loadingViewController] isFirstTime in
                    isFirstTime ? add(loadingViewController) : remove(loadingViewController)
                }),
            
            postsTableView.rx.modelSelected(RMPost.self).subscribe(onNext: { post in
                
            })
        )
        
    }
    
}

