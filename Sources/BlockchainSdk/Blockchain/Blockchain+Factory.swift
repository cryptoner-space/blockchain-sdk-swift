//
//  Blockchain+Factory.swift
//  
//
//  Created by skibinalexander on 13.08.2023.
//

import Foundation

public extension Blockchain {
    struct Factory {
        public static func coins() -> [Blockchain.Coin] {
            let tokens: [[Blockchain.Coin]] = Blockchain.CoinType.allCases.map { item in
                let coins = item.blockchains.compactMap { blockchain -> Blockchain.Coin? in
                    guard item.blockchains.contains(blockchain) else {
                        return nil
                    }
                    
                    return Blockchain.Coin(coinType: item, blockchain: blockchain)
                }
                
                return coins
            }
            
            return Array(tokens.joined())
        }
        
        public static func tokens() -> [Blockchain.Token] {
            let tokens: [[Blockchain.Token]] = Blockchain.Token.Stablecoin.allCases.map { item in
                let tokens = item.blockchains.compactMap { blockchain -> Blockchain.Token? in
                    guard item.blockchains.contains(blockchain) else {
                        return nil
                    }
                    
                    return Token(stablecoin: item, blockchain: blockchain)
                }
                
                return tokens
            }
            
            return Array(tokens.joined())
        }
        
        public static func make() -> [any CurrencyDescription] {
            return coins() + tokens()
        }
    }
}
