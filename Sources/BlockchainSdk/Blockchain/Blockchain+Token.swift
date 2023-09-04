//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

@available(iOS 13.0, *)
extension Blockchain {
    /// Main structure blockchain Sdk
    public struct Token: TokenCurrencyDescription {
        // MARK: - Computed Properties
        
        public var id: String { item.rawValue }
        public var currencyType: CurrencyType { .token }
        public var contractAddress: String { item.contractAddress(for: blockchain) ?? "" }
        public var currencySymbol: String { item.currencySymbol }
        public var displayName: String { item.displayName }
        public var decimalCount: Int { blockchain.decimalCount }
        
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
        
        // MARK: - Implementation
        
        public func resolveAmountType() throws -> AmountType { amountType}
    }
}

public extension Blockchain.Token {
    enum Item: String, Codable, CaseIterable {
        /// Stablecoin Thether
        case USDT
        
        // MARK: - Implementation
        
        public var blockchains: [Blockchain] {
            switch self {
            case .USDT:
                return [.ethereum]
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
        
        public var isStablecoin: Bool {
            switch self {
            case .USDT:
                return true
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
