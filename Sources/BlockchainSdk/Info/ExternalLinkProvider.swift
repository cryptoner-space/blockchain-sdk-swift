//
//  ExternalLinkProvider.swift
//
//
//  Created by skibinalexander on 04.03.2024.
//

import Foundation

public protocol ExternalLinkProvider {
    func url(address: String, contractAddress: String?) -> URL?
    func url(transaction id: String) -> URL?
}
