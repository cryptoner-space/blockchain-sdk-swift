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
    
}
