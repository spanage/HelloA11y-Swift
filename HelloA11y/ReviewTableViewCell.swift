//
//  ReviewTableViewCell.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/12/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

//
//  MainTableViewCell.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/4/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

final class ReviewTableViewCell: UITableViewCell {
    static let reuseID = "ReviewTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Review"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = AppColor.orange.uiColor
        
        contentView.addSubview(label)
        
        constrain(label, contentView) { label, parent in
            label.center == parent.center
        }
        
        constrain(contentView, self) { content, parent in
            content.edges == inset(parent.edges, 20, 0, 0, 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static let selectedAlpha: CGFloat = 0.6
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        contentView.alpha = selected ? ReviewTableViewCell.selectedAlpha : 1.0
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        contentView.alpha = highlighted ? ReviewTableViewCell.selectedAlpha : 1.0
    }
}
