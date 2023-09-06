//
//  Blockchain+Explore.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    @available(iOS 13.0, *)
    public struct Explore: Codable {
        
        /// Base url for exploer
        public let url: String
        
        /// Testnet flag
        public let isTestnet: Bool
        
        /// Endpoints by UseCase
        public let endpoints: Dictionary<Params, String>
        
        // MARK: - Init
        
        public init(url: String, isTestnet: Bool, endpoints: Dictionary<Params, String>) {
            self.url = url
            self.isTestnet = isTestnet
            self.endpoints = endpoints
        }
    }
    
}

extension Blockchain.Explore {
    public enum Params: Hashable, Codable {
        case address(String)
        case transaction(String)
    }
}
