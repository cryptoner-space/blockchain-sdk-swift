//
//  Blockchain+TokenItem.swift
//
//
//  Created by skibinalexander on 25.02.2024.
//

import Foundation

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
