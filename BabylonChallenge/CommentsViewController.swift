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
    
    private lazy var commentsTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var disposeBag: DisposeBag?
    private let viewModel: CommentsViewModel
    init(viewModel: CommentsViewModel) {
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
        title = NSLocalizedString("Detail", comment: "title")
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setUpTableView()
        disposeBag = DisposeBag()
        bindToRx()
    }
    
    private func setUpTableView() {
        view.add(commentsTableView)
        commentsTableView.pin(to: self)
        commentsTableView.removeEmptyCells()
        commentsTableView.register(CommentTableViewCell.self)
    }
    
    private func bindToRx() {
        
        let input = CommentsViewModel.Input()
        let output = viewModel.transform(input)
        
        disposeBag?.insert (
            output.comments
                .drive(commentsTableView.rx.items(cellIdentifier: "CommentTableViewCell", cellType: CommentTableViewCell.self)) { row, comment, cell in
                    cell.configure(with: comment)
            }
            
        )
    }
    
}
