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
}

extension FloatingPoint {
    /// Returns a random value of `Self` inside of the closed range.
    public static func random(within closedRange: ClosedRange<Self>) -> Self {
        let multiplier = closedRange.upperBound - closedRange.lowerBound
        return closedRange.lowerBound + multiplier * (Self(arc4random_uniform(UInt32.max)) / Self(UInt32.max))
    }
}
