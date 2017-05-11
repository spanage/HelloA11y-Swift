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
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        
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
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseID, for: indexPath) as! MainTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        let vc = LessonViewController(question: item.question, color: item.color, lessonContent: item.lessonContent) { lesson, rect in
            lesson.draw(in: rect)
        }
        vc.title = item.name
        navigationController?.pushViewController(vc, animated: true)
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
        case .numbers: return AppColor.red.uiColor
        case .colors: return AppColor.blue.uiColor
        case .shapes: return AppColor.green.uiColor
        }
    }
    
    var question: String {
        switch self {
        case .numbers: return "How many things are there?"
        case .colors: return "What color is the box?"
        case .shapes: return "What shape is this?"
        }
    }
    
    private typealias N = NumberLesson
    private typealias C = ColorLesson
    private typealias S = ShapeLesson
    var lessonContent: [Lesson] {
        switch self {
        case .numbers: return [N.one, N.two, N.three, N.four, N.five, N.six, N.seven, N.eight, N.nine, N.ten]
        case .colors: return [C.red, C.orange, C.yellow, C.green, C.blue, C.purple, C.black, C.white]
        case .shapes: return [S.square, S.circle, S.oval, S.rectangle, S.triangle]
        }
    }
}
