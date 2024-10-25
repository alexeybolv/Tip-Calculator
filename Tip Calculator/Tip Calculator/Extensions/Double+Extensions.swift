//
//  Double+Extensions.swift
//  Tip Calculator
//
//  Created by Alexey Bolvonovich on 19/10/2024.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return (formatter.string(for: self) ?? "").replacingOccurrences(of: " ", with: "")
    }
}
