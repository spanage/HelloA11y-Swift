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
    var spanish: String { get }
    func drawAccessibly(in view: UIView) -> [UIAccessibilityElement]
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
    
    var spanish: String {
        switch self {
        case .circle: return "el círculo"
        case .oval: return "el óvalo"
        case .square: return "el cuadrado"
        case .rectangle: return "el rectángulo"
        case .triangle: return "el triángulo"
        }
    }
    
    private static let drawingDimension: CGFloat = 100
    func drawAccessibly(in view: UIView) -> [UIAccessibilityElement] {
        let rect = view.bounds
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
        
        let accessibilityElement = UIAccessibilityElement(accessibilityContainer: view)
        
        switch self {
        case .square:
            context?.fill(shapeRect)
            accessibilityElement.accessibilityFrameInContainerSpace = shapeRect
            accessibilityElement.accessibilityLabel = "Shape of one side of a die, four sides"
        case .rectangle:
            context?.fill(rectangle)
            accessibilityElement.accessibilityFrameInContainerSpace = rectangle
            accessibilityElement.accessibilityLabel = "Shape of a sheet of standard printer paper, four sides"
        case .circle:
            context?.fillEllipse(in: shapeRect)
            accessibilityElement.accessibilityFrameInContainerSpace = shapeRect
            accessibilityElement.accessibilityLabel = "Shape of a CD or a quarter, round"
        case .oval:
            context?.fillEllipse(in: rectangle)
            accessibilityElement.accessibilityFrameInContainerSpace = rectangle
            accessibilityElement.accessibilityLabel = "Shape of an egg, round and elongated"
        case .triangle:
            context?.beginPath()
            context?.move(to: CGPoint(x: shapeRect.minX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.maxX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.minX + (shapeRect.maxX - shapeRect.minX) / 2.0, y: shapeRect.minY))
            context?.closePath()
            context?.fillPath()
            accessibilityElement.accessibilityFrameInContainerSpace = shapeRect
            accessibilityElement.accessibilityLabel = "Shape of a yield sign, three sides"
        }
        
        return [accessibilityElement]
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
    
    var spanish: String {
        switch self {
        case .red: return "rojo"
        case .orange: return "anaranjado"
        case .yellow: return "amarillo"
        case .green: return "verde"
        case .blue: return "azul"
        case .purple: return "morado"
        case .black: return "negro"
        case .white: return "blanco"
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
    
    private var accessibilityDescription: String {
        switch self {
        case .red: return "Box, the color of a stop sign"
        case .orange: return "Box, the color of a tangerine"
        case .yellow: return "Box, the color of a banana"
        case .green: return "Box, the color of grass"
        case .blue: return "Box, the color of the sky and ocean"
        case .purple: return "Box, the color of eggplant"
        case .black: return "Box, the color of night"
        case .white: return "Box, the color of snow"
        }
    }
    
    private static let squareDimension: CGFloat = 100
    func drawAccessibly(in view: UIView) -> [UIAccessibilityElement] {
        let rect = view.bounds
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
        
        let element = UIAccessibilityElement(accessibilityContainer: view)
        element.accessibilityFrameInContainerSpace = colorRect
        element.accessibilityLabel = accessibilityDescription
        return [element]
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
    
    var spanish: String {
        switch self {
        case .one: return "uno"
        case .two: return "dos"
        case .three: return "tres"
        case .four: return "cuatro"
        case .five: return "cinco"
        case .six: return "seis"
        case .seven: return "siete"
        case .eight: return "ocho"
        case .nine: return "nueve"
        case .ten: return "diez"
        }
    }
    
    private static let radius: CGFloat = 20
    
    private enum CircleColor: String {
        case red = "red"
        case green = "green"
        case blue = "blue"
        
        var accessibilityLabel: String {
            return rawValue + " circle"
        }
        
        var uiColor: UIColor {
            switch self {
            case .red: return AppColor.red.uiColor
            case .green: return AppColor.green.uiColor
            case .blue: return AppColor.blue.uiColor
            }
        }
        
        static let all: [CircleColor] = [.red, .green, .blue]
    }
    
    func drawAccessibly(in view: UIView) -> [UIAccessibilityElement] {
        let rect = view.bounds
        let r = NumberLesson.radius
        let colors = CircleColor.all
        let numberOfDots = self.rawValue
        let minX = rect.origin.x
        let maxX = rect.maxX - 2 * r
        let minY = rect.origin.y
        let maxY = rect.maxY - 2 * r
        
        var accessibilityElements: [UIAccessibilityElement] = []
        
        for i in 1...numberOfDots {
            let context = UIGraphicsGetCurrentContext()
            let color = colors[i % colors.count]
            let cgColor = color.uiColor.withAlphaComponent(0.6).cgColor
            context?.setFillColor(cgColor)
            let frame = CGRect(x: CGFloat.random(within: minX...maxX),
                               y: CGFloat.random(within: minY...maxY),
                               width: 2 * r,
                               height: 2 * r)
            context?.fillEllipse(in: frame)
            
            let element = UIAccessibilityElement(accessibilityContainer: view)
            element.accessibilityLabel = color.accessibilityLabel
            element.accessibilityFrameInContainerSpace = frame
            accessibilityElements.append(element)
        }
        
        return accessibilityElements.sorted { elemA, elemB in
            let originA = elemA.accessibilityFrameInContainerSpace.origin
            let originB = elemB.accessibilityFrameInContainerSpace.origin
            if originA.y == originB.y {
                return originA.x < originB.x
            } else {
                return originA.y < originB.y
            }
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
