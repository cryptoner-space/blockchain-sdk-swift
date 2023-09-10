//

import Foundation

// MARK: - Blockchain

/// Main structure blockchain Sdk
public enum Blockchain: String, Codable, CaseIterable {
    
    /// Bitcoin ✅
    case bitcoin
    
    /// Ethereum ✅
    case ethereum
    
    /// Ethereum Classic ✅
    case ethereumClassic
    
    /// Tron ✅
    case tron
    
    /// Toncoin ✅
    case toncoin
    
    /// Ripple ✅
    case ripple
    
    /// Binance Smart Chain ✅
    case binanceSmartChain
    
    /// Cosmos ✅
    case cosmos
    
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

}

// MARK: - Implementation

public extension Blockchain {
    var tokenTypeName: String? {
        switch self {
        case .ethereum: return Blockchain.TokenType.ERC20.name
        case .binance: return Blockchain.TokenType.BEP2.name
        case .tron: return Blockchain.TokenType.TRC20.name
        case .binanceSmartChain: return Blockchain.TokenType.BEP20.name
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
    
    var isEvm: Bool {
        switch self {
        case .ethereumClassic, .binanceSmartChain:
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

// MARK: -

public extension Blockchain {
    var coin: Blockchain.Coin? {
        switch self {
        case .bitcoin:
            return .BTC
        case .litecoin:
            return .LTC
        case .ethereum:
            return .ETH
        case .binance:
            return .BNB
        case .binanceSmartChain:
            return .BSC
        case .cardano:
            return .ADA
        case .solana:
            return .SOL
        case .tron:
            return .TRX
        case .toncoin:
            return .TON
        case .ripple:
            return .XRP
        case .stellar:
            return .XLM
        case .cosmos:
            return .ATOM
        case .ethereumClassic:
            return .ETC
        case .bitcoinCash:
            return .BCH
        default:
            return nil
        }
    }
}

// MARK: - DecimalValueDescription

extension Blockchain: DecimalValueDescription {
    public var decimalCount: Int {
        switch self {
        case .bitcoin, .binance, .bitcoinCash, .litecoin, .dogecoin:
            return 8
        case .ethereum, .ethereumClassic, .binanceSmartChain:
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

// MARK: - TokenType

public extension Blockchain {
    enum TokenType: String, Codable {
        case ERC20, BEP20, TRC20, TON, BEP2
        
        var name: String {
            self.rawValue.uppercased()
        }
    }
}
