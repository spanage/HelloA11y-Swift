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
            spanishLabel.text = item.spanishText
            insetContainerView.backgroundColor = item.color
            
            let voiceoverString = NSMutableAttributedString(string: item.englishText)
            let spanishVoiceoverString = NSAttributedString(
                string: item.spanishText,
                attributes: [NSAttributedStringKey(rawValue: UIAccessibilitySpeechAttributeLanguage) : "es-ES"])
            voiceoverString.append(spanishVoiceoverString)
            accessibilityAttributedLabel = voiceoverString
        }
    }
    
    private let englishLabel = ReviewItemTableViewCell.label(with: .left)
    private let spanishLabel = ReviewItemTableViewCell.label(with: .right)
    private let insetContainerView = UIView()

    private static func label(with alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = alignment
        return label
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        isAccessibilityElement = true // we need to do this to get custom rotors to behave nicely
        
        insetContainerView.addSubview(englishLabel)
        insetContainerView.addSubview(spanishLabel)
        contentView.addSubview(insetContainerView)
        
        constrain(englishLabel, spanishLabel, insetContainerView) { english, spanish, parent in
            english.leading == parent.leading + 20
            spanish.trailing == parent.trailing - 20
            
            english.centerY == parent.centerY
            spanish.centerY == parent.centerY
        }
        
        constrain(insetContainerView, contentView) { container, parent in
            container.edges == inset(parent.edges, 20, 10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
