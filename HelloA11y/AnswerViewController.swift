//
//  AnswerViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/5/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

final class AnswerViewController: UIViewController {
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Got it!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let color: UIColor
    
    init(color: UIColor, text: String) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
        
        answerLabel.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        
        doneButton.addTarget(self, action: #selector(didSelectDone), for: .touchUpInside)
        
        view.addSubview(answerLabel)
        view.addSubview(doneButton)
        constrain(answerLabel, doneButton, view) { label, done, parent in
            label.center == parent.center
            done.centerX == parent.centerX
            done.bottom == parent.bottom - 20
        }
    }
    
    @objc private func didSelectDone() {
        dismiss(animated: true, completion: nil)
    }
}