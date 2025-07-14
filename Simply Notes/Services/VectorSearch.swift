//
//  VectorSearch.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 14/07/25.
//
import Foundation

class VectorSearch {
    private var embeddings: [Embedding] = []
    
    func index(_ noteID: UUID, _ text: String) {
        let vector = EmbeddingGenerator.generateEmbeddings(text)
        embeddings.append(Embedding(noteID: noteID, vector: vector))
    }
    
    func search(_ text: String, limit: Int = 3) -> [UUID] {
        let queryVector = EmbeddingGenerator.generateEmbeddings(text)
        
        let scored = embeddings.map { embedding in
            let score = EmbeddingGenerator.cosineSimilarity(embedding.vector, queryVector)
            return (id: embedding.noteID, score: score)
        }
        
        return scored.sorted(by: { $0.score > $1.score})
            .prefix(limit)
            .map { $0.id }
    }
    
    func clear() {
        embeddings.removeAll()
    }
}
