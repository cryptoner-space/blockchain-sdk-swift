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
        let token: Token
        
        /// Link for Icon token
        let iconUrl: String?
        
        /// Symbol of name token
        let symbol: String
        
        /// Name of token
        let name: String
        
        /// Description of token
        let description: String?
        
        /// Rank of global community
        let rank: Int
        
    }

    
}
