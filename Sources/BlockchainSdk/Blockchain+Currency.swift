//
//  BlockchainEntity.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    // MARK: - Currency
    
    public enum Currency: String, Codable, CaseIterable {
        case coin, token, custom
    }
    
    // Relation
    
    public struct Relation {
        
        /// Fetch cryptocurrency amount for identy value
        /// - Parameters:
        ///   - crypto: Cryprocurrency model
        ///   - value: Value amount cryptocurrency
        /// - Returns: Amount model
        public static func cryptoAmount(crypto: Blockchain.Union, value: Decimal) throws -> Amount {
            try crypto.amount(value: value)
        }
        
        /// Fetch fiat amoune cost cryptocurrency value
        /// - Parameters:
        ///   - crypto: Cryptocurrency model
        ///   - fiat: Fiat model
        ///   - rate: Rate cost per 1 crypto for fiat
        ///   - value: Value amount cryptocurrency
        /// - Returns: Amount model
        public static func fiatAmount(crypto: Blockchain.Union, for fiat: Fiat, with rate: Decimal, value: Decimal) throws -> Amount {
            let cryptoValue = try crypto.amount(value: value)
            let fiatRateValue = cryptoValue.value * rate
            return try fiat.amount(value: max(fiatRateValue, 0.01).rounded(scale: 2, roundingMode: .plain))
        }
        
    }
    
}
