//
//  Wallet.swift
//  
//
//  Created by skibinalexander on 08.02.2024.
//

import Foundation

// MARK: - Wallet Model

public final class Wallet: Identifiable {
    public let id: String
    public let items: [Item]
    
    // MARK: - Init
    
    public init(id: String, items: [Item]) {
        self.id = id
        self.items = items
    }
}

// MARK: - Wallet Item

public extension Wallet {
    class Item {
        public let address: Address
        public let blockchain: Blockchain
        public let currencies: [Currency]
        
        public var amounts: [Amount] = []
        
        // MARK: - Init
        
        public init(address: Address, blockchain: Blockchain, currencies: [Currency], amounts: [Amount]) {
            self.address = address
            self.blockchain = blockchain
            self.currencies = currencies
            self.amounts = amounts
        }
    }
}
