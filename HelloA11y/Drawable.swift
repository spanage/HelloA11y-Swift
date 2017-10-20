//
//  Drawable.swift
//  HelloA11y
//
//  Created by Sommer Panage on 10/20/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import UIKit

protocol Drawable {
    func draw(in view: UIView) -> [UIAccessibilityElement]
}
