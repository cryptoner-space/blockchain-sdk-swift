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
    public struct CoinUnion {
        
        /// Token Enum structure
        public let coin: Coin
        
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
        
        // MARK: - Init
        
        public init(coin: Coin, iconUrl: String?, symbol: String, name: String, description: String?, rank: Int) {
            self.coin = coin
            self.iconUrl = iconUrl
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
        }
        
    }

    
}
