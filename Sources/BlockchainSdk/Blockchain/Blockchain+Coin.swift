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
        case btc
        
        /// Ethereum
        case eth
        
        /// Binance Beacon Chain
        case bnb
        
        /// Binance Smart Chain
        case bsc
        
        /// Ripple
        case xrp
        
        /// Dogecoin
        case doge
        
        /// Cardano
        case ada
        
        /// Solana
        case sol
        
        /// Tron
        case trx
        
        /// DOT
        case dot
        
        /// LTC
        case ltc
        
        /// Toncoin
        case ton
        
        /// Bitcoin Cash
        case bch
        
        /// Stellar
        case xlm
        
        /// Cosmos
        case atom
        
        /// Ethereum Classic
        case etc
        
        /// Arbitrum
        case arb
        
        /// Arbitrum Ethereum
        case arbOne
        
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
        self.rawValue.uppercased()
    }
    
    public var currencyType: CurrencyType {
        .coin
    }
    
    public var currencySymbol: String {
        switch self {
        case .arbOne:
            return Self.eth.rawValue.uppercased()
        default:
            return self.rawValue.uppercased()
        }
    }
    
    public var currencySign: String? {
        return nil
    }
    
    public var blockchain: Blockchain {
        switch self {
        case .btc:
            return .bitcoin
        case .bnb:
            return .binance
        case .bsc:
            return .binanceSmartChain
        case .eth:
            return .ethereum
        case .etc:
            return .ethereumClassic
        case .xrp:
            return .ripple
        case .doge:
            return .dogecoin
        case .ada:
            return .cardano
        case .sol:
            return .solana
        case .trx:
            return .tron
        case .dot:
            return .polkadot
        case .ltc:
            return .litecoin
        case .ton:
            return .toncoin
        case .bch:
            return .bitcoinCash
        case .xlm:
            return .stellar
        case .atom:
            return .cosmos
        case .arb:
            return .arbitrum
        case .arbOne:
            return .arbitrumOne
        }
    }
    
    public var displayName: String {
        "\(blockchain.displayName)"
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
