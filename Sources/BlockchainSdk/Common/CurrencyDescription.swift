//
//  CurrencyDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CurrencyDescription: Identifiable, Codable where ID == String {
    var blockchain:         Blockchain      { get }
    var currencyType:       CurrencyType    { get }
    var decimalCount:       Int             { get }
    
    func resolveAmountType() throws -> AmountType
}

public extension CurrencyDescription {
    var decimalValue: Decimal {
        return pow(Decimal(10), decimalCount)
    }
    
    func decimalRate(per value: Decimal) -> Decimal {
        value * Decimal(pow(10.0, -Double(decimalCount)))
    }
}
