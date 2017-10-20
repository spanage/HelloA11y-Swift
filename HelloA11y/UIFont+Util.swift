//
//  UIFont+Util.swift
//  HelloA11y
//
//  Created by Sommer Panage on 10/20/17.
//  Copyright © 2017 Sommer Panage. All rights reserved.
//

import UIKit

extension UIFont {
    var bold: UIFont {
        return withWeight(.bold)
    }
    
    var heavy: UIFont {
        return withWeight(.heavy)
    }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        typealias TraitDict = [UIFontDescriptor.TraitKey : Any]
        
        var traits = fontDescriptor.fontAttributes[.traits] as? TraitDict ?? TraitDict()
        traits[.weight] = weight
        
        var newAttributes = fontDescriptor.fontAttributes
        newAttributes[.traits] = traits
        
        let newDescriptor = UIFontDescriptor(fontAttributes: newAttributes)
        return UIFont(descriptor: newDescriptor, size: fontDescriptor.pointSize)
    }
}
