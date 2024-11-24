//
//  Category.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    var title = ""
    @Relationship(deleteRule: .cascade, inverse: \Decision.category) var decisions: [Decision]? = []
    
    init(title: String = "", decisions: [Decision]? = nil) {
        self.title = title
        self.decisions = decisions
    }
    
    // Sample Data for Categories
    @MainActor static let sampleCategories: [Category] = [
        Category(title: "Administrative", decisions: Decision.sampleDecisions),
        Category(title: "Technology"),
        Category(title: "Professional Development"),
        Category(title: "Operations"),
        Category(title: "Curriculum Planning")
    ]
}
