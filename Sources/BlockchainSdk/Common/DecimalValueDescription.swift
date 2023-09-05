//
//  DecimalValueDescription.swift
//  
//
//  Created by skibinalexander on 06.09.2023.
//

import Foundation

public protocol DecimalValueDescription {
    var decimalCount:       Int             { get }
}

public extension DecimalValueDescription {
    var decimalValue: Decimal {
        return pow(Decimal(10), decimalCount)
    }
    
    func decimalRate(per value: Decimal) -> Decimal {
        value * Decimal(pow(10.0, -Double(decimalCount)))
    }
}
