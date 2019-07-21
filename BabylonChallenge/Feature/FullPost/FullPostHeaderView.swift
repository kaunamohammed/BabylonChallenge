//
//  FullPostHeaderView.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 20/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FullPostHeaderView: UIView {
    
    // MARK: - UI
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        l.textAlignment = .left
        l.font = .font(size: 20, textStyle: .title1)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var viewAuthorButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(#colorLiteral(red: 0.5647058824, green: 0.07058823529, blue: 0.9960784314, alpha: 1), for: .normal)
        b.titleLabel?.font = .font(size: 15, textStyle: .subheadline)
        b.addTarget(self, action: #selector(didTapViewAuthorButton), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var viewCommentsButton: UIButton = {
        let b = UIButton()
        b.setTitleColor(#colorLiteral(red: 0.5647058824, green: 0.07058823529, blue: 0.9960784314, alpha: 1), for: .normal)
        b.titleLabel?.font = .font(size: 15, textStyle: .subheadline)
        b.addTarget(self, action: #selector(didTapViewCommentsButton), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let bodyLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        l.textAlignment = .left
        l.font = .font(size: 18, textStyle: .body)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let relatedPostsLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.text = "Related Posts"
        l.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        l.textAlignment = .left
        l.font = .font(size: 20, textStyle: .title1)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel, viewAuthorButton, viewCommentsButton, relatedPostsLabel])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.setCustomSpacing(10, after: viewAuthorButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Callbacks
    public var didTapViewComments: (() -> ())?
    public var didTapViewAuthor: (() -> ())?
    
    // MARK: - Properties (Private)
    private var disposeBag: DisposeBag?
    
    private let author: Driver<String>
    private let numberOfComments: Driver<String>
    private let title: Driver<String>
    private let body: Driver<String>
    
    // MARK: - Init
    init(author: Driver<String>, numberOfComments: Driver<String>, title: Driver<String>, body: Driver<String>) {
        self.author = author
        self.numberOfComments = numberOfComments
        self.title = title
        self.body = body
        super.init(frame: .zero)
        
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addSubview(containerStackView)
        setUpConstraints()
        disposeBag = DisposeBag()
        bindToRx()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Methods
private extension FullPostHeaderView {
    
    func bindToRx() {
        
        disposeBag?.insert(
            author
                .drive(viewAuthorButton.rx.title()),
            title
                .drive(titleLabel.rx.text),
            numberOfComments
                .drive(viewCommentsButton.rx.title()),
            body
                .drive(bodyLabel.rx.text)
        )
        
    }
    
}

// MARK: - Target/Action
private extension FullPostHeaderView {
    @objc func didTapViewAuthorButton() {
        didTapViewAuthor?()
    }
    
    @objc func didTapViewCommentsButton() {
        didTapViewComments?()
    }
}

// MARK: - Constraints
private extension FullPostHeaderView {
    
    struct Constants {
        static let topPadding: CGFloat = 20
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
    }
    
    func setUpConstraints() {
        containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topPadding).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingPadding).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingPadding).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
}
