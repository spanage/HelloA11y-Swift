//
//  Color.swift
//  HelloA11y
//
//  Created by Sommer Panage on 5/5/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import UIKit

enum AppColor {
    case red
    case blue
    case green
    case orange
    
    var uiColor: UIColor {
        switch self {
        case .red: return UIColor.rgb(hex: 0xf03a47, alpha: 1)
        case .blue: return UIColor.rgb(hex: 0x5f5aa2, alpha: 1)
        case .green: return UIColor.rgb(hex: 0x0f7173, alpha: 1)
        case .orange: return UIColor.rgb(hex: 0xef8354, alpha: 1)
        }
    }

}

extension UIColor {
    static func rgb(hex: Int, alpha: CGFloat) -> UIColor {
        let color =  UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: CGFloat(alpha)
        )
        return color
    }
}
