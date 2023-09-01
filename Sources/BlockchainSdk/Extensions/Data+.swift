//
//  File.swift
//  
//
//  Created by skibinalexander on 01.09.2023.
//

import Foundation
import CryptoKit
import CommonCrypto

public extension Data {
    var hex: String {
        return self.map { return String(format: "%02X", $0) }.joined()
    }
    
    var description: String {
        return hex
    }
    
    init(hex: String) {
        self = Data()
        reserveCapacity(hex.unicodeScalars.lazy.underestimatedCount)
        
        var buffer: UInt8?
        var skip = hex.hasPrefix("0x") ? 2 : 0
        for char in hex.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48 && char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            append(b)
        }
    }
    
    init(_ byte: Byte) {
        self = Data([byte])
    }

    @available(iOS 13.0, *)
    func getSha256() -> Data {
        let digest = SHA256.hash(data: self)
        return Data(digest)
    }
    
    @available(iOS 13.0, *)
    func getSha512() -> Data {
        let digest = SHA512.hash(data: self)
        return Data(digest)
    }

    @available(iOS 13.0, *)
    func getDoubleSha256() -> Data {
        return getSha256().getSha256()
    }
    
    var toBytes: [Byte] {
        return Array(self)
    }

    func toBits() -> [String] {
        return flatMap { $0.toBits() }
    }
    
    //SO14443A
    func crc16() -> Data {
        var wCRC = Int32(0x6363) // ITU-V.41
        forEach { byte in
            var chBlock = UInt8(byte)
            chBlock ^= UInt8(wCRC & 0x00FF)
            chBlock = chBlock ^ (chBlock << 4)
            let p1 = (wCRC >> 8) ^ (Int32(chBlock) & 0xFF) << 8 & 0xFFFF
            let p2 = ((Int32(chBlock) & 0xFF) << 3) & 0xFFFF
            let p3 = ((Int32(chBlock) & 0xFF) >> 4) & 0xFFFF
            wCRC = p1 ^ p2 ^ p3
        }
        return Data([UInt8(wCRC & 0xFF), UInt8((wCRC & 0xFFFF) >> 8)])
    }
}
