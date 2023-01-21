//
//  BlockchainToken.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

/// Main structure blockchain Sdk
@available(iOS 13.0, *)
public enum BlockchainToken: String, Codable {
    
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
public struct BlockchainTokenUnion {
    
    /// Token Enum structure
    let token: BlockchainToken
    
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
