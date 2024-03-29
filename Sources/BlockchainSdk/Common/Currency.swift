//
//  Currency.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public struct Currency: CurrencyDescription, CurrencyInfoDescription {
    
    // MARK: - CurrencyDescription
    
    public let id: String
    public let blockchain: Blockchain
    public let currencyType: CurrencyType
    public let decimalCount: Int
    public let contractAddress: String?
    
    public let currencySymbol: String
    public let currencySign: String?
    public let displayName: String
    
    public init(
        id: String,
        blockchain: Blockchain,
        currencyType: CurrencyType,
        decimalCount: Int,
        contractAddress: String? = nil,
        currencySymbol: String,
        currencySign: String?,
        displayName: String
    ) {
        self.id = id
        self.blockchain = blockchain
        self.currencyType = currencyType
        self.decimalCount = decimalCount
        self.contractAddress = contractAddress
        self.currencySymbol = currencySymbol
        self.currencySign = currencySign
        self.displayName = displayName
    }
    
    public init(_ model: any CurrencyDescription & CurrencyInfoDescription) {
        self.id = model.id
        self.blockchain = model.blockchain
        self.currencyType = model.currencyType
        self.decimalCount = model.decimalCount
        self.contractAddress = (model as? (any TokenCurrencyDescription))?.contractAddress
        self.currencySymbol = model.currencySymbol
        self.currencySign = model.currencySign
        self.displayName = model.displayName
    }
    
    public func resolveAmountType() throws -> AmountType {
        switch currencyType {
        case .coin:
            guard let coin = resolveCoin() else {
                throw CurrencyParseError.failedParseAmountType
            }
            
            return try coin.resolveAmountType()
        case .token:
            guard let token = resolveToken() else {
                throw CurrencyParseError.failedParseAmountType
            }
            
            return try token.resolveAmountType()
        case .custom:
            throw CurrencyParseError.failedParseAmountType
        }
    }
        
    public func resolveCoin() -> (any CoinCurrencyDescription)? {
        return Blockchain.Coin(
            id: id,
            currencySymbol: currencySymbol,
            displayName: displayName,
            decimalCount: decimalCount,
            currencySign: currencySign ?? "",
            blockchain: blockchain
        )
    }
    
    public func resolveToken() -> (any TokenCurrencyDescription)? {
        return Blockchain.Token(
            id: id,
            contractAddress: contractAddress ?? "",
            currencySymbol: currencySymbol,
            displayName: displayName,
            decimalCount: decimalCount,
            currencySign: currencySign ?? "",
            blockchain: blockchain
        )
    }
}

public enum CurrencyParseError: Error, LocalizedError {
    case failedParseValue
    case failedParseAmountType
}

extension Currency: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(blockchain)
        hasher.combine(currencyType.rawValue)
        
        if let contractAddress {
            hasher.combine(contractAddress)
        }
    }
}
