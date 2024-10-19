//
//  UIResponder+Extensions.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 19/10/2024.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
