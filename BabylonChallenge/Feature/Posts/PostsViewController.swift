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

    // MARK: - UI
    private lazy var postsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    var goToFullPost: ((PostObject) -> Void)?

    // MARK: - Properties (Private)
    private lazy var disposeBag = DisposeBag()
    private lazy var refreshControl = RefreshControl(holder: postsTableView)
    private let viewModel: PostsViewModel

    // MARK: - Init
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Posts", comment: "title")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        definesPresentationContext = true

        refreshControl.startRefreshing()
        viewModel.requestPosts()

        setUpTableView()
        bindToRx()
    }

}

// MARK: - Methods
private extension PostsViewController {

    func setUpTableView() {
        view.addSubview(postsTableView)
        postsTableView.pin(to: self)
        postsTableView.removeEmptyCells()
        postsTableView.register(PostTableViewCell.self)
    }

    func bindToRx() {

        let input = PostsViewModel.Input(isRefreshing: refreshControl.isRefreshing.asObservable())
        let output = viewModel.transform(input)

        disposeBag.insert (

            output.posts
                .do(onNext: { [refreshControl] _ in refreshControl.endRefreshing() })
                .drive(postsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { _, post, cell in
                    cell.configure(with: post)
            },

            output.loadingState
                .drive(onNext: { [refreshControl, displayAlert] state in
                    switch state {
                    case .loading:
                        // do something interesting when loading
                        print("Loading")
                    case .loaded:
                        refreshControl.endRefreshing()
                    case .failed(title: let title, message: let message):
                        displayAlert(title, message) {
                            refreshControl.endRefreshing()
                        }
                    }
                }),

            postsTableView.rx
                .itemSelected
                .asDriver()
                .throttle(.seconds(1))
                .drive(postsTableView.rx.unHighlightAtIndexPathAfterSelection),

            postsTableView.rx.modelSelected(PostObject.self).subscribe(onNext: { [goToFullPost] post in
                goToFullPost?(post)
            })
        )

    }

}
