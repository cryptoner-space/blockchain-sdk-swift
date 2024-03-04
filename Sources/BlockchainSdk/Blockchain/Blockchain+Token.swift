//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

extension Blockchain {
    public struct Token: TokenCurrencyDescription {
        // MARK: - Public Properties
        
        public let id: String
        public let contractAddress: String
        public let currencySymbol: String
        public let displayName: String
        public let decimalCount: Int
        public let currencySign: String?
        
        public var currencyType: CurrencyType { .token }
        
        // MARK: - Input Properties
        
        public let blockchain: Blockchain
        
        // MARK: - Init
        
        public init(
            id: String,
            contractAddress: String,
            currencySymbol: String,
            displayName: String,
            decimalCount: Int,
            currencySign: String,
            blockchain: Blockchain
        ) {
            self.id = id
            self.contractAddress = contractAddress
            self.currencySymbol = currencySymbol
            self.displayName = displayName
            self.decimalCount = decimalCount
            self.currencySign = currencySign
            self.blockchain = blockchain
        }
        
        public init(
            stablecoin: Stablecoin,
            currencySign: String? = nil,
            blockchain: Blockchain
        ) {
            self.id = stablecoin.rawValue
            self.contractAddress = stablecoin.contractAddress(for: blockchain) ?? ""
            self.currencySymbol = stablecoin.currencySymbol
            self.displayName = stablecoin.displayName
            self.decimalCount = stablecoin.decimalCount(for: blockchain)
            self.currencySign = currencySign
            self.blockchain = blockchain
        }
        
        // MARK: - Resolving
        
        public func resolveCurrency() throws -> Currency {
            Currency(self)
        }
        
        public func resolveAmountType() throws -> AmountType {
            amountType
        }
    }
}

extension Blockchain.Token {
    public var stablecoin: Stablecoin? {
        return .init(rawValue: id)
    }
}
