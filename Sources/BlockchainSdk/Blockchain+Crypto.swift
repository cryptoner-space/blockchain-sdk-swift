//
//  Blockchain+Union.swift
//  
//
//  Created by skibinalexander on 21.04.2023.
//

import Foundation

extension Blockchain {
    
    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public struct Crypto: Codable {
        
        // MARK: - Properties
        
        public var type: CurrencyType
        public var blockchain: Blockchain
        public var value: String
        public var iconUrl: String?
        public var symbol: String
        public var name: String
        public var description: String?
        public var rank: Int
        public var externalId: String?
        
        // MARK: - Init
        
        public init(
            type: CurrencyType,
            blockchain: Blockchain,
            value: String,
            iconUrl: String? = nil,
            symbol: String,
            name: String,
            description: String? = nil,
            rank: Int,
            externalId: String? = nil
        ) {
            self.type = type
            self.blockchain = blockchain
            self.value = value
            self.iconUrl = iconUrl
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
            self.externalId = externalId
        }
        
        // MARK: - Helpers
        
        /// Execute token value
        /// - Returns: Token value
        public func token() throws -> Blockchain.Token {
            guard let value = Blockchain.Token.init(rawValue: self.value) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
        /// Execute coin value
        /// - Returns: Coin value
        public func coin() throws -> Blockchain.Coin {
            guard let value = Blockchain.Coin.init(rawValue: self.value) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
        public func amount(value: Decimal) throws -> Amount {
            switch type {
            case .coin:
                return try .init(type: .coin(self.coin()), value: value)
            case .token:
                return try .init(type: .token(self.token(), blockchain), value: value)
            default:
                throw Blockchain.EntityError.errorAmount
            }
        }
        
    }
    
}
