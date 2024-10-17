//
//  UIView+Extensions.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 17/10/2024.
//

import UIKit

extension UIView {
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor ?? UIColor.clear.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addCornerRadius(_ radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}
