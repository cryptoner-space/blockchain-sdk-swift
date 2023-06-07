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
    
    /// Toncoin
    case toncoin
    
    /// Solana
    case solana
    
    /// Tron
    case tron
    
    /// Ripple
    case ripple
    
    /// Binance
    case binance
    
    /// Exception type
    case undefined
    
}

// MARK: - Info Properties

extension Blockchain {
    
    public var displayName: String {
        switch self {
        default:
            var name = "\(self)".capitalizingFirstLetter()
        
            if let index = name.firstIndex(of: "(") {
                name = String(name.prefix(upTo: index))
            }
        
            return name
        }
    }
    
    public var currencySymbol: String {
        (try? Blockchain.Coin(self).rawValue) ?? ""
    }
    
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
        }
    }
    
    public var decimalValue: Decimal {
        return pow(Decimal(10), decimalCount)
    }
    
    public func decimalRate(per value: Decimal) -> Decimal {
        value * Decimal(pow(10.0, -Double(decimalCount)))
    }
    
}
