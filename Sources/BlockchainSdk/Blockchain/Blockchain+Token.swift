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
        
        public let id: String
        public let contractAddress: String
        public let currencySymbol: String
        public let displayName: String
        public let decimalCount: Int
        public let currencySign: String?
        
        public var currencyType: CurrencyType { .token }
        
        public var tokenItem: Item? {
            return .init(rawValue: id)
        }
        
        // MARK: - Input Properties
        
        public let blockchain: Blockchain
        
        // MARK: - Init
        
        public init(
            id: String,
            contractAddress: String,
            currencySymbol: String,
            displayName: String,
            decimalCount: Int,
            currencySign: String,
            blockchain: Blockchain
        ) {
            self.id = id
            self.contractAddress = contractAddress
            self.currencySymbol = currencySymbol
            self.displayName = displayName
            self.decimalCount = decimalCount
            self.currencySign = currencySign
            self.blockchain = blockchain
        }
        
        public init(
            item: Token.Item,
            currencySign: String? = nil,
            blockchain: Blockchain
        ) {
            self.id = item.rawValue
            self.contractAddress = item.contractAddress(for: blockchain) ?? ""
            self.currencySymbol = item.currencySymbol
            self.displayName = item.displayName
            self.decimalCount = item.decimalCount(for: blockchain)
            self.currencySign = currencySign
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
        
        public func decimalCount(for blockchain: Blockchain) -> Int {
            switch self {
            case .USDT where blockchain == .ethereum:
                return 6
            default:
                return blockchain.decimalCount
            }
        }
    }
}
