//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

extension Blockchain {
    /// Main structure blockchain Sdk
    public struct Token: TokenCurrencyDescription {
        // MARK: - Computed Properties
        
        public var id: String { item.rawValue }
        public var currencyType: CurrencyType { .token }
        public var contractAddress: String { item.contractAddress(for: blockchain) ?? "" }
        public var currencySymbol: String { item.currencySymbol }
        public var displayName: String { item.displayName }
        
        public var decimalCount: Int {
            switch item {
            case .USDT where blockchain == .ethereum:
                return 6
            default:
                return blockchain.decimalCount
            }
        }
        
        // MARK: - Input Properties
        
        public let item: Token.Item
        public let blockchain: Blockchain
        
        public var currencySign: String?
        
        // MARK: - Init
        
        public init(item: Token.Item, blockchain: Blockchain, currencySign: String? = nil) {
            self.item = item
            self.blockchain = blockchain
            self.currencySign = currencySign
        }
        
        public func resolveAmountType() throws -> AmountType {
            amountType
        }
    }
}

public extension Blockchain.Token {
    enum Item: String, Codable, CaseIterable {
        /// Stablecoin Thether
        case USDT
        
        /// BNB Token
        case BNB
        
        /// USD Coin
        case USDC
        
        /// TRON Token
        case TRON
        
        /// Token Wrapped TON Coin
        case TONCOIN
        
        // MARK: - Implementation
        
        public var blockchains: [Blockchain] {
            switch self {
            case .USDT, .BNB, .USDC:
                return [.ethereum, .tron]
            case .TRON, .TONCOIN:
                return [.ethereum, .tron]
            }
        }
        
        public var currencySymbol: String {
            return self.rawValue.uppercased()
        }
        
        public var displayName: String {
            switch self {
            case .USDT:
                return "Tether USD"
            default:
                return ""
            }
        }
        
        public var isStablecoin: Bool {
            switch self {
            case .USDT, .USDC:
                return true
            default:
                return false
            }
        }
        
        public func contractAddress(for blockchain: Blockchain) -> String? {
            switch self {
            case .USDT where blockchain == .ethereum:
                return "0xdAC17F958D2ee523a2206206994597C13D831ec7"
            default:
                return nil
            }
        }
    }
}
