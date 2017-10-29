//
//  LessonViewController.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/5/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import Cartography

typealias DrawableLesson = Lesson & Drawable

class LessonViewController: UIViewController {
    struct Content {
        let lessons: [DrawableLesson]
    }
    
    private let content: Content
    private let shuffleOrder: [Int]
    
    private var currentLessonShuffleIndex: Int! {
        didSet {
            lessonView.lesson = currentLesson
        }
    }
    
    private var currentLesson: DrawableLesson {
        return content.lessons[shuffleOrder[currentLessonShuffleIndex]]
    }
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title1)
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
    
    let spanishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "spain_flag").withRenderingMode(.alwaysTemplate), for: .normal)
        button.accessibilityLabel = "Spanish Answer"
        button.accessibilityHint = "Shows the answer in Spanish"
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
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

    init(question: String, color: UIColor, content: Content) {
        self.content = content
        self.shuffleOrder = LessonViewController.shuffleOrder(for: content.lessons.count)
        self.color = color
        super.init(nibName: nil, bundle: nil)
        
        questionLabel.text = question
        currentLessonShuffleIndex = 0
        let firstLesson = content.lessons[shuffleOrder[currentLessonShuffleIndex]]
        lessonView = LessonView(lesson: firstLesson)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color
        
        englishButton.addTarget(self, action: #selector(didSelectEnglishButton), for: .touchUpInside)
        spanishButton.addTarget(self, action: #selector(didSelectSpanishButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didSelectNextButton), for: .touchUpInside)
        
        [englishButton, spanishButton].forEach(buttonStack.addArrangedSubview)
        [englishButton, spanishButton].forEach{ $0.tintColor = .white }
        [questionLabel, lessonView, buttonStack, nextButton].forEach(mainStack.addArrangedSubview)
        view.addSubview(mainStack)
        
        constrain(englishButton, spanishButton, lessonView) { english, spanish, lesson in
            english.width == 100
            english.height == 100
            
            spanish.size == english.size
            
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
    
    @objc private func didSelectSpanishButton() {
        let spanishVoiceoverString = NSAttributedString(
            string: currentLesson.spanish,
            attributes: [NSAttributedStringKey(rawValue: UIAccessibilitySpeechAttributeLanguage) : "es-ES"])
        let vc = AnswerViewController(color: color, text: currentLesson.spanish, textAccessibilityLabel: spanishVoiceoverString)
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didSelectNextButton() {
        let lessonCount = content.lessons.count
        let nextIndex = (currentLessonShuffleIndex + 1) % lessonCount
        currentLessonShuffleIndex = nextIndex
        if nextIndex == lessonCount - 1 {
            nextButton.setTitle("Start over!", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, questionLabel)
    }
}

private class LessonView: UIView {
    
    fileprivate var lesson: DrawableLesson {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(lesson: DrawableLesson) {
        self.lesson = lesson
        super.init(frame: .zero)
        
        isAccessibilityElement = false
        backgroundColor = .white
        
        defer {
            self.lesson = lesson
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        accessibilityElements = lesson.draw(in: self)
    }
}
