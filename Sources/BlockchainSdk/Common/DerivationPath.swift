//
//  DerivationPath.swift
//
//
//  Created by skibinalexander on 08.02.2024.
//

import Foundation

fileprivate typealias Constants = DerivationNode.Constants

/// BIP32 derivation Path
public struct DerivationPath: Equatable, Hashable, Codable {
    public let rawPath: String
    public let nodes: [DerivationNode]
    
    /// Init with master node
    public init() {
        self.init(nodes: [])
    }
    
    /// Parse derivation path.
    /// - Parameter rawPath: Path. E.g. "m/0'/0/1/0"
    public init(rawPath: String) throws {
        let splittedPath = rawPath.lowercased().split(separator: DerivationNode.Constants.separatorSymbol)
        
        guard splittedPath.count >= 2 else {
            throw Error.wrongPath
        }
        
        guard splittedPath[0].trim() == Constants.masterKeySymbol else {
            throw Error.wrongPath
        }
        
        var derivationPath: [DerivationNode] = []
        
        for pathItem in splittedPath.suffix(from: 1) {
            let isHardened = pathItem.contains(Constants.hardenedSymbol) || pathItem.contains(Constants.alternativeHardenedSymbol)
            let cleanedPathItem = pathItem.trim().remove(Constants.hardenedSymbol).remove(Constants.alternativeHardenedSymbol)
            guard let index = UInt32(cleanedPathItem) else {
                throw Error.wrongPath
            }
            
            let node = isHardened ? DerivationNode.hardened(index) : DerivationNode.nonHardened(index)
            derivationPath.append(node)
        }
        
        self.init(nodes: derivationPath)
    }
    
    /// Init with nodes
    public init(nodes: [DerivationNode]) {
        var path = "\(Constants.masterKeySymbol)"
       
        let nodesPath = nodes.map { $0.pathDescription }.joined(separator: String(Constants.separatorSymbol))
        if !nodesPath.isEmpty {
            path += "\(Constants.separatorSymbol)\(nodesPath)"
        }
        
        self.init(rawPath: path, nodes: nodes)
    }
    
    private init(rawPath: String, nodes: [DerivationNode]) {
        self.rawPath = rawPath
        self.nodes = nodes
    }
    
    public func extendedPath(with node: DerivationNode) -> DerivationPath {
        DerivationPath(nodes: self.nodes + [node])
    }
}


extension DerivationPath {
    enum Error: Swift.Error, LocalizedError {
        case wrongPath
    }
}
