//
//  AmountCurrency.swift
//  
//
//  Created by skibinalexander on 04.09.2023.
//

import Foundation

public struct AmountCurrency: Codable {
    let currency: Currency
    let amount: String
    
    public init(currency: Currency, amount: String) {
        self.currency = currency
        self.amount = amount
    }
    
    /// Execute amount value for currency model
    /// - Parameter devide: Devider flag conversion for compensate value decimal count
    /// - Returns: Amount value
    public func value(devide: Bool = false) throws -> Amount {
        guard let parseValue = Decimal(string: amount) else {
            throw CurrencyParseError.parseValue
        }
        
        guard let amountType = try? currency.resolveAmountType() else {
            throw CurrencyParseError.parseValue
        }
        
        let value = devide ? parseValue / currency.decimalValue : parseValue
        
        return Amount(type: amountType, value: value)
    }
}
