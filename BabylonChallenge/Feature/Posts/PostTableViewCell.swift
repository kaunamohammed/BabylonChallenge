//
//  PostTableViewCell.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let topPadding: CGFloat = 10
        static let bottomPadding: CGFloat = -5
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -10
    }
    
    private lazy var label: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.add(label)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        accessoryType = .disclosureIndicator
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        selectedBackgroundView = backgroundView
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: PostObject) {
        label.attributedText = AttributedStringBuilder()
            .append(post.title.capitalizeOnlyFirstCharacters(),
                    attributes: [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font: UIFont.font(size: 20, textStyle: .headline)])
            .append("\n", attributes: [:])
            .append(post.body.truncate(by: 60),
                    attributes: [.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), .font: UIFont.font(size: 15, textStyle: .subheadline)])
            .build()
    }
    
}

