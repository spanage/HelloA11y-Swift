//
//  ReviewItemCell.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/12/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

final class ReviewItemTableViewCell: UITableViewCell {
    static let reuseID = "ReviewItemTableViewCell"
    
    var item: ReviewItem! {
        didSet {
            englishLabel.text = item.englishText
            chineseLabel.text = item.chineseText
            contentView.backgroundColor = item.color
            accessibilityLabel = "\(item.englishText), \(item.chineseText)"
        }
    }
    
    private let englishLabel = ReviewItemTableViewCell.label(with: .left)
    private let chineseLabel = ReviewItemTableViewCell.label(with: .right)
    
    private static func label(with alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = alignment
        return label
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        isAccessibilityElement = true // we need to do this to get custom rotors to behave nicely
        
        contentView.addSubview(englishLabel)
        contentView.addSubview(chineseLabel)
        
        constrain(englishLabel, chineseLabel, contentView) { english, chinese, parent in
            english.leading == parent.leading + 20
            chinese.trailing == parent.trailing - 20
            
            english.centerY == parent.centerY
            chinese.centerY == parent.centerY
        }
        
        constrain(contentView, self) { content, parent in
            content.edges == inset(parent.edges, 10, 20, 10, 20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
