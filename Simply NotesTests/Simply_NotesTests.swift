//
//  Simply_NotesTests.swift
//  Simply NotesTests
//
//  Created by Sharad Chauhan on 03/07/25.
//

import Testing
@testable import Simply_Notes
import Foundation

struct Simply_NotesTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        let store = LocalVaultStore()
        let vectorSearch = VectorSearch()

        // Add sample note
        let note = VaultNote(id: UUID(), title: "Pay ICICI bill", content: "Paid ₹5300 using net banking", createdAt: Date())
        store.save([note])
        vectorSearch.index(note.id, note.content)

        // Query search
        let results = vectorSearch.search("banking payment icici")
        print("results: \(results)")
        assert(!results.isEmpty)
    }

}
