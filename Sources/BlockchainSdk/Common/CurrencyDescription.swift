//
//  CurrencyDescription.swift
//  
//
//  Created by skibinalexander on 03.09.2023.
//

import Foundation

public protocol CurrencyDescription: Identifiable, Codable where ID == String {
    var blockchain: Blockchain      { get }
    var currencyType: CurrencyType  { get }
}
