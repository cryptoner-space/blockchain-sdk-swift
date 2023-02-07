//
//  BlockchainEntity.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    // MARK: - EntityType
    
    public enum EntityType: String, Codable, CaseIterable {
        case coin, token, custom
    }
    
    // MARK: - Factory
    
    /// Make entity data Coin or Token
    /// - Parameters:
    ///   - rawValue: Raw value coin or token
    ///   - blockchain: Blockchain network for rawValue
    ///   - type: Type of Entity
    /// - Returns: Entity model
    static func makeEntity(
        rawValue: String,
        blockchain: Blockchain,
        type: EntityType
    ) throws -> Entity {
        switch type {
        case .coin:
            return try self.makeCoin(rawValue: rawValue, blockchain: blockchain)
        case .token:
            return try self.makeToken(rawValue: rawValue, blockchain: blockchain)
        default:
            throw Blockchain.EntityError.errorMaking
        }
    }
    
    static func makeCoin(
        rawValue: String,
        blockchain: Blockchain
    ) throws -> Entity {
        throw Blockchain.EntityError.errorMaking
    }
    
    static func makeToken(
        rawValue: String,
        blockchain: Blockchain
    ) throws -> Entity {
        throw Blockchain.EntityError.errorMaking
    }
    
    // MARK: - Entity
    
    @available(iOS 13.0, *)
    public struct Entity: Codable {
        
        /// Token / Coin Enum structure
        public let id: String
        
        /// Type of entity blockchain
        public let type: BlockchainEntityType
        
        /// Parent network blockchain
        public let blockchain: Blockchain
        
        /// Link for Icon token
        public let iconUrl: String?
        
        /// Symbol of name token
        public let symbol: String
        
        /// Name of token
        public let name: String
        
        /// Description of token
        public let description: String?
        
        /// Rank of global community
        public let rank: Int
        
        /// External id of db or any usage
        public let externalId: String?
        
        // MARK: - Init
        
        public init(
            id: String,
            type: BlockchainEntityType,
            blockchain: Blockchain,
            iconUrl: String?,
            symbol: String,
            name: String,
            description: String?,
            rank: Int,
            externalId: String?
        ) {
            self.id = id
            self.type = type
            self.blockchain = blockchain
            self.iconUrl = iconUrl
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
            self.externalId = externalId
        }
        
        public init(_ token: Blockchain.TokenUnion) {
            self.id = token.token.rawValue
            self.type = .token
            self.blockchain = token.blockchain
            self.iconUrl = token.iconUrl
            self.symbol = token.symbol
            self.name = token.name
            self.description = token.description
            self.rank = token.rank
            self.externalId = token.externalId
        }
        
        public init(_ coin: Blockchain.CoinUnion) {
            self.id = coin.coin.rawValue
            self.type = .coin
            self.blockchain = coin.blockchain
            self.iconUrl = coin.iconUrl
            self.symbol = coin.symbol
            self.name = coin.name
            self.description = coin.description
            self.rank = coin.rank
            self.externalId = coin.externalId
        }
        
        // MARK: - Helper
        
        /// Execute token value
        /// - Returns: Token value
        func executeToken() throws -> Blockchain.Token {
            guard let value = Blockchain.Token.init(rawValue: self.id) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
        /// Execute coin value
        /// - Returns: Coin value
        func executeCoin() throws -> Blockchain.Coin {
            guard let value = Blockchain.Coin.init(rawValue: self.id) else {
                throw Blockchain.EntityError.errorExecution
            }
            
            return value
        }
        
    }
    
}
