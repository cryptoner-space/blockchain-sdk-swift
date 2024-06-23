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
    
    /// Value of amount
    public var value: Decimal
    
    /// Decimal count for Formatter value
    public let decimals: Int
    
    // MARK: - Public Helpers
    
    public var description: String {
        return string()
    }
    
    public var formattedValue: String {
        NSDecimalNumber(decimal: value).stringValue
    }
    
    // MARK: - Init
    
    public init(type: AmountType, value: Decimal) {
        self.type = type
        self.value = value
        
        switch type {
        case .coin(let value):
            self.decimals = value.blockchain.decimalCount
        case .token(_, let blockchain):
            self.decimals = blockchain.decimalCount
        case .custom(_, let decimals, _, _):
            self.decimals = decimals
        }
    }
    
    public init(_ amount: Amount, value: Decimal) {
        self.type = amount.type
        self.decimals = amount.decimals
        self.value = value
    }
    
    public init?(coin: any CoinCurrencyDescription, value: Decimal) {
        self.init(type: coin.amountType, value: value)
    }
    
    public init?(token: any TokenCurrencyDescription, value: Decimal) {
        self.init(type: token.amountType, value: value)
    }
    
    // MARK: - Description & Printing
    
    public func string(with decimals: Int? = nil, roundingMode: NSDecimalNumber.RoundingMode = .down) -> String {
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
    
    public func string(_ formatter: NumberFormatter, roundingMode: NSDecimalNumber.RoundingMode = .down) -> String {
        let rounded = value.rounded(scale: decimals, roundingMode: roundingMode)
        return formatter.string(from: rounded as NSDecimalNumber) ?? "\(rounded) \(currencySymbol)"
    }
}

// MARK: - Computed

public extension Amount {
    /// Currency symbol
    var currencySymbol: String {
        switch type {
        case .coin(let description):
            return description.currencySymbol
        case .token(let token, _):
            return token.currencySymbol
        case .custom(_, _, let symbol, _):
            return symbol
        }
    }
    
    /// Currency sign
    var currencySign: String? {
        switch type {
        case .coin(let description):
            return description.currencySign
        case .token(let token, _):
            return token.currencySign
        case .custom(_, _, _, let currencySign):
            return currencySign
        }
    }
}

// MARK: - Values

public extension Amount {
    var isZero: Bool {
        return value == 0
    }
    
    var int64Value: Int64 {
        return NSDecimalNumber(decimal: self.value).int64Value
    }
    
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self.value).doubleValue
    }
}

// MARK: - Comparable

public extension Amount {
    static func ==(lhs: Amount, rhs: Amount) -> Bool {
        if lhs.type != rhs.type {
            return false
        }
        
        return lhs.value == rhs.value
    }
    
    static func -(l: Amount, r: Amount) -> Amount {
        if l.type != r.type {
            return l
        }
        return Amount(l, value: l.value - r.value)
    }
    
    static func +(l: Amount, r: Amount) -> Amount {
        if l.type != r.type {
            return l
        }
        return Amount(l, value: l.value + r.value)
    }
    
    static func < (lhs: Amount, rhs: Amount) -> Bool {
        if lhs.type != rhs.type {
            fatalError("Compared amounts must be the same type")
        }
        
        return lhs.value < rhs.value
    }
}

// MARK: - Supported Encoding

public extension Amount {
    var bigUIntValue: BigUInt? {
        if isZero {
            return BigUInt.zero
        }
        
        if value == Decimal.greatestFiniteMagnitude {
            return BigUInt(2).power(256) - 1
        }

        return BigUInt.parseToBigUInt("\(value)", decimals: decimals)
    }
    
    var encoded: Data? {
        guard let bigUIntValue = bigUIntValue else {
            return nil
        }
        
        let amountData = bigUIntValue.serialize()
        return amountData
    }
    
    var encodedForSend: String? {
        if isZero {
            return "0x0"
        }
        
        return encoded?.hex.stripLeadingZeroes().addHexPrefix()
    }
}

public extension Amount {
    static func dummyCoin(coin: any CoinCurrencyDescription) -> Amount {
        .init(type: .coin(coin), value: 0)
    }
    
    static func zeroCoin(coin: any CoinCurrencyDescription) -> Amount {
        .init(type: .coin(coin), value: 0)
    }
    
    static func maxCoin(coin: any CoinCurrencyDescription) -> Amount {
        .init(type: .coin(coin), value: Decimal.greatestFiniteMagnitude)
    }
}

public extension Optional where Wrapped == Amount {
    var zeroOrNil: Bool {
        self?.isZero ?? true
    }
}
