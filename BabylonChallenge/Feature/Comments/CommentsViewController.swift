//
//  CommentsViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 16/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CommentsViewController: UIViewController {

    // MARK: UI
    private lazy var commentsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        table.allowsSelection = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Properties (Private)
    private lazy var disposeBag = DisposeBag()
    private let viewModel: CommentsViewModel

    // MARK: - Init
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Comments", comment: "title")
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        setUpTableView()
        bindToRx()
    }

}

private extension CommentsViewController {

    func setUpTableView() {
        view.add(commentsTableView)
        commentsTableView.pin(to: self)
        commentsTableView.removeEmptyCells()
        commentsTableView.register(CommentTableViewCell.self)
    }

    func bindToRx() {

        let input = CommentsViewModel.Input()
        let output = viewModel.transform(input)

        disposeBag.insert (
            output.comments
                .drive(commentsTableView.rx.items(cellIdentifier: "CommentTableViewCell", cellType: CommentTableViewCell.self)) { _, comment, cell in
                    cell.configure(with: comment)
            }

        )
    }

}
