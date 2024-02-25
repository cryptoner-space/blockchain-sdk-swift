//
//  Blockchain+TokenItem.swift
//
//
//  Created by skibinalexander on 25.02.2024.
//

import Foundation

public extension Blockchain.Token {
    enum Stablecoin: String, Codable, CaseIterable {
        /// Stablecoin Thether
        case USDT
        
        // MARK: - Implementation
        
        public var blockchains: [Blockchain] {
            switch self {
            case .USDT:
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
            }
        }
        
        public func contractAddress(for blockchain: Blockchain) -> String? {
            switch self {
            case .USDT where blockchain == .ethereum:
                return "0xdAC17F958D2ee523a2206206994597C13D831ec7"
            case .USDT where blockchain == .tron:
                return "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t"
            default:
                return nil
            }
        }
        
        public func decimalCount(for blockchain: Blockchain) -> Int {
            switch self {
            case .USDT where blockchain == .ethereum:
                return 6
            case .USDT where blockchain == .tron:
                return 6
            default:
                return blockchain.decimalCount
            }
        }
    }
}
