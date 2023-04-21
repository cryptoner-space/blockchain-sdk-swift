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
        
        // MARK: - Init
        
        public init(_ blockchain: Blockchain) throws {
            switch blockchain {
            case .bitcoin:
                self = .BTC
            case .ethereum:
                self = .ETH
            case .toncoin:
                self = .TON
            case .solana:
                self = .SOL
            case .tron:
                self = .TRX
            case .ripple:
                self = .XRP
            case .binance:
                self = .BNB
            case .undefined:
                throw CoinError.undefined
            }
        }
        
        // MARK: - Helper
        
        public var blockchain: Blockchain {
            switch self {
            case .BTC:
                return .bitcoin
            case .ETH:
                return .ethereum
            case .TON:
                return .toncoin
            case .SOL:
                return .solana
            case .TRX:
                return .tron
            case .XRP:
                return .ripple
            case .BNB:
                return .binance
            }
        }
        
    }

    
}

extension Blockchain.Coin {
    
    public enum CoinError: Error {
        case undefined
    }
    
}
