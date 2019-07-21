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

    // MARK: - UI
    private lazy var authorDetailTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let nameCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let usernameCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let emailCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let phoneNumberCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let websiteCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)
    private let companyCell: AuthorDetailTableViewCell = .init(style: .default, reuseIdentifier: nil)

    // MARK: - Properties (Private)
    private lazy var disposeBag = DisposeBag()

    private let viewModel: AuthorViewModel

    // MARK: - Init
    public init(viewModel: AuthorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        setUpTableView()
        disposeBag = DisposeBag()
        configureCells()

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
            case .name: return nameCell
            case .username: return usernameCell
            case .email: return emailCell
            case .phoneNumber: return phoneNumberCell
            }

        case .moreDetails:
            guard let row = AuthorDetailSection.ExtraRow(rawValue: indexPath.row) else { return .init() }
            switch row {
            case .website: return websiteCell
            case .company: return companyCell
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

private extension AuthorViewController {

    func setUpTableView() {
        view.add(authorDetailTableView)
        authorDetailTableView.pin(to: self)
        authorDetailTableView.removeEmptyCells()
        authorDetailTableView.register(AuthorDetailTableViewCell.self)
    }

    func configureCells() {

        let input = AuthorViewModel.Input()
        let output = viewModel.transform(input)

        disposeBag.insert(

            output.author.drive(onNext: { [nameCell, usernameCell, emailCell, phoneNumberCell, websiteCell, companyCell] author in
                nameCell.configure(topText: NSLocalizedString("name", comment: "title"), bottomText: author.name)

                usernameCell.configure(topText: NSLocalizedString("username", comment: "username"), bottomText: author.username)

                emailCell.configure(topText: NSLocalizedString("email", comment: "email"), bottomText: author.email)

                phoneNumberCell.configure(topText: NSLocalizedString("phone number", comment: "phone number"), bottomText: author.phone)

                websiteCell.configure(topText: NSLocalizedString("website", comment: "website"), bottomText: author.website)

                companyCell.configure(topText: NSLocalizedString("company", comment: "company"), bottomText: author.company?.bs)

            })

        )

    }

}
