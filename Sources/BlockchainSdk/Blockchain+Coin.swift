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
        let coin: Coin
        
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
        
    }

    
}
