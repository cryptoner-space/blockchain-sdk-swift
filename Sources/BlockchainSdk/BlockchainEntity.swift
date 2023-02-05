//
//  BlockchainEntity.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    @available(iOS 13.0, *)
    public struct BlockchainEntity: Codable {
        
        /// Token / Coin Enum structure
        let id: String
        
        /// Type of entity blockchain
        let type: BlockchainEntityType
        
        /// Parent network blockchain
        let blockchain: Blockchain
        
        /// Link for Icon token
        let iconUrl: String?
        
        /// Symbol of name token
        let symbol: String
        
        /// Name of token
        let name: String
        
        /// Description of token
        let description: String?
        
        /// Rank of global community
        let rank: Int
        
        /// External id of db or any usage
        let externalId: String?
        
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
