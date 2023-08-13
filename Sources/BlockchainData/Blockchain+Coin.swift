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
        
        /// Binance
        case BNB
        
        /// Ripple
        case XRP
        
        /// Dogecoin
        case DOGE
        
        /// Cardano
        case ADA
        
        /// Solana
        case SOL
        
        /// Tron
        case TRX
        
        /// DOT
        case DOT
        
        /// LTC
        case LTC
        
        /// Toncoin
        case TON
        
        /// Bitcoin Cash
        case BCH
        
        /// Stellar
        case XLM
        
        /// Cosmos
        case ATOM
        
        /// Ethereum Classic
        case ETC
        
        // MARK: - Helper
        
        public var blockchain: Blockchain {
            switch self {
            case .BTC:
                return .bitcoin
            case .BNB:
                return .binance
            case .ETH:
                return .ethereum
            case .XRP:
                return .ripple
            case .DOGE:
                return .bitcoin
            case .ADA:
                return .cardano
            case .SOL:
                return .solana
            case .TRX:
                return .tron
            case .DOT:
                return .polkadot
            case .LTC:
                return .bitcoin
            case .TON:
                return .toncoin
            case .BCH:
                return .bitcoin
            case .XLM:
                return .stellar
            case .ATOM:
                return .cosmos
            case .ETC:
                return .ethereum
            }
        }
        
        public var displayName: String {
            switch self {
            default:
                var name = "\(self)".capitalizingFirstLetter()
            
                if let index = name.firstIndex(of: "(") {
                    name = String(name.prefix(upTo: index))
                }
            
                return name
            }
        }
        
        public var currencySymbol: String {
            self.rawValue.uppercased()
        }
    }

    
}

extension Blockchain.Coin {
    
    public enum CoinError: Error {
        case undefined
    }
    
}
