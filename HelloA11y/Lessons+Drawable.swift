//
//  Lessons+Drawable.swift
//  HelloA11y
//
//  Created by Sommer Panage on 10/20/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import UIKit

extension ShapeLesson: Drawable {
    private static let drawingDimension: CGFloat = 100
    func draw(in view: UIView) -> [UIAccessibilityElement] {
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
            accessibilityElement.accessibilityLabel = "Shape of one side of a die; four straight sides"
        case .rectangle:
            context?.fill(rectangle)
            accessibilityElement.accessibilityFrameInContainerSpace = rectangle
            accessibilityElement.accessibilityLabel = "Shape of an envelope; four straight sides and long"
        case .circle:
            context?.fillEllipse(in: shapeRect)
            accessibilityElement.accessibilityFrameInContainerSpace = shapeRect
            accessibilityElement.accessibilityLabel = "Shape of CD or a quarter; round"
        case .oval:
            context?.fillEllipse(in: rectangle)
            accessibilityElement.accessibilityFrameInContainerSpace = rectangle
            accessibilityElement.accessibilityLabel = "Shape of a drawing of a football or an egg; round and long"
        case .triangle:
            context?.beginPath()
            context?.move(to: CGPoint(x: shapeRect.minX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.maxX, y: shapeRect.maxY))
            context?.addLine(to: CGPoint(x: shapeRect.minX + (shapeRect.maxX - shapeRect.minX) / 2.0, y: shapeRect.minY))
            context?.closePath()
            context?.fillPath()
            accessibilityElement.accessibilityFrameInContainerSpace = shapeRect
            accessibilityElement.accessibilityLabel = "Shape of a tortilla chip or a yield sign; three straight sides"
        }
        
        return [accessibilityElement]
    }
}

extension ColorLesson: Drawable {
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
        case .red: return "The color of a stop sign"
        case .orange: return "The color of a tangerine"
        case .yellow: return "The color of a banana"
        case .green: return "The color of grass"
        case .blue: return "The color of the sky and ocean"
        case .purple: return "The color of eggplant"
        case .black: return "The color of night"
        case .white: return "The color of snow"
        }
    }
    
    private static let squareDimension: CGFloat = 100
    
    func draw(in view: UIView) -> [UIAccessibilityElement] {
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

extension NumberLesson: Drawable {
    
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
    
    func draw(in view: UIView) -> [UIAccessibilityElement] {
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
