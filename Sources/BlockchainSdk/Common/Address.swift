//
//  Address.swift
//
//
//  Created by skibinalexander on 08.02.2024.
//

import Foundation

public struct Address: Codable {
    public let value: String
    public let derivationPath: DerivationPath?
    
    public init(value: String, derivationPath: DerivationPath? = nil) {
        self.value = value
        self.derivationPath = derivationPath
    }
}
