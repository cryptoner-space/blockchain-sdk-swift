//
//  CurrencyInfoDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CurrencyInfoDescription: Codable {
    var currencySymbol:     String      { get }
    var currencySign:       String?     { get }
    var displayName:        String      { get }
}
