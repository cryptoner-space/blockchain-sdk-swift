//
//  Blockchain+Coin.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public enum Coin: String, Codable, CaseIterable {
        
        /// Undefined coin
        case none
        
        /// Bitcoin
        case BTC
        
        /// Ethereum
        case ETH
        
        /// Toncoin
        case TON
        
        /// Solana
        case SOL
        
        /// Tron
        case TRX
        
        /// Ripple
        case XRP
        
        /// Binance
        case BNB
        
    }

    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public struct CoinUnion: Codable {
        
        // MARK: - Properties
        
        public var coin: Coin
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
            coin: Coin,
            type: BlockchainEntityType,
            blockchain: Blockchain,
            iconUrl: String? = nil,
            symbol: String,
            name: String,
            description: String? = nil,
            rank: Int,
            externalId: String? = nil
        ) {
            self.coin = coin
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
