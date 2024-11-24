//
//  AddDecisionView.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/17/24.
//

import SwiftData
import SwiftUI

struct AddDecisionView: View {
    @Environment(DataModel.self) private var model
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var detail = ""
    @State private var selectedColor: Color = .gray
    @State private var expectedOutcomes: String = ""
    @State private var expectedShortcomings: String = ""
    @State private var selectedPriority: Decision.Priority = .medium
    @State private var tags: String = ""
    @State private var selectedStatus: Decision.Status = .pending
    @State private var selectedCategory: Category?
    @State private var reminderDate: Date?
    @State private var confidenceScore: Int = 5
    @State private var isFavorite: Bool = false
    
    @State private var isPresentingAddCategory = false
    private var addNewCategoryPlaceholder = Category(title: "Add New Category")
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Title", text: $title)
                    TextField("Detail", text: $detail, axis: .vertical)
                    #if !os(watchOS)
                    ColorPicker("Select Color", selection: $selectedColor)
                    #endif
                }
                Section("Expectations") {
                    TextField("Expected Outcomes", text: $expectedOutcomes, axis: .vertical)
                    TextField("Expected Shortcomings", text: $expectedShortcomings, axis: .vertical)
                }
                Section("Additional Details") {
                    Text("Priority")
                    Picker("Priority", selection: $selectedPriority) {
                        ForEach(Decision.Priority.allCases) { priority in
                            Text(priority.rawValue.capitalized)
                                .tag(priority)
                        }
                    }
                    #if !os(watchOS)
                    .pickerStyle(.segmented)
                    #endif
                    TextField("Tags (comma separated", text: $tags, axis: .vertical)
                    Text("Decision Status")
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(Decision.Status.allCases) { status in
                            Text(status.rawValue.capitalized)
                                .tag(status)
                        }
                    }
                    #if !os(watchOS)
                    .pickerStyle(.segmented)
                    #endif
                    Picker("Category", selection: $selectedCategory) {
                        Text("None").tag(Category?.none)
                        ForEach(categories + [addNewCategoryPlaceholder]) { category in
                            Text(category.title)
                                .tag(category as Category?)
                        }
                    }
                    .onChange(of: selectedCategory) { _, newValue in
                        if newValue?.id == addNewCategoryPlaceholder.id {
                            selectedCategory = nil
                            isPresentingAddCategory = true
                        }
                    }
                    DatePicker("Reminder Date", selection: $reminderDate.withDeafultValue(), displayedComponents: .date)
                     
                    Stepper("Confidence Score: \(confidenceScore)", value: $confidenceScore, in: 1...10)
                    Toggle("Favorite", isOn: $isFavorite)
   
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Add Decision")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: dismiss.callAsFunction)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        model.saveDecision(title: title, detail: detail, tags: tags, confidenceScore: Double(confidenceScore), isFavorite: isFavorite, selectedColor: selectedColor, selectedPriority: selectedPriority, selectedStatus: selectedStatus, selectedCategory: selectedCategory ?? Category())
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .sheet(isPresented: $isPresentingAddCategory) {
                AddCategorySheet { newCategory in
                    context.insert(newCategory)
                    selectedCategory = newCategory
                }
            }
        }
    }
}

#Preview(traits: .previewData) {
    AddDecisionView()
}


