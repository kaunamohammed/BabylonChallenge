//
//  AuthorDetailTableViewCell.swift
//  BabylonChallenge
//
//  Created by Kauna Mohammed on 19/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import UIKit

public class AuthorDetailTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let topPadding: CGFloat = 10
        static let bottomPadding: CGFloat = -5
        static let leadingPadding: CGFloat = 20
        static let trailingPadding: CGFloat = -20
    }
    
    private let detailLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.add(detailLabel)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topPadding).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingPadding).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingPadding).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(topText: String? = nil, bottomText: String? = nil) {
        detailLabel.attributedText = AttributedStringBuilder()
            .append(topText.orEmpty, attributes: [.font: UIFont.italicSystemFont(ofSize: 10), .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
            .append("\n", attributes: [:])
            .append(bottomText.orEmpty, attributes: [.font: UIFont.preferredFont(forTextStyle: .headline), .foregroundColor: #colorLiteral(red: 0.06274509804, green: 0.05882352941, blue: 0.05882352941, alpha: 1)])
            .build()
        
    }
    
}

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        switch self {
        case .none:
            return ""
        case .some(let value):
            return value
        }
    }
    
}
