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
        backgroundView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
        
        setUpAttributes(for: label, post: post)
        
    }

}


extension PostTableViewCell {
    
    func setUpAttributes(for label: UILabel, post: PostObject) {
        let headlineFont = UIFont(name: "OpenSans", size: 20)!
        let subheadlineFont = UIFont(name: "OpenSans", size: 15)!
        if #available(iOS 11.0, *) {
            let headlineFontMetrics = UIFontMetrics(forTextStyle: .headline)
            let subheadlineFontMetrics = UIFontMetrics(forTextStyle: .subheadline)
            label.attributedText = AttributedStringBuilder()
                .append(post.title.capitalizeOnlyFirstCharacters(),
                        attributes: [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font: headlineFontMetrics.scaledFont(for: headlineFont)])
                .append("\n", attributes: [:])
                .append(post.body.truncate(by: 60),
                        attributes: [.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), .font: subheadlineFontMetrics.scaledFont(for: subheadlineFont)])
                .build()
            
        } else {
            label.attributedText = AttributedStringBuilder()
                .append(post.title.capitalizeOnlyFirstCharacters(),
                        attributes: [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font: headlineFont])
                .append("\n", attributes: [:])
                .append(post.body.truncate(by: 60),
                        attributes: [.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), .font: subheadlineFont])
                .build()
        }
    }
    
}
