//
//  Currency.swift
//  
//
//  Created by skibinalexander on 27.08.2023.
//

import Foundation

public struct Currency: Codable {
    public let blockchain: Blockchain
    public let currencyType: CurrencyType
    public let rawValue: String
    
    public init(
        blockchain: Blockchain,
        currencyType: CurrencyType,
        rawValue: String
    ) {
        self.blockchain = blockchain
        self.currencyType = currencyType
        self.rawValue = rawValue
    }
    
    // MARK: - Helpers
    
    public var coin: Blockchain.Coin? {
        guard
            currencyType == .coin,
            let coin = Blockchain.Coin(rawValue: rawValue.uppercased()),
            coin.blockchain == blockchain
        else {
            return nil
        }
        
        return coin
    }
    
    public var token: Blockchain.Token? {
        guard
            currencyType == .coin,
            let token = Blockchain.Token(rawValue: rawValue.uppercased()),
            token.blockchains.contains(blockchain)
        else {
            return nil
        }
        
        return token
    }
    
}

public enum CurrencyType: String, Codable, CaseIterable {
    case coin, token, custom
}

// MARK: - Factory

public extension Currency {
    static func make() -> [Currency] {
        let coins: [Currency] = Blockchain.Factory.coins().map {
            return .init(
                blockchain: $0.blockchain,
                currencyType: .coin,
                rawValue: $0.rawValue.uppercased()
            )
        }
        
        let tokens: [[Currency]] = Blockchain.Factory.tokens().map { token in
            let tokens = token.blockchains.compactMap { blockchain -> Currency? in
                guard token.blockchains.contains(blockchain) else {
                    return nil
                }
                
                return Currency(
                    blockchain: blockchain,
                    currencyType: .token,
                    rawValue: token.rawValue.uppercased()
                )
            }
            
            return tokens
        }
        
        return coins + Array(tokens.joined())
    }
}
