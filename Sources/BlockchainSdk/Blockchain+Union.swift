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
    public struct Union: Codable {
        
        // MARK: - Properties
        
        public var type: Blockchain.Currency
        public var blockchain: Blockchain
        public var value: String
        public var icon: String?
        public var symbol: String
        public var name: String
        public var description: String?
        public var rank: Int
        public var externalId: String?
        
        // MARK: - Init
        
        public init(
            type: Blockchain.Currency,
            blockchain: Blockchain,
            value: String,
            icon: String? = nil,
            symbol: String,
            name: String,
            description: String? = nil,
            rank: Int,
            externalId: String? = nil
        ) {
            self.type = type
            self.blockchain = blockchain
            self.value = value
            self.icon = icon
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
            self.externalId = externalId
        }
        
        // MARK: - Helpers
        
        /// Execute token value
        /// - Returns: Token value
        func token() throws -> Blockchain.Token {
            guard let value = Blockchain.Token.init(rawValue: self.value) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
        /// Execute coin value
        /// - Returns: Coin value
        func coin() throws -> Blockchain.Coin {
            guard let value = Blockchain.Coin.init(rawValue: self.value) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
    }
    
}
