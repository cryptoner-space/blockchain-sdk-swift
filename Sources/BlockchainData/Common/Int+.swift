//
//  Int+.swift
//  
//
//  Created by skibinalexander on 21.04.2023.
//

import Foundation

extension Int {
    /// return 2 bytes of integer. LittleEndian format
    public var bytes2LE: Data {
        let clamped = UInt16(clamping: self)
        let data = withUnsafeBytes(of: clamped) { Data($0) }
        return data
    }
    
    /// return 4 bytes of integer. LittleEndian format
    public var bytes4LE: Data {
        let clamped = UInt32(clamping: self)
        let data = withUnsafeBytes(of: clamped) { Data($0) }
        return data
    }
    
    /// return 8 bytes of integer. LittleEndian  format
    public var bytes8LE: Data {
        let data = withUnsafeBytes(of: self) { Data($0) }
        return data
    }
}

extension UInt64 {
    init?(data: Data) {
        guard data.count <= 8 else {
            return nil
        }
        
        let temp = NSData(bytes: data.reversed(), length: data.count)
        let rawPointer = UnsafeRawPointer(temp.bytes)
        let pointer = rawPointer.assumingMemoryBound(to: UInt64.self)
        self = pointer.pointee
    }
}
