//
//  LessonViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/5/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

class LessonViewController: UIViewController {
    
    let lessonContent: [Lesson]
    private let shuffleOrder: [Int]
    
    private var currentLessonShuffleIndex: Int! {
        didSet {
            lessonView.lesson = currentLesson
        }
    }
    
    private var currentLesson: Lesson {
        return lessonContent[shuffleOrder[currentLessonShuffleIndex]]
    }
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "union_jack").withRenderingMode(.alwaysTemplate), for: .normal)
        button.accessibilityLabel = "English Answer"
        button.accessibilityHint = "Shows the answer in English"
        return button
    }()
    
    let chineseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "china_flag").withRenderingMode(.alwaysTemplate), for: .normal)
        button.accessibilityLabel = "Chinese Answer"
        button.accessibilityHint = "Shows the answer in Chinese"
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let buttonStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.spacing = 40
        return view
    }()
    
    let mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    private var lessonView: LessonView!
    
    private let color: UIColor

    init(question: String, color: UIColor, lessonContent: [Lesson], drawAccessiblyForLesson: @escaping (Lesson, UIView) -> [UIAccessibilityElement]) {
        self.lessonContent = lessonContent
        self.shuffleOrder = LessonViewController.shuffleOrder(for: lessonContent.count)
        self.color = color
        super.init(nibName: nil, bundle: nil)
        
        questionLabel.text = question
        currentLessonShuffleIndex = 0
        let firstLesson = lessonContent[shuffleOrder[currentLessonShuffleIndex]]
        lessonView = LessonView(lesson: firstLesson, drawAccessiblyForLesson: drawAccessiblyForLesson)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        
        englishButton.addTarget(self, action: #selector(didSelectEnglishButton), for: .touchUpInside)
        chineseButton.addTarget(self, action: #selector(didSelectChineseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didSelectNextButton), for: .touchUpInside)
        
        [englishButton, chineseButton].forEach(buttonStack.addArrangedSubview)
        [englishButton, chineseButton].forEach{ $0.tintColor = .white }
        [questionLabel, lessonView, buttonStack, nextButton].forEach(mainStack.addArrangedSubview)
        view.addSubview(mainStack)
        
        constrain(englishButton, chineseButton, lessonView) { english, chinese, lesson in
            english.width == 100
            english.height == 100
            
            chinese.size == english.size
            
            lesson.width == 300
            lesson.height == 300
        }
        
        constrain(mainStack, view) { main, parent in
            main.top == topLayoutGuideCartography + 20
            main.leading >= parent.leading + 20
            main.trailing <= parent.trailing - 20
            main.centerX == parent.centerX
        }
    }
    
    private static func shuffleOrder(for count: Int) -> [Int]
    {
        var shuffledLessons: [Int] = []
        for _ in 0..<count {
            var index: Int!
            repeat {
               index = Int(arc4random_uniform(UInt32(count)))
            } while shuffledLessons.contains(index)
            shuffledLessons.append(index)
        }
        return shuffledLessons
    }
    
    @objc private func didSelectEnglishButton() {
        let vc = AnswerViewController(color: color, text: currentLesson.english)
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didSelectChineseButton() {
        let vc = AnswerViewController(color: color, text: currentLesson.chinese)
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didSelectNextButton() {
        let nextIndex = (currentLessonShuffleIndex + 1) % lessonContent.count
        currentLessonShuffleIndex = nextIndex
        if nextIndex == lessonContent.count - 1 {
            nextButton.setTitle("Start over!", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, questionLabel)
    }
}

private class LessonView: UIView {
    
    private let drawAccessiblyForLesson: (Lesson, UIView) -> [UIAccessibilityElement]
    fileprivate var lesson: Lesson {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(lesson: Lesson, drawAccessiblyForLesson: @escaping (Lesson, UIView) -> [UIAccessibilityElement]) {
        self.lesson = lesson
        self.drawAccessiblyForLesson = drawAccessiblyForLesson
        super.init(frame: .zero)
        
        isAccessibilityElement = false
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let a11yElements = drawAccessiblyForLesson(lesson, self)
        accessibilityElements = a11yElements
    }
}
