//
//  ReviewViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/12/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

struct ReviewItem {
    let englishText: String
    let chineseText: String
    let color: UIColor
}

final class ReviewViewController: UIViewController {
    
    fileprivate let items: [ReviewItem]
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.rowHeight = 100
        return view
    }()
    
    init(items: [ReviewItem]) {
        self.items = items.sorted { itemA, itemB in
            itemA.englishText < itemB.englishText
        }
        super.init(nibName: nil, bundle: nil)
        
        title = "Review"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewItemTableViewCell.self, forCellReuseIdentifier: ReviewItemTableViewCell.reuseID)
        
        view.addSubview(tableView)
        constrain(tableView, view) { table, parent in
            table.edges == parent.edges
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewItemTableViewCell.reuseID, for: indexPath) as! ReviewItemTableViewCell
        cell.item = items[indexPath.row]

        return cell
    }
}
