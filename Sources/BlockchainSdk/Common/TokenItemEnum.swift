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
    
    /// BNB Token
    case BNB
    
    /// USD Coin
    case USDC
    
    /// TRON Token
    case TRON
    
    /// Token Wrapped TON Coin
    case TONCOIN
    
    // MARK: - Implementation
    
    public var blockchains: [Blockchain] {
        switch self {
        case .USDT, .BNB, .USDC, .TRON, .TONCOIN:
            return [.ethereum]
        }
    }
    
    public func typeName(blockchain: Blockchain) throws -> TypeName {
        guard let typeName = TypeName(blockchain) else {
            throw Blockchain.TokenItemError.errorTokenTypeName
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
            case .binanceSmartChain:
                self = .BEP20
            case .tron:
                self = .TRC20
            case .toncoin:
                self = .TON
            default:
                return nil
            }
        }
    }
}

