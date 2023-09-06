//
//  BlockchainError.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

public extension Blockchain {
    enum TokenItemError: Error, LocalizedError {
        case errorTokenTypeName
    }
}
