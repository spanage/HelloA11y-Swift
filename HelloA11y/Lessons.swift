//
//  Lessons.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/5/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import CoreGraphics
import UIKit

protocol Lesson {
    var english: String { get }
    var chinese: String { get }
    func draw(in rect: CGRect)
}

enum ShapeLesson: String, Lesson {
    case circle = "circle"
    case oval = "oval"
    case square = "square"
    case rectangle = "rectangle"
    case triangle = "triangle"
    
    var english: String {
        return self.rawValue
    }
    
    var chinese: String {
        switch self {
        case .circle: return "一"
        case .oval: return "二"
        case .square: return "三"
        case .rectangle: return "四"
        case .triangle: return "五"
        }
    }
    
    private static let drawingDimension: CGFloat = 100
    func draw(in rect: CGRect) {
        let d = ShapeLesson.drawingDimension
        let context = UIGraphicsGetCurrentContext()
        let color = AppColor.orange.uiColor
        context?.setFillColor(color.cgColor)
        
        let x = (rect.width - d) / 2.0 + rect.minX
        let y = (rect.height - d) / 2.0 + rect.minY
        let shapeRect = CGRect(x: x, y: y, width: d, height: d)
        
        // Used for rectangle and oval
        let rectHeight = shapeRect.height / 2.0
        let rectangle = CGRect(x: shapeRect.origin.x,
                               y: shapeRect.origin.x + rectHeight / 2.0,
                               width: shapeRect.width,
                               height: rectHeight)
        
        switch self {
        case .square:
            context?.fill(shapeRect)
        case .rectangle:
            context?.fill(rectangle)
        case .circle:
            context?.fillEllipse(in: shapeRect)
        case .oval:
            context?.fillEllipse(in: rectangle)
        case .triangle:
            context?.beginPath()
            context?.move(to: CGPoint(x: shapeRect.minX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.maxX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.minX + (shapeRect.maxX - shapeRect.minX) / 2.0, y: shapeRect.minY))
            context?.closePath()
            context?.fillPath()
        }
    }
}

enum ColorLesson: String, Lesson {
    case red = "red"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case blue = "blue"
    case purple = "purple"
    case black = "black"
    case white = "white"
    
    var english: String {
        return self.rawValue
    }
    
    var chinese: String {
        switch self {
        case .red: return "一"
        case .orange: return "二"
        case .yellow: return "三"
        case .green: return "四"
        case .blue: return "五"
        case .purple: return "六"
        case .black: return "七"
        case .white: return "八"
        }
    }
    
    private var uiColor: UIColor {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .purple: return .purple
        case .black: return .black
        case .white: return .white
        }
    }
    
    
    private static let squareDimension: CGFloat = 100
    func draw(in rect: CGRect) {
        let d = ColorLesson.squareDimension
        let context = UIGraphicsGetCurrentContext()
        let color = self.uiColor
        context?.setFillColor(color.cgColor)
        context?.setStrokeColor(UIColor.gray.cgColor)
        context?.setLineWidth(2.0)
        let x = (rect.width - d) / 2.0 + rect.minX
        let y = (rect.height - d) / 2.0 + rect.minY
        let colorRect = CGRect(x: x, y: y, width: d, height: d)
        context?.fill(colorRect)
        context?.stroke(colorRect)
    }
}

enum NumberLesson: Int, Lesson {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    
    var english: String {
        switch self {
        case .one: return "one"
        case .two: return "two"
        case .three: return "three"
        case .four: return "four"
        case .five: return "five"
        case .six: return "six"
        case .seven: return "seven"
        case .eight: return "eight"
        case .nine: return "nine"
        case .ten: return "ten"
        }
    }
    
    var chinese: String {
        switch self {
        case .one: return "一"
        case .two: return "二"
        case .three: return "三"
        case .four: return "四"
        case .five: return "五"
        case .six: return "六"
        case .seven: return "七"
        case .eight: return "八"
        case .nine: return "九"
        case .ten: return "十"
        }
    }
    
    private static let radius: CGFloat = 20
    private static let colors: [UIColor] = [AppColor.red.uiColor, AppColor.green.uiColor, AppColor.blue.uiColor]
    func draw(in rect: CGRect) {
        let r = NumberLesson.radius
        let colors = NumberLesson.colors
        let numberOfDots = self.rawValue
        let minX = rect.origin.x
        let maxX = rect.maxX - 2 * r
        let minY = rect.origin.y
        let maxY = rect.maxY - 2 * r
        for i in 1...numberOfDots {
            let context = UIGraphicsGetCurrentContext()
            let color = colors[i % colors.count].withAlphaComponent(0.6)
            context?.setFillColor(color.cgColor)
            context?.fillEllipse(in: CGRect(x: CGFloat.random(within: minX...maxX),
                                            y: CGFloat.random(within: minY...maxY),
                                            width: 2 * r,
                                            height: 2 * r))
        }
    }
}

extension FloatingPoint {
    /// Returns a random value of `Self` inside of the closed range.
    public static func random(within closedRange: ClosedRange<Self>) -> Self {
        let multiplier = closedRange.upperBound - closedRange.lowerBound
        return closedRange.lowerBound + multiplier * (Self(arc4random_uniform(UInt32.max)) / Self(UInt32.max))
    }
}
