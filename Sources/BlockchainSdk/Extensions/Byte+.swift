//
//  Byte+.swift
//  
//
//  Created by skibinalexander on 01.09.2023.
//

import Foundation

public typealias Byte = UInt8

extension UInt8 {
    public var description: String {
        return hex
    }
    
    public var hex: String {
        return String(format: "%02X", self)
    }

    func toBits() -> [String] {
        let totalBitsCount = 8

        var bits = [String](repeating: "0", count: totalBitsCount)

        for index in 0..<totalBitsCount {
            let mask: UInt8 = 1 << UInt8(totalBitsCount - 1 - index)
            let currentBit = self & mask

            if currentBit != 0 {
                bits[index] = "1"
            }
        }

        return bits
    }
}

extension UInt16 {
    public var description: String {
        return hexString
    }
    
    public var hexString: String {
        return String(format: "%02X", self)
    }
}
