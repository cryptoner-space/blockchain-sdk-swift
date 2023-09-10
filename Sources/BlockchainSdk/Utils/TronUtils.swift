//
//  TronUtils.swift
//  
//
//  Created by skibinalexander on 08.09.2023.
//

import Foundation

public struct TronUtils {
    private let prefix: UInt8 = 0x41
    private let addressLength = 21
    
    var doubleSha256: (([UInt8]) -> Data)
    
    /// Use multiplatform sha256 calculate data
    /// - Parameter doubleSha256: Inout closure
    public init(doubleSha256: @escaping (([UInt8]) -> Data)) {
        self.doubleSha256 = doubleSha256
    }
    
    func base58CheckDecodedBytes(_ value: String) -> [UInt8]? {
        let bytes = Base58.bytesFromBase58(value)

        guard bytes.count >= 4 else { return nil }

        let checksum = Array(bytes.suffix(4))
        let bytesWithoutCheck = Array(bytes.dropLast(4))
        let calculatedChecksum = Array(doubleSha256(bytesWithoutCheck).prefix(4))

        if checksum != calculatedChecksum { return nil }

        return bytesWithoutCheck
    }
    
    public func toByteForm(_ base58String: String) -> Data? {
        guard let bytes = base58CheckDecodedBytes(base58String) else {
            return nil
        }
        
        return Data(bytes)
    }
    
    public func toHexForm(_ base58String: String, length: Int?) -> String? {
        guard let data = toByteForm(base58String) else {
            return nil
        }
        
        let hex = data.hex
        if let length = length {
            return String(repeating: "0", count: length - hex.count) + hex
        } else {
            return hex
        }
    }
}
