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
        public let endpoints: Dictionary<UseCase, String>
        
        // MARK: - Implementation
        
        public func makeUrl() throws -> URL { throw Blockchain.ExploreError.errorMakeUrl }
        
        // MARK: - Init
        
        public init(url: String, isTestnet: Bool, endpoints: Dictionary<UseCase, String>) {
            self.url = url
            self.isTestnet = isTestnet
            self.endpoints = endpoints
        }
    }
    
}

extension Blockchain.Explore {
    public enum UseCase: Hashable, Codable {
        case address(String)
        case transaction(String)
    }
}
