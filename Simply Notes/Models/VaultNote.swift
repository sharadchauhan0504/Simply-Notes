//
//  VaultNote.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 04/07/25.
//

import Foundation

struct VaultNote: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var createdAt: Date
}

