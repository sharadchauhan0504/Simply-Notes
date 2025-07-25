//
//  VaultView.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 25/07/25.
//

import SwiftUI

struct VaultView: View {
    @StateObject var viewModel = VaultViewModel()
    @State var query = ""
    @State var showingAddNote = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // search bar
                HStack {
                    TextField("Search", text: $query)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        viewModel.runSemanticSearch(query)
                    } label: {
                        Text("Go")
                    }
                }
                .padding()
                
                if query.isEmpty {
                    List(viewModel.notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title).bold()
                            Text(note.content).foregroundStyle(.secondary)
                        }
                    }
                } else {
                    List(viewModel.searchedResults) { note in
                        VStack(alignment: .leading) {
                            Text(note.title).bold()
                            Text(note.content).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Private vault")
            .toolbar {
                Button(action: { showingAddNote = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    VaultView()
}
