//
//  CurrencyDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CurrencyDescription: Identifiable, Codable, Hashable, DecimalValueDescription where ID == String {
    var blockchain:         Blockchain      { get }
    var currencyType:       CurrencyType    { get }
    var decimalCount:       Int             { get }
    
    func resolveAmountType() throws -> AmountType
}
