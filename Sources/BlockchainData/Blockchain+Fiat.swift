//
//  Blockchain+Fiat.swift
//  
//
//  Created by skibinalexander on 22.04.2023.
//

import Foundation

extension Blockchain {
    
    public struct Fiat: Codable {
        public let name: String
        public let symbol: String
        public let sign: String
        public let externalId: String?
        
        public init(
            name: String,
            symbol: String,
            sign: String,
            externalId: String?
        ) {
            self.name = name
            self.symbol = symbol
            self.sign = sign
            self.externalId = externalId
        }
        
        public func amount(value: Decimal) throws -> Amount {
            return .init(type: .fiat(3, symbol, sign), value: value)
        }
    }
    
}
