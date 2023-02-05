//
//  Blockchain+Node.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    public struct RPCNode: Codable {
        
        /// Name of node
        let name: String
        
        /// Url for rpc requests
        let url: String
        
        /// Testnet flag
        let isTestnet: Bool
        
    }
    
}
