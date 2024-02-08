//
//  CoinCurrencyDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CoinCurrencyDescription: CurrencyDescription, CurrencyInfoDescription {
    func resolveCurrency() throws -> Currency
}

extension CoinCurrencyDescription {
    public var amountType: AmountType {
        .coin(self)
    }
}
