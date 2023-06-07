//
//  EllipticCurve.swift
//  
//
//  Created by skibinalexander on 21.01.2023.
//

import Foundation

/// Elliptic curve used for wallet key operations.
@available(iOS 13.0, *)
public enum EllipticCurve: String, CaseIterable {
    case secp256k1
    case ed25519
    case secp256r1
    case bls12381_G2
    case bls12381_G2_AUG
    case bls12381_G2_POP
}
