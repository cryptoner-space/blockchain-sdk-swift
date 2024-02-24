//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

extension Blockchain {
    /// Main structure blockchain Sdk
    public struct Token: TokenCurrencyDescription {
        // MARK: - Computed Properties
        
        public let id: String
        public let contractAddress: String
        public let currencySymbol: String
        public let displayName: String
        public let decimalCount: Int
        public let currencySign: String?
        
        public var currencyType: CurrencyType { .token }
        
        public var tokenItem: Item? {
            return .init(rawValue: id)
        }
        
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
            item: Token.Item,
            currencySign: String? = nil,
            blockchain: Blockchain
        ) {
            self.id = item.rawValue
            self.contractAddress = item.contractAddress(for: blockchain) ?? ""
            self.currencySymbol = item.currencySymbol
            self.displayName = item.displayName
            self.decimalCount = item.decimalCount(for: blockchain)
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
