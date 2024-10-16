//
//  SplitInputView.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 16/10/2024.
//

import UIKit

class SplitInputView: UIView {
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .magenta
    }
}
