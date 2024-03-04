//
//  BlockchainRegistry.swift
//
//
//  Created by skibinalexander on 04.03.2024.
//

import Foundation

final class BlockchainRegistry {
    static let shared: BlockchainRegistry = .init()
    
    private lazy var data: [Model] = {
        let url = Bundle.module.url(forResource: "registry", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let jsonData = try! decoder.decode([Model].self, from: data)
        return jsonData
    }()
    
    func resolve(for blockchain: Blockchain) throws -> Model {
        guard let model = self.data.first(where: { $0.id == blockchain.id }) else {
            throw Error.blockchainNotFound
        }
        
        return model
    }
}

extension BlockchainRegistry {
    struct Model: Decodable {
        let id: String
        let name: String
        let coinId: Int
        let symbol: String
        let decimals: Int
    }
    
    struct Description: Decodable {
        let name: String
        let coinId: Int
        let symbol: String
        let decimals: Int
    }
}

extension BlockchainRegistry {
    enum Error: Swift.Error {
        case blockchainNotFound
    }
}
