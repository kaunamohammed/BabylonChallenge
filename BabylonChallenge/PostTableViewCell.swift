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
        accessoryType = .disclosureIndicator
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        
        label.attributedText = AttributedStringBuilder()
            .append(post.title, attributes: [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font: UIFont.preferredFont(forTextStyle: .headline)])
            .append("\n", attributes: [:])
            .append(post.body.truncate(by: 100), attributes: [.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), .font: UIFont.italicSystemFont(ofSize: 15)])
            .build()
        
    }

}

