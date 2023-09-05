//
//  Currency.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public struct Currency: Codable, DecimalValueDescription {
    public let id: String
    public let blockchain: Blockchain
    public let currencyType: CurrencyType
    public let decimalCount: Int
    public let contractAddress: String?
    
    public init(
        id: String,
        blockchain: Blockchain,
        currencyType: CurrencyType,
        decimalCount: Int,
        contractAddress: String? = nil
    ) {
        self.id = id
        self.blockchain = blockchain
        self.currencyType = currencyType
        self.decimalCount = decimalCount
        self.contractAddress = contractAddress
    }
    
    public init(_ model: any CurrencyDescription) {
        self.id = model.id
        self.blockchain = model.blockchain
        self.currencyType = model.currencyType
        self.decimalCount = model.decimalCount
        self.contractAddress = (model as? (any TokenCurrencyDescription))?.contractAddress
    }
}

public enum CurrencyParseError: Error, LocalizedError {
    case parseValue
    case parseAmountType
}
