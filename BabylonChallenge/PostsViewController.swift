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

class PostsViewController: UIViewController, AlertDisplayable {
    
    private lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Child
    private lazy var loadingViewController: LoadingViewController = .init()
    
    private var disposeBag: DisposeBag?
    var goToPostDetail: ((PostObject) -> ())?
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
            
        setUpTableView()
        disposeBag = DisposeBag()
        bindToRx()
    }
    
    private func setUpTableView() {
        view.addSubview(postsTableView)
        postsTableView.pin(to: self)
        postsTableView.removeEmptyCells()
        postsTableView.register(PostTableViewCell.self)
    }
    
}

private extension PostsViewController {
    
    func bindToRx() {
        
        let input = PostsViewModel.Input(isRefreshing: refreshControl.isRefreshing.asObservable())
        let output = viewModel.transform(input)
                
        disposeBag?.insert (
            
            output.posts
                .do(onNext: { [refreshControl] _ in refreshControl.endRefreshing() })
                .drive(postsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, rmPost, cell in
                    let post = Post(rmPost: rmPost)
                    cell.configure(with: post)
            },
            
            output.loadingState
                .subscribe(onNext: { [add, remove, loadingViewController, refreshControl, displayAlert] state in
                    switch state {
                    case .loading:
                        add(loadingViewController)
                    case .loaded:
                        remove(loadingViewController)
                        refreshControl.endRefreshing()
                    case .failed(title: let title, message: let message):
                        remove(loadingViewController)
                        refreshControl.endRefreshing()
                        displayAlert(title, message)
                    }
                }),
            
            output.postsLoadedForFirstTime
                .subscribe(onNext: { [add, remove, loadingViewController] isFirstTime in
                    isFirstTime ? add(loadingViewController) : remove(loadingViewController)
                }),
            
            postsTableView.rx
                .itemSelected
                .asDriver()
                .throttle(.seconds(1))
                .drive(postsTableView.rx.unHighlightAtIndexPathAfterSelection),
            
            postsTableView.rx.modelSelected(PostObject.self).subscribe(onNext: { [goToPostDetail] post in
                goToPostDetail?(post)
            })
        )
        
    }
    
}

