//
//  Currency.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public struct Currency: CurrencyDescription {
    public let id: String
    public let blockchain: Blockchain
    public let currencyType: CurrencyType
    
    public init(id: String, blockchain: Blockchain, currencyType: CurrencyType) {
        self.id = id
        self.blockchain = blockchain
        self.currencyType = currencyType
    }
    
    public init(_ model: any CurrencyDescription) {
        self.id = model.id
        self.blockchain = model.blockchain
        self.currencyType = model.currencyType
    }
    
    public func resolveAmountType() throws -> AmountType {
        switch currencyType {
        case .coin:
            guard let description = self as? (any CoinCurrencyDescription) else {
                throw CurrencyParseError.parseAmountType
            }
            
            return description.amountType
        case .token:
            guard let description = self as? (any TokenCurrencyDescription) else {
                throw CurrencyParseError.parseAmountType
            }
            
            return description.amountType
        default:
            throw CurrencyParseError.parseAmountType
        }
    }
}

public struct CurrencyAmount: Codable {
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
        
        let value = devide ? parseValue / currency.blockchain.decimalValue : parseValue
        
        return Amount(type: amountType, value: value)
    }
}

public enum CurrencyParseError: Error, LocalizedError {
    case parseValue
    case parseAmountType
}
