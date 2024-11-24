//
//  AddCategorySheet.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/19/24.
//

import SwiftUI

struct AddCategorySheet: View {
    @Environment(DataModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    let onSave: (Category) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Category Name") {
                    TextField("Enter category name", text: $title)
                }
            }
            .navigationTitle("Add Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        model.saveCategory(onSave: onSave, title: title)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    AddCategorySheet(onSave:  { category in })
}
