//
//  Blockchain+Token.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

extension Blockchain {
    
    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public enum Token: String, Codable, CaseIterable {
        case none
    }

    /// Main structure blockchain Sdk
    @available(iOS 13.0, *)
    public struct TokenUnion {
        
        /// Token Enum structure
        public let token: Token
        
        /// Link for Icon token
        public let iconUrl: String?
        
        /// Symbol of name token
        public let symbol: String
        
        /// Name of token
        public let name: String
        
        /// Description of token
        public let description: String?
        
        /// Rank of global community
        public let rank: Int
        
        // MARK: - Init
        
        public init(token: Token, iconUrl: String?, symbol: String, name: String, description: String?, rank: Int) {
            self.token = token
            self.iconUrl = iconUrl
            self.symbol = symbol
            self.name = name
            self.description = description
            self.rank = rank
        }
        
    }

    
}
