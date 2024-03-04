//
//  RegistryLinkProvider.swift
//
//
//  Created by skibinalexander on 04.03.2024.
//

import Foundation

struct RegistryEthereumLinkProvider: ExternalLinkProvider {
    
    let wc: WalletCore
    
    // MARK: - ExternalLinkProvider
    
    func url(address: String, contractAddress: String?) -> URL? {
        URL(string: "\(wc.url)/")
    }
    
    func url(transaction id: String) -> URL? {
        URL(string: "\(wc.url)/")
    }
}

extension RegistryEthereumLinkProvider {
    struct WalletCore: Decodable {
        let url: String
        let txPath: String
        let accountPath: String?
        let sampleTx: String?
        let sampleAccount: String?
    }
}
