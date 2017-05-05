//
//  MainViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/4/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

final class MainViewController: UIViewController {
    
    fileprivate let items = MainItem.all
    
    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        constrain(tableView, view) { table, parent in
            table.edges == parent.edges
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainTableViewCell()
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width
    }
}

enum MainItem {
    case numbers
    case colors
    case shapes
    
    static let all: [MainItem] = [.numbers, .colors, .shapes]
    
    var name: String {
        switch self {
        case .numbers: return "Learn Numbers"
        case .colors: return "Learn Colors"
        case .shapes: return "Learn Shapes"
        }
    }
    
    var image: UIImage {
        switch self {
        case .numbers: return #imageLiteral(resourceName: "calculator")
        case .colors: return #imageLiteral(resourceName: "rainbow")
        case .shapes: return #imageLiteral(resourceName: "shapes")
        }
    }
    
    var color: UIColor {
        switch self {
        case .numbers: return .cyan
        case .colors: return .magenta
        case .shapes: return .orange
        }
    }
    
    var selectionColor: UIColor {
        switch self {
        case .numbers: return .orange
        case .colors: return .cyan
        case .shapes: return .magenta
        }
    }
}

