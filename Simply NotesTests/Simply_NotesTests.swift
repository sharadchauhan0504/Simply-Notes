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
        let results1 = vectorSearch.search("banking payment icici")
        print("results1: \(results1)")
        assert(!results1.isEmpty)
        
        let results2 = vectorSearch.search("apple banana")
        print("results2: \(results2)")
        assert(results2.isEmpty)
    }

}
