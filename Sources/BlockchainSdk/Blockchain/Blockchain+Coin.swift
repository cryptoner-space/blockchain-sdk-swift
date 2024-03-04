//
//  Blockchain+Coin.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    public struct Coin: CoinCurrencyDescription {
        // MARK: - Public Properties
        
        public let id: String
        public let currencySymbol: String
        public let displayName: String
        public let decimalCount: Int
        public let currencySign: String?
        
        public var currencyType: CurrencyType { .coin }
        
        // MARK: - Input Properties
        
        public let blockchain: Blockchain
        
        // MARK: - Init
        
        public init(
            id: String,
            contractAddress: String? = nil,
            currencySymbol: String,
            displayName: String,
            decimalCount: Int,
            currencySign: String,
            blockchain: Blockchain
        ) {
            self.id = id
            self.currencySymbol = currencySymbol
            self.displayName = displayName
            self.decimalCount = decimalCount
            self.currencySign = currencySign
            self.blockchain = blockchain
        }
        
        public init(
            coinType: CoinType,
            blockchain: Blockchain
        ) {
            self.id = coinType.rawValue
            self.currencySymbol = coinType.currencySymbol
            self.displayName = coinType.displayName ?? blockchain.displayName
            self.decimalCount = blockchain.decimalCount
            self.currencySign = coinType.currencySign
            self.blockchain = blockchain
        }
        
        // MARK: - Resolving
        
        public func resolveCurrency() throws -> Currency {
            Currency(self)
        }
        
        public func resolveAmountType() throws -> AmountType {
            amountType
        }
    }
}

extension Blockchain {
    public enum CoinType: String, Codable, CaseIterable {
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
        
        // Computed Properties
        
        public var currencySymbol: String {
            return self.rawValue.uppercased()
        }
        
        public var currencySign: String? {
            return nil
        }
        
        public var displayName: String? {
            return nil
        }
        
        public var blockchains: [Blockchain] {
            switch self {
            case .eth:
                return [.ethereum, .arbitrumOne]
            case .trx:
                return [.tron]
            case .ton:
                return [.toncoin]
            default:
                return []
            }
        }
    }
}
