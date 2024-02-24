//
//  Blockchain+Coin.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    /// Main structure blockchain Sdk
    public enum Coin: String, Codable, CaseIterable {
        /// Bitcoin
        case BTC
        
        /// Ethereum
        case ETH
        
        /// Binance Beacon Chain
        case BNB
        
        /// Binance Smart Chain
        case BSC
        
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
        
        /// Arbitrum
        case ARB
        
        /// Arbitrum Ethereum
        case ARB_ETH
        
        // MARK: - Init
        
        public init?(blockchain: Blockchain) {
            guard let value = Self.allCases.first(where: { $0.blockchain == blockchain }) else {
                return nil
            }
            
            self = value
        }
    }
}

// MARK: - CoinCurrencyDescription

extension Blockchain.Coin: CoinCurrencyDescription {
    
    public typealias ID = String
    
    public var id: String {
        self.rawValue
    }
    
    public var currencyType: CurrencyType {
        .coin
    }
    
    public var currencySymbol: String {
        switch self {
        case .ARB_ETH:
            return Self.ETH.rawValue
        default:
            return self.rawValue.uppercased()
        }
    }
    
    public var currencySign: String? {
        return nil
    }
    
    public var blockchain: Blockchain {
        switch self {
        case .BTC:
            return .bitcoin
        case .BNB:
            return .binance
        case .BSC:
            return .binanceSmartChain
        case .ETH:
            return .ethereum
        case .ETC:
            return .ethereumClassic
        case .XRP:
            return .ripple
        case .DOGE:
            return .dogecoin
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
            return .bitcoinCash
        case .XLM:
            return .stellar
        case .ATOM:
            return .cosmos
        case .ARB:
            return .arbitrum
        case .ARB_ETH:
            return .arbitrum
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
    
    public var decimalCount: Int {
        blockchain.decimalCount
    }
    
    public var contractAddress: String? {
        nil
    }
    
    public func resolveCurrency() throws -> Currency {
        Currency(self)
    }
    
    public func resolveAmountType() throws -> AmountType {
        amountType
    }
    
}
