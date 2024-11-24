//
//  DataModel.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

@MainActor
@Observable
final class DataModel {
    private var context: ModelContext
    
    init(container: ModelContainer) {
        self.context = container.mainContext
    }
    
    func saveDecision(title: String, detail: String, tags: String, confidenceScore: Double, isFavorite: Bool, selectedColor: Color, selectedPriority: Decision.Priority, selectedStatus: Decision.Status, selectedCategory: Category) {
        let newDecision = Decision(title: title, detail: detail, color: selectedColor, priority: selectedPriority, tags: tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}, status: selectedStatus, category: selectedCategory, confidenceScore: Int(confidenceScore), isFavorite: isFavorite)
        context.insert(newDecision)
    }
    func saveCategory(onSave: @escaping (Category) -> Void, title: String) {
        let newCategory = Category(title: title)
        onSave(newCategory)
    }
}
