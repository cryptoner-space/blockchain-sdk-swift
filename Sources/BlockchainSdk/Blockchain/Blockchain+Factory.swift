//
//  File.swift
//  
//
//  Created by skibinalexander on 13.08.2023.
//

import Foundation

extension Blockchain {
    public struct Factory {
        public static func coins() -> [Blockchain.Coin] {
            Blockchain.Coin.allCases
        }
        
        public static func tokens() -> [Blockchain.Token] {
            Blockchain.Token.allCases
        }
    }
}
