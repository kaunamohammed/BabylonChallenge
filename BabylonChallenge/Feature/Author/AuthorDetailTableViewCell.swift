//
//  AuthorDetailTableViewCell.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

public class AuthorDetailTableViewCell: UITableViewCell {

    // MARK: - UI
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.add(detailLabel)
        setUpConstraints()

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(topText: String? = nil, bottomText: String? = nil) {
        detailLabel.attributedText = AttributedStringBuilder()
            .append(topText.orEmpty, attributes: [.font: UIFont.font(size: 10, textStyle: .caption1), .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)])
            .append("\n", attributes: [:])
            .append(bottomText.orEmpty, attributes: [.font: UIFont.preferredFont(forTextStyle: .headline), .foregroundColor: #colorLiteral(red: 0.06274509804, green: 0.05882352941, blue: 0.05882352941, alpha: 1)])
            .build()

    }

}

// MARK: - Constraints
extension AuthorDetailTableViewCell {

    private struct Constants {
        static let topPadding: CGFloat = 10
        static let bottomPadding: CGFloat = -5
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
    }

    func setUpConstraints() {

        detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        detailLabel.translatesAutoresizingMaskIntoConstraints = false

    }

}
