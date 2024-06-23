//
//  AmountType.swift
//  
//
//  Created by skibinalexander on 23.06.2024.
//

import Foundation

// MARK: - AmountType

public enum AmountType {
    case coin(_ description: any CoinCurrencyDescription)
    case token(_ description: any TokenCurrencyDescription, _ blockchain: Blockchain)
    case custom(_id: String, _ decimals: Int, _ symbol: String, _ sign: String?)
}

extension AmountType: Equatable, Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .coin(let value):
            hasher.combine("coin")
            hasher.combine(value.id.hashValue)
            hasher.combine(value.blockchain)
        case .token(let value, _):
            hasher.combine("token")
            hasher.combine(value.id.hashValue)
            hasher.combine(value.blockchain)
        case .custom(let id, _, let symbol, _):
            hasher.combine("custom")
            hasher.combine(id)
            hasher.combine(symbol.hashValue)
        }
    }
    
    public static func == (lhs: AmountType, rhs: AmountType) -> Bool {
        switch (lhs, rhs) {
        case (.coin(let lv), .coin(let rv)):
            return lv.id == rv.id
        case (.token(let lv, _), .token(let rv, _)):
            return lv.id == rv.id
        default:
            return false
        }
    }
}
