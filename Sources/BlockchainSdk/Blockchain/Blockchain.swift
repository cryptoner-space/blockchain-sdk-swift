//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
@available(iOS 13.0, *)
public enum Blockchain: String, Codable, CaseIterable {
    
    /// Bitcoin
    case bitcoin
    
    /// Ethereum
    case ethereum
    
    /// Binance
    case binance
    
    /// Cardano
    case cardano
    
    /// Solana
    case solana
    
    /// Tron
    case tron
    
    /// Toncoin
    case toncoin
    
    /// Ripple
    case ripple
    
    /// Stellar
    case stellar
    
    /// Cosmos
    case cosmos
    
    /// Polkadot
    case polkadot
    
    /// Exception type
    case undefined
    
}

// MARK: - Info Properties

extension Blockchain {
    
    public var decimalCount: Int {
        switch self {
        case .undefined:
            return 0
        case .bitcoin, .binance:
            return 8
        case .ethereum:
            return 18
        case  .tron, .ripple:
            return 7
        case .solana, .toncoin:
            return 9
        default:
            return 0
        }
    }
    
    public var decimalValue: Decimal {
        return pow(Decimal(10), decimalCount)
    }
    
    public func decimalRate(per value: Decimal) -> Decimal {
        value * Decimal(pow(10.0, -Double(decimalCount)))
    }
    
}
