//
//  CommentTableViewCell.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 17/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    // MARK: - UI
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.add(commentLabel)
        setUpConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with comment: CommentObject) {
        commentLabel.attributedText = AttributedStringBuilder()
            .append(comment.body, attributes: [.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), .font: UIFont.font(size: 15, textStyle: .body)])
            .append("\n\n", attributes: [:])
            .append(comment.name, attributes: [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font: UIFont.font(size: 15, textStyle: .caption1)])
            .build()
    }

}

private extension CommentTableViewCell {

    struct Constants {
        static let topPadding: CGFloat = 20
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
        static let bottomPadding: CGFloat = -10
    }

    func setUpConstraints() {

        commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true

    }

}
