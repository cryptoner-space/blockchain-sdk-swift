//
//  AmountCurrency.swift
//  
//
//  Created by skibinalexander on 04.09.2023.
//

import Foundation

public struct AmountCurrency: Codable, Identifiable {
    public var id: String {
        currency.id
    }
    
    public let currency: Currency
    public let amount: String
    
    public init(currency: Currency, amount: String) {
        self.currency = currency
        self.amount = amount
    }
    
    public func parseAmountType(from currencies: [any CurrencyDescription]) throws -> AmountType {
        guard let currencyDescription = currencies.first(where: { $0.id == currency.id }) else {
            throw CurrencyParseError.failedParseAmountType
        }
        
        return try currencyDescription.resolveAmountType()
    }
    
    /// Execute amount value for currency model
    /// - Parameter devide: Devider flag conversion for compensate value decimal count
    /// - Returns: Amount value
    public func value(with amountType: AmountType, devide: Bool = false) throws -> Amount {
        guard let parseValue = Decimal(string: amount) else {
            throw CurrencyParseError.failedParseValue
        }
        
        let value = devide ? parseValue / currency.decimalValue : parseValue
        
        return Amount(type: amountType, value: value)
    }
}
