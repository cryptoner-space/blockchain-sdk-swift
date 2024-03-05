//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
public enum Blockchain: String, Codable, CaseIterable, Hashable, Identifiable {
    
    // MARK: - Supported
    
    /// Ethereum ✅
    case ethereum
    
    /// Tron ✅
    case tron
    
    /// Toncoin ✅
    case toncoin
    
    /// Arbitrum One ✅
    case arbitrumOne = "arbitrumOne"
    
    // MARK: - Unsupported
    
    /// Ethereum Classic ⭕️
    case ethereumClassic = "classic"
    
    /// Bitcoin ⭕️
    case bitcoin
    
    /// Binance Smart Chain ⭕️
    case binanceSmartChain = "bsc"
    
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
    case bitcoinCash = "bitcoincash"
    
    /// Dogecoin ⭕️
    case dogecoin
    
    /// Arbitrum ⭕️
    case arbitrum
    
    // MARK: - Identifiable
    
    public var id: String {
        self.rawValue
    }
    
    var registry: BlockchainRegistry {
        .shared
    }

}

// MARK: - Implementation

public extension Blockchain {
    var supported: [Blockchain] {
        [.ethereum, .toncoin, .arbitrumOne, .tron]
    }
    
    var displayName: String {
        switch self {
        case .arbitrumOne:
            return rawValue.capitalizingFirstLetter()
        default:
            return (try? registry.resolve(for: self).name) ?? ""
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
        case .arbitrumOne:
            return (try? registry.resolve(for: .arbitrum).decimals) ?? 0
        default:
            return (try? registry.resolve(for: self).decimals) ?? 0
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
    func resolveCoin(by coinType: Blockchain.CoinType) -> Blockchain.Coin? {
        .init(coinType: coinType, blockchain: self)
    }
}

// MARK: - Tokens

public extension Blockchain {
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
    
    enum TokenType: String, Codable {
        case ERC20, BEP20, TRC20
        
        var name: String {
            self.rawValue.uppercased()
        }
    }
}
