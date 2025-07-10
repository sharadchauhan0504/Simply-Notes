//
//  ContentView.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 03/07/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    private let store = LocalVaultStore()
    @State var notes = [VaultNote]()
    
    var body: some View {
        VStack {
            Button("Save note") {
                let note = VaultNote(id: .init(), title: "Test", content: "Encrypted content", createdAt: .init())
                store.save([note])
            }
            
            Button("Load note") {
                notes = store.load()
            }
            
            List(notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                    Text(note.content)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
