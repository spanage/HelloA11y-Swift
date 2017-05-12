//
//  MainTableViewCell.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/4/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

final class MainTableViewCell: UITableViewCell {
    static let reuseID = "MainTableViewCell"
    
    var item: MainItem! {
        didSet {
            label.text = item.name
            iconImage.image = item.image.withRenderingMode(.alwaysTemplate)
            containerView.backgroundColor = item.color
        }
    }
    
    private let containerView = UIView()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let iconImage: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var containerSelected: Bool = false {
        didSet {
            containerView.layer.borderColor = containerSelected ? AppColor.orange.uiColor.cgColor : nil
            containerView.layer.borderWidth = containerSelected ? 10 : 0
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        [label, iconImage].forEach { containerView.addSubview($0) }
        contentView.addSubview(containerView)
        
        constrain(label, iconImage, containerView) { label, icon, parent in
            label.top == parent.top + 20
            label.leading == parent.leading
            label.trailing == parent.trailing
            
            icon.height == 160
            icon.width == 160
            icon.center == parent.center
        }
        
        constrain(containerView, contentView) { container, parent in
            container.edges == inset(parent.edges, 20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        containerSelected = selected
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        containerSelected = highlighted
    }
}

