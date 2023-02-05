//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
@available(iOS 13.0, *)
public enum Blockchain: String, Codable, CaseIterable {
    
    /// Multinetwork blockchain
    case multinetwork
    
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
        switch self {
        case .multinetwork, .undefined:
            return ""
        case .bitcoin:
            return "BTC"
        case .ethereum:
            return "ETH"
        case .binance:
            return "BNB"
        case .solana:
            return "SOL"
        case .tron:
            return "TRX"
        case .toncoin:
            return "TON"
        case .ripple:
            return "XRP"
        }
    }
    
    public var decimalCount: Int {
        switch self {
        case .multinetwork, .undefined:
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
    
}
