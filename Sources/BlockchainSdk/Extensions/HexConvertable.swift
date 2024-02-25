//
//  HexConvertable.swift
//  
//
//  Created by skibinalexander on 08.02.2024.
//

import Foundation

// Convert hex data to Integer
public protocol HexConvertible {
    init?(hexData: Data)
}

public extension HexConvertible where Self: FixedWidthInteger {
    init?(hexData: Data) {
        guard let intValue = Self(hexData.hex, radix: 16) else {
            return nil
        }

        self = intValue
    }
}

extension Int: HexConvertible {}
extension UInt64: HexConvertible {}
