//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

extension Blockchain {
    
    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public enum Token: String, Codable, CaseIterable {
        
        /// Undefined token
        case none
        
        /// Stablecoin Thether
        case USDT
        
        /// Stablecoin USD Coin
        case USDC
        
    }

    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public struct TokenUnion: Codable {
        
        // MARK: - Properties
        
        public var token: Token
        public var type: BlockchainEntityType
        public var blockchain: Blockchain
        public var iconUrl: String?
        public var symbol: String
        public var name: String
        public var description: String?
        public var rank: Int
        public var externalId: String?
        
        // MARK: - Init
        
        public init(
            token: Token,
            type: BlockchainEntityType,
            blockchain: Blockchain,
            iconUrl: String? = nil,
            symbol: String,
            name: String,
            description: String? = nil,
            rank: Int,
            externalId: String? = nil
        ) {
            self.token = token
            self.type = type
            self.blockchain = blockchain
            self.iconUrl = iconUrl
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
            self.externalId = externalId
        }
        
    }

    
}
