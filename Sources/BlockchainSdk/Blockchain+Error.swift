//
//  BlockchainError.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

extension Blockchain {
    
    public enum ExploreError: Error {
        case errorMakeUrl
    }
    
    public enum EntityError: Error {
        case errorExecution
        case errorMaking
    }
    
}
