//
//  MainViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/4/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let paper = Paper(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        paper.fill = "cccccc"
        let c = paper.circle(xCenter: 100, yCenter: 100, radius: 50)
        c.fill = "ff0000"
        c.stroke = c.fill
        
        view.addSubview(paper)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

