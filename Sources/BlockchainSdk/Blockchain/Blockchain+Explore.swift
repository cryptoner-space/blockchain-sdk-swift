//
//  Blockchain+Explore.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

public extension Blockchain {
    struct Explore: Codable {
        /// Base url for exploer
        public let url: String
        
        /// Params of path transaction
        public let params: [Params]
        
        // MARK: - Init
        
        init(url: String, params: [Params]) {
            self.url = url
            self.params = params
        }
    }
}

extension Blockchain.Explore {
    public enum Params: Hashable, Codable {
        case address(String)
        case transaction(String)
    }
}
