//
//  DerivationNode.swift
//
//
//  Created by skibinalexander on 08.02.2024.
//

import Foundation

public enum DerivationNode: Equatable, Hashable, Codable {
    case hardened(UInt32)
    case nonHardened(UInt32)
    
    public var pathDescription: String {
        switch self {
        case .hardened(let index):
            return "\(index)\(Constants.hardenedSymbol)"
        case .nonHardened(let index):
            return "\(index)"
        }
    }
    
    public var index: UInt32 {
        switch self {
        case .hardened(let index):
            let hardenedIndex = index + Constants.hardenedOffset
            return hardenedIndex
        case .nonHardened(let index):
            return index
        }
    }
    
    public var isHardened: Bool {
        switch self {
        case .hardened:
            return true
        case .nonHardened:
            return false
        }
    }
    
    public static func fromIndex(_ index: UInt32) -> DerivationNode {
        if index < Constants.hardenedOffset {
            return .nonHardened(index)
        } else {
            return .hardened(index - Constants.hardenedOffset)
        }
    }
}

extension DerivationNode {
    func serialize() -> Data {
        index.bytes4
    }
    
    static func deserialize(from data: Data) -> DerivationNode? {
        guard let intValue = data.toInt() else { return nil }

        let index = UInt32(intValue)

        if index >= Constants.hardenedOffset {
            return .hardened(index - Constants.hardenedOffset)
        }
        
        return .nonHardened(index)
    }
}

extension DerivationNode {
    enum Constants {
        static let hardenedOffset: UInt32 = .init(0x80000000)
        static let hardenedSymbol: String = "'"
        static let alternativeHardenedSymbol: String = "’"
        static let masterKeySymbol: String = "m"
        static let separatorSymbol: Character = "/"
    }

    enum HMACKey: String {
        case secp256k1 = "Bitcoin seed"
        case secp256r1 = "Nist256p1 seed"
        case ed25519 = "ed25519 seed"
    }
}
