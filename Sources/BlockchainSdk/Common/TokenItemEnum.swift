//
//  BlokchainTokenList.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public enum TokenItem: String, Codable, CaseIterable {
    
    /// Stablecoin Thether
    case USDT
    
    // MARK: - Implementation
    
    public var blockchains: [Blockchain] {
        switch self {
        case .USDT:
            return [.ethereum]
        }
    }
    
    public func typeName(blockchain: Blockchain) throws -> TypeName {
        guard let typeName = TypeName(blockchain) else {
            throw Blockchain.EntityError.errorExecution
        }
        
        return typeName
    }
}

extension TokenItem {
    public enum TypeName: String, Codable {
        case ERC20, BEP20, TRC20, TON, BEP2
        
        public init?(_ blockchain: Blockchain) {
            switch blockchain {
            case .ethereum:
                self = .ERC20
            case .binance:
                self = .BEP2
            case .tron:
                self = .TRC20
            default:
                return nil
            }
        }
    }
}

