//
//  Embedding.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 14/07/25.
//

import Foundation

struct Embedding: Codable {
    let noteID: UUID
    let vector: [Double]
}
