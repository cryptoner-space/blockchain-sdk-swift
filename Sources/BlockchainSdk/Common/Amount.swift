//
//  Blockchain+Amount.swift
//
//
//  Created by skibinalexander on 21.04.2023.
//

import Foundation
import BigInt


public struct Amount: CustomStringConvertible, Equatable, Comparable, Hashable {
    
    // MARK: - Public Properties
    
    /// Crypto type currency
    public let type: AmountType
    
    /// Currency symbol
    public let currencySymbol: String
    
    /// Currency sign
    public let currencySign: String?
    
    /// Value of amount
    public var value: Decimal
    
    ///
    public let decimals: Int
    
    // MARK: - Public Helpers
    
    public var isZero: Bool {
        return value == 0
    }
    
    public var description: String {
        return string()
    }
    
    public var int64Value: Int64 {
        return NSDecimalNumber(decimal: self.value).int64Value
    }
    
    public var doubleValue: Double {
        return NSDecimalNumber(decimal: self.value).doubleValue
    }
    
    public var bigUIntValue: BigUInt? {
        if isZero {
            return BigUInt.zero
        }
        
        if value == Decimal.greatestFiniteMagnitude {
            return BigUInt(2).power(256) - 1
        }

        return BigUInt.parseToBigUInt("\(value)", decimals: decimals)
    }
    
    // MARK: - Init
    
    public init(type: AmountType, value: Decimal) {
        self.type = type
        self.value = value
        
        switch type {
        case .coin(let value):
            self.currencySymbol = value.rawValue
            self.currencySign = nil
            self.decimals = value.blockchain.decimalCount
        case .token(let value, let blockchain):
            self.currencySymbol = value.rawValue
            self.currencySign = nil
            self.decimals = blockchain.decimalCount
        case .fiat(let decimals, let symbol, let sign):
            self.currencySymbol = symbol
            self.currencySign = sign
            self.decimals = decimals
        case .custom(let decimals, let symbol, let sign):
            self.currencySymbol = symbol
            self.currencySign = sign
            self.decimals = decimals
        }
    }
    
    public init(_ amount: Amount, value: Decimal) {
        self.type = amount.type
        self.currencySymbol = amount.currencySymbol
        self.currencySign = amount.currencySign
        self.decimals = amount.decimals
        self.value = value
    }
    
    public init?(currency: Currency, value: Decimal) {
        guard let amountType = AmountType(currency) else {
            return nil
        }
        
        self.init(type: amountType, value: value)
    }
    
    // MARK: - Description & Printing
    
    public func string(
        with decimals: Int? = nil,
        roundingMode: NSDecimalNumber.RoundingMode = .down
    ) -> String {
        let decimalsCount = decimals ?? self.decimals
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencySymbol = currencySymbol
        formatter.alwaysShowsDecimalSeparator = true
        formatter.maximumFractionDigits = decimalsCount
        formatter.minimumFractionDigits = 2
        let rounded = value.rounded(scale: decimalsCount, roundingMode: roundingMode)
        return formatter.string(from: rounded as NSDecimalNumber) ??
            "\(rounded) \(currencySymbol)"
    }
    
    public static func ==(lhs: Amount, rhs: Amount) -> Bool {
        if lhs.type != rhs.type {
            return false
        }
        
        return lhs.value == rhs.value
    }
    
    static public func -(l: Amount, r: Amount) -> Amount {
        if l.type != r.type {
            return l
        }
        return Amount(l, value: l.value - r.value)
    }
    
    static public func +(l: Amount, r: Amount) -> Amount {
        if l.type != r.type {
            return l
        }
        return Amount(l, value: l.value + r.value)
    }
    
    public static func < (lhs: Amount, rhs: Amount) -> Bool {
        if lhs.type != rhs.type {
            fatalError("Compared amounts must be the same type")
        }
        
        return lhs.value < rhs.value
    }
    
}

public enum AmountType {
    case coin(_ type: Blockchain.Coin)
    case token(_ type: Blockchain.Token, _ blockchain: Blockchain)
    case fiat(_ decimals: Int, _ symbol: String, _ sign: String?)
    case custom(_ decimals: Int, _ symbol: String, _ sign: String?)
    
    public init?(_ currency: Currency) {
        switch currency.currencyType {
        case .coin:
            guard let coin = currency.coin else {
                return nil
            }
            
            self = .coin(coin)
        case .token:
            guard let token = currency.token else {
                return nil
            }
            
            self = .token(token, currency.blockchain)
        case .custom:
            return nil
        }
    }
}

extension AmountType: Equatable, Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .coin(let blockchain):
            hasher.combine(blockchain.hashValue)
        case .token(let value, _):
            hasher.combine(value.hashValue)
        case .fiat(_, let symbol, _):
            hasher.combine(symbol.hashValue)
        case .custom(_, let symbol, _):
            hasher.combine(symbol.hashValue)
        }
    }
    
    public static func == (lhs: AmountType, rhs: AmountType) -> Bool {
        switch (lhs, rhs) {
        case (.coin(let lv), .coin(let rv)):
            return lv.rawValue == rv.rawValue
        case (.token(let lv, _), .token(let rv, _)):
            return lv.rawValue == rv.rawValue
        default:
            return false
        }
    }
}

public extension Amount {
    static func dummyCoin(coin: Blockchain.Coin) -> Amount {
        .init(type: .coin(coin), value: 0)
    }
    
    static func zeroCoin(coin: Blockchain.Coin) -> Amount {
        .init(type: .coin(coin), value: 0)
    }
    
    static func maxCoin(coin: Blockchain.Coin) -> Amount {
        .init(type: .coin(coin), value: Decimal.greatestFiniteMagnitude)
    }
}

public extension Optional where Wrapped == Amount {
    var zeroOrNil: Bool {
        self?.isZero ?? true
    }
}
