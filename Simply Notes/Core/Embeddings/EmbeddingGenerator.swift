//
//  EmbeddingGenerator.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 14/07/25.
//
import Foundation
import NaturalLanguage

class EmbeddingGenerator {
    static let dimension = 128
    
    static func generateEmbeddings(_ text: String) -> [Double] {
        var vector = Array(repeating: 0.0, count: dimension)
        let tokens = text.lowercased().split(separator: " ")
        
        for token in tokens {
            let hash = abs(token.hashValue) % dimension
            vector[hash] += 1.0
        }
        
        let norm = sqrt(vector.reduce(0) { $0 + $1 * $1 })
        return vector.map { $0 / norm }
    }
    
    static func cosineSimilarity(_ v1: [Double], _ v2: [Double]) -> Double {
        zip(v1, v2).map(*).reduce(0, +)
    }
}
