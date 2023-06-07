//
//  Blockchain+Node.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    @available(iOS 13.0, *)
    public struct RPCNode: Codable {
        
        /// Name of node
        public let name: String
        
        /// Url for rpc requests
        public let url: String
        
        /// Testnet flag
        public let isTestnet: Bool
        
        // MARK: - Init
        
        public init(name: String, url: String, isTestnet: Bool) {
            self.name = name
            self.url = url
            self.isTestnet = isTestnet
        }
        
    }
    
}
