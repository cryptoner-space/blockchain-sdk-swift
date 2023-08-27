//
//  Currency+Amount.swift
//  
//
//  Created by skibinalexander on 27.08.2023.
//

import Foundation

public struct CurrencyAmount: Codable {
    // MARK: - Properties
    
    public let currency: Currency
    public let amount: String
    
    // MARK: - Init
    
    public init(
        currency: Currency,
        amount: String
    ) {
        self.currency = currency
        self.amount = amount
    }
    
    // MARK: - Helpers
    
    /// Execute amount value for currency model
    /// - Parameter devide: Devider flag conversion for compensate value decimal count
    /// - Returns: Amount value
    public func value(devide: Bool = false) throws -> Amount {
        guard let parseValue = Decimal(string: amount) else {
            throw ValueError.parseValue
        }
        
        guard let amountType = AmountType(currency) else {
            throw ValueError.parseAmountType
        }
        
        let value = devide ? parseValue / currency.blockchain.decimalValue : parseValue
        
        return Amount(type: amountType, value: value)
    }
}

public extension CurrencyAmount {
    enum ValueError: Error, LocalizedError {
        case parseValue
        case parseAmountType
    }
}
