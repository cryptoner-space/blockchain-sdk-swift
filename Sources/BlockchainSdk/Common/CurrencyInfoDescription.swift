//
//  CurrencyInfoDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CurrencyInfoDescription: Identifiable, Codable {
    var currencySymbol: String      { get }
    var currencySign: String?       { get }
    var displayName: String         { get }
    var decimalCount: Int           { get }
}

public extension CurrencyInfoDescription {
    var decimalValue: Decimal {
        return pow(Decimal(10), decimalCount)
    }
    
    func decimalRate(per value: Decimal) -> Decimal {
        value * Decimal(pow(10.0, -Double(decimalCount)))
    }
}
