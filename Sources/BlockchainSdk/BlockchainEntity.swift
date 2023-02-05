//
//  BlockchainEntity.swift
//  
//
//  Created by skibinalexander on 05.02.2023.
//

import Foundation

protocol BlockchainEntity: Codable {
    
    /// Token / Coin Enum structure
    var id: String { get set }
    
    /// Type of entity blockchain
    var type: BlockchainEntityType { get set }
    
    /// Parent network blockchain
    var blockchain: Blockchain { get set }
    
    /// Link for Icon token
    var iconUrl: String? { get set }
    
    /// Symbol of name token
    var symbol: String { get set }
    
    /// Name of token
    var name: String { get set }
    
    /// Description of token
    var description: String? { get set }
    
    /// Rank of global community
    var rank: Int { get set }
    
    /// External id of db or any usage
    var externalId: String? { get set }
    
}
