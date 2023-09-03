//
//  TokenCurrencyDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol TokenCurrencyDescription: CurrencyDescription, CurrencyInfoDescription {
    var contractAddress: String { get }
}

extension TokenCurrencyDescription {
    public var amountType: AmountType {
        .token(self, blockchain)
    }
}
