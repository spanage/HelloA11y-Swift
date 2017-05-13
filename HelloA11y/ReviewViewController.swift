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
    let rotorCategory: String
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
        
        setupRotors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRotors() {
        let categories = Set(items.map { $0.rotorCategory })
        let rotors = categories.map { category in
            UIAccessibilityCustomRotor(name: category, itemSearch: { (predicate) -> UIAccessibilityCustomRotorItemResult? in
                guard !self.items.isEmpty else { return nil }
                
                let forward = predicate.searchDirection == .next
                
                // figure out starting point
                var currentIndex = forward ? -1 : self.items.count
                if let cell = predicate.currentItem.targetElement as? UITableViewCell {
                    currentIndex = self.tableView.indexPath(for: cell)?.row ?? currentIndex
                }
                
                // helper for search
                func next(index: Int) -> Int { return forward ? index + 1 : index - 1 }
                
                var index = next(index: currentIndex)
                while index >= 0 && index < self.items.count {
                    if self.items[index].rotorCategory == category {
                        let indexPath = IndexPath(row: index, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
                        let cell = self.tableView.cellForRow(at: indexPath)!
                        return UIAccessibilityCustomRotorItemResult(targetElement: cell, targetRange: nil)
                    }
                    index = next(index: index)
                }
                return nil
            })
        }
        accessibilityCustomRotors = rotors
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
