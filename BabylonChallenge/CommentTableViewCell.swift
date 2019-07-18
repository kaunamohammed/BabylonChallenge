//
//  CommentTableViewCell.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 17/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.add(nameLabel)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with comment: Comment) {
        
        nameLabel.attributedText = AttributedStringBuilder()
            .append(comment.name, attributes: [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .font: UIFont.preferredFont(forTextStyle: .subheadline)])
            .append("\n", attributes: [:])
            .append(comment.email, attributes: [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .font: UIFont.preferredFont(forTextStyle: .subheadline)])
            .append("\n\n", attributes: [:])
            .append(comment.body, attributes: [.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), .font: UIFont.preferredFont(forTextStyle: .headline)])
            .build()
        
    }
    
    private struct Constants {
        static let topPadding: CGFloat = 20
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
        static let bottomPadding: CGFloat = -10
    }
    
    private func setUpConstraints() {
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true

    }
    
}
