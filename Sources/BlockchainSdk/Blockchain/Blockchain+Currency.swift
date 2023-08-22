//
//  BlockchainEntity.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

// MARK: - Currency

extension Blockchain {
    public struct Currency: Codable {
        public let blockchain: Blockchain
        public let type: CurrencyType
        public let rawValue: String
        
        public init(blockchain: Blockchain, type: CurrencyType, rawValue: String) {
            self.blockchain = blockchain
            self.type = type
            self.rawValue = rawValue
        }
    }
}

extension Blockchain {
    public enum CurrencyType: String, Codable, CaseIterable {
        case coin, token, custom
    }
}
