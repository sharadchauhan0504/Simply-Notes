//
//  VaultViewModel.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 25/07/25.
//

import Foundation
import SwiftUI

@MainActor
class VaultViewModel: ObservableObject {
    @Published var notes: [VaultNote] = []
    @Published var searchedResults : [VaultNote] = []
    
    private let store = LocalVaultStore()
    private let search = VectorSearch()
    private var allNotes: [VaultNote] = []
    
    init() {
        loadNotes()
    }
    
    func loadNotes() {
        notes = store.load()
        allNotes = notes
        search.clear()
        for note in notes {
            search.index(note.id, note.content)
        }
    }
    
    func addNotes(_ title: String, _ content: String) {
        let note = VaultNote(id: .init(), title: title, content: content, createdAt: .init())
        allNotes.insert(note, at: 0)
        store.save(allNotes)
        loadNotes()
    }
    
    func runSemanticSearch(_ query: String) {
        let resultIDs = search.search(query)
        searchedResults = allNotes.filter { resultIDs.contains($0.id) }
    }
}
