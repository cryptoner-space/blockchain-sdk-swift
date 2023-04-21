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
        
        /// Stablecoin Thether
        case USDT
        
        /// Stablecoin USD Coin
        case USDC
        
    }

    
}
