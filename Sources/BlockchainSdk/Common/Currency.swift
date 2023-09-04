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
    public let decimalCount: Int
    
    public init(
        id: String,
        blockchain: Blockchain,
        currencyType: CurrencyType,
        decimalCount: Int
    ) {
        self.id = id
        self.blockchain = blockchain
        self.currencyType = currencyType
        self.decimalCount = decimalCount
    }
    
    public init(_ model: any CurrencyDescription) {
        self.id = model.id
        self.blockchain = model.blockchain
        self.currencyType = model.currencyType
        self.decimalCount = model.decimalCount
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

public enum CurrencyParseError: Error, LocalizedError {
    case parseValue
    case parseAmountType
}
