//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
public enum Blockchain: String, Codable, CaseIterable, Hashable {
    
    // MARK: - Supported
    
    /// Ethereum ✅
    case ethereum
    
    /// Tron ✅
    case tron
    
    /// Toncoin ✅
    case toncoin
    
    /// Arbitrum One ✅
    case arbitrumOne
    
    // MARK: - Unsupported
    
    /// Ethereum Classic ⭕️
    case ethereumClassic
    
    /// Bitcoin ⭕️
    case bitcoin
    
    /// Binance Smart Chain ⭕️
    case binanceSmartChain
    
    /// Cosmos ⭕️
    case cosmos
    
    /// Ripple ⭕️
    case ripple
    
    /// Litecoin ⭕️
    case litecoin
    
    /// Binance ⭕️
    case binance
    
    /// Cardano ⭕️
    case cardano
    
    /// Solana ⭕️
    case solana
    
    /// Stellar ⭕️
    case stellar
    
    /// Polkadot ⭕️
    case polkadot
    
    /// Bitcoin Cash ⭕️
    case bitcoinCash
    
    /// Dogecoin ⭕️
    case dogecoin
    
    /// Arbitrum ⭕️
    case arbitrum

}

// MARK: - Implementation

public extension Blockchain {
    var supported: [Blockchain] {
        [.ethereum, .toncoin, .arbitrumOne, .tron]
    }
    
    var displayName: String {
        self.rawValue.capitalizingFirstLetter()
    }
    
    var tokenTypeName: String? {
        switch self {
        case .ethereum: return Blockchain.TokenType.ERC20.name
        case .tron: return Blockchain.TokenType.TRC20.name
        default:
            return nil
        }
    }
    
    var canHandleTokens: Bool {
        switch self {
        case .ethereum, 
                .binance,
                .solana,
                .tron,
                .arbitrumOne:
            return true
        default:
            return false
        }
    }
    
    var isEvm: Bool {
        switch self {
        case .ethereumClassic, 
                .binanceSmartChain,
                .arbitrumOne:
            return true
        default:
            return false
        }
    }
}

// MARK: - DecimalValueDescription

extension Blockchain: DecimalValueDescription {
    public var decimalCount: Int {
        switch self {
        case .bitcoin, .binance, .bitcoinCash, .litecoin, .dogecoin:
            return 8
        case .ethereum, .ethereumClassic, .binanceSmartChain, .arbitrumOne:
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

// MARK: - Coin Resolve

public extension Blockchain {
    var coin: Blockchain.Coin? {
        Blockchain.Coin.allCases.first(where: { $0.blockchain == self })
    }
}

// MARK: - TokenType

public extension Blockchain {
    enum TokenType: String, Codable {
        case ERC20, BEP20, TRC20
        
        var name: String {
            self.rawValue.uppercased()
        }
    }
}
