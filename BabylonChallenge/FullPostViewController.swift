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
    
    private lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.alwaysBounceVertical = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textAlignment = .left
        l.font = .boldSystemFont(ofSize: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var viewAuthorButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        b.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var viewCommentsButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let bodyLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, viewAuthorButton, bodyLabel, viewCommentsButton])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        if #available(iOS 11.0, *) {
            stackView.setCustomSpacing(10, after: viewAuthorButton)
        } else {
            // Fallback on earlier versions
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var didTapViewComments: ((Int) -> ())?
    public var didTapViewAuthor: ((Int) -> ())?
    
    private var disposeBag: DisposeBag?
    private let viewModel: FullPostViewModel
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
    
    private struct Constants {
        static let topPadding: CGFloat = 20
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
        static let bottomPadding: CGFloat = -20
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.add(scrollView)
        scrollView.pin(to: self)
        scrollView.add(containerStackView)
        
        disposeBag = DisposeBag()
        
        containerStackView.topAnchor.constraint(equalTo: topSafeArea, constant: Constants.topPadding).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingPadding).isActive = true

        let input = FullPostViewModel.Input()
        let output = viewModel.transform(input)
                
        disposeBag?.insert(
            
            output.authorName
                .bind(to: viewAuthorButton.rx.title()),
            
            output.postTitle
                .drive(titleLabel.rx.text),
            
            output.viewCommentsString
                .drive(viewCommentsButton.rx.title()),
            
            output.postBody
                .drive(bodyLabel.rx.text),
            
            viewCommentsButton.rx.tap.subscribe(onNext: { [viewModel, didTapViewComments] in
                didTapViewComments?(viewModel.post.value.id)
            }),
            
            viewAuthorButton.rx.tap.subscribe(onNext: { [viewModel, didTapViewAuthor] in
                didTapViewAuthor?(viewModel.post.value.userId)
            })
        
        )
        
        
    }

}
