//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
@available(iOS 13.0, *)
public enum Blockchain: String, Codable, CaseIterable {
    
    /// Bitcoin
    case bitcoin
    
    /// Litecoin
    case litecoin
    
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
    
    /// Ethereum Classic
    case ethereumClassic
    
    /// Bitcoin Cash
    case bitcoinCash
    
    /// Dogecoin
    case dogecoin

}

// MARK: - Implementation

public extension Blockchain {
    var tokenTypeName: String? {
        switch self {
        case .ethereum: return Blockchain.TokenType.ERC20.name
        case .binance: return Blockchain.TokenType.BEP2.name
        case .tron: return Blockchain.TokenType.TRC20.name
        default:
            return nil
        }
    }
    
    var canHandleTokens: Bool {
        switch self {
        case .ethereum, .binance, .solana, .tron:
            return true
        default:
            return false
        }
    }
    
    func isFeeApproximate(for amountType: AmountType) -> Bool {
        switch self {
        case .stellar, .toncoin:
            return true
        case .tron:
            if case .token = amountType {
                return true
            }
        default:
            break
        }
        
        return false
    }
}

// MARK: - Info Properties

extension Blockchain: DecimalValueDescription {
    public var decimalCount: Int {
        switch self {
        case .bitcoin, .binance, .bitcoinCash, .litecoin, .dogecoin:
            return 8
        case .ethereum, .ethereumClassic:
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

public extension Blockchain {
    enum TokenType: String, Codable {
        case ERC20, BEP20, TRC20, TON, BEP2
        
        var name: String {
            self.rawValue.uppercased()
        }
    }
}
