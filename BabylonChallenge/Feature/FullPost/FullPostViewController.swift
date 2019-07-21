//
//  FullPostViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 18/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FullPostViewController: UIViewController {
    
    // MARK: - UI 
    private lazy var relatedPostsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var headerView: FullPostHeaderView!
    
    // MARK: - Callbacks
    public var didTapViewComments: ((Int) -> ())?
    public var didTapViewAuthor: ((Int) -> ())?
    public var didTapToViewFullPost: ((PostObject) -> ())?
    
    // MARK: - Properties (Private)
    private var disposeBag: DisposeBag?
    private let viewModel: FullPostViewModel
    
    // MARK: - Init
    init(viewModel: FullPostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposeBag = nil
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setUpTableView()
        disposeBag = DisposeBag()
        
        bindToRx()
        
    }
    
}

// MARK: - Methods
extension FullPostViewController {
    
    private func setUpTableView() {
        view.add(relatedPostsTableView)
        relatedPostsTableView.pin(to: view)
        relatedPostsTableView.register(PostTableViewCell.self)
    }
    
    private func bindToRx() {
        
        let input = FullPostViewModel.Input()
        let output = viewModel.transform(input)
        
        setUpHeaderView(output)
        
        disposeBag?.insert(
            
            output.relatedComments
                .bind(to: relatedPostsTableView.rx.items(cellIdentifier: "PostTableViewCell", cellType: PostTableViewCell.self)) { row, post, cell in
                    cell.configure(with: post)
            },
            
            relatedPostsTableView.rx
                .itemSelected
                .asDriver()
                .throttle(.seconds(1))
                .drive(relatedPostsTableView.rx.unHighlightAtIndexPathAfterSelection),
            
            relatedPostsTableView.rx.modelSelected(PostObject.self).subscribe(onNext: { [didTapToViewFullPost] post in
                didTapToViewFullPost?(post)
            })
            
        )
        
    }
    
    private func setUpHeaderView(_ output: FullPostViewModel.Output) {
        headerView = FullPostHeaderView(author: output.authorName,
                                        numberOfComments: output.numberOfComments,
                                        title: output.postTitle,
                                        body: output.postBody)
        
        headerView.didTapViewComments = { [viewModel, didTapViewComments] in
            didTapViewComments?(viewModel.post.value.id)
        }
        
        headerView.didTapViewAuthor = { [viewModel, didTapViewAuthor] in
            didTapViewAuthor?(viewModel.post.value.userId)
        }
    }
}

// MARK: - UITableViewDelegate
extension FullPostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView ?? .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
