//
//  AddNoteView.swift
//  Simply Notes
//
//  Created by Sharad Chauhan on 25/07/25.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: VaultViewModel
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New note")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        viewModel.addNotes(title, content)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddNoteView(viewModel: VaultViewModel())
}
