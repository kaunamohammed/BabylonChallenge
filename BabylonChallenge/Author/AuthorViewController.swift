//
//  AuthorViewController.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit
import RxSwift

class AuthorViewController: UIViewController {
    
    private lazy var authorDetailTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let authorNameCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let authorUsernameCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let authorEmailCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let authorPhoneNumberCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let authorWebsiteCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let authorCompanyCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    
    private var disposeBag:  DisposeBag?
    
    private let viewModel: AuthorViewModel
    public init(viewModel: AuthorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setUpTableView()
        disposeBag = DisposeBag()
        
        configureCells()
        
    }
    
    private func setUpTableView() {
        view.add(authorDetailTableView)
        authorDetailTableView.pin(to: self)
        authorDetailTableView.removeEmptyCells()
        authorDetailTableView.register(AuthorDetailTableViewCell.self)
    }
    
    func configureCells() {
        
        let input = AuthorViewModel.Input()
        let output = viewModel.transform(input)
        
        disposeBag?.insert(
            
            output.author.subscribe(onNext: { [authorNameCell, authorUsernameCell, authorEmailCell, authorPhoneNumberCell, authorWebsiteCell, authorCompanyCell] author in
                authorNameCell.configure(topText: NSLocalizedString("name", comment: "title"), bottomText: author.name)
                
                authorUsernameCell.configure(topText: NSLocalizedString("username", comment: "username"), bottomText: author.username)
                
                authorEmailCell.configure(topText: NSLocalizedString("email", comment: "email"), bottomText: author.email)
                
                authorPhoneNumberCell.configure(topText: NSLocalizedString("phone number", comment: "phone number"), bottomText: author.phone)
                
                authorWebsiteCell.configure(topText: NSLocalizedString("website", comment: "website"), bottomText: author.website)
                
                authorCompanyCell.configure(topText: NSLocalizedString("company", comment: "company"), bottomText: author.company?.bs)
            })
            
        )
        
    }
    
    
}

// MARK: - UITableViewDataSource
extension AuthorViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return AuthorDetailSection.numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = AuthorDetailSection(rawValue: section) else { return 0 }
        return sec.numberOfRowsInSections
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = AuthorDetailSection(rawValue: indexPath.section) else { return .init() }
        
        switch section {
            
        case .contactInfo:
            guard let row = AuthorDetailSection.DetailRow(rawValue: indexPath.row) else { return .init() }
            switch row {
            case .name: return authorNameCell
            case .username: return authorUsernameCell
            case .email: return authorEmailCell
            case .phoneNumber: return authorPhoneNumberCell
            }
            
        case .moreDetails:
            guard let row = AuthorDetailSection.ExtraRow(rawValue: indexPath.row) else { return .init() }
            switch row {
            case .website: return authorWebsiteCell
            case .company: return authorCompanyCell
            }
            
        }
    }
}

// MARK: - AuthorViewController
extension AuthorViewController {
    private enum AuthorDetailSection: Int, CaseIterable {
        case contactInfo
        case moreDetails
        
        static var numberOfSections: Int { return AuthorDetailSection.allCases.count }
        
        var numberOfRowsInSections: Int {
            switch self {
            case .contactInfo: return 4
            case .moreDetails: return 2
            }
        }
        
        enum DetailRow: Int {
            case name
            case username
            case email
            case phoneNumber
        }
        
        enum ExtraRow: Int {
            case website
            case company
        }
        
    }
}
