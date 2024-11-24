//
//  Decision.swift
//  DecisionJournal
//
//  Created by Gerard Gomez on 11/16/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Decision {
    var title = ""
    var detail = ""
    var codableColor: CodableColor? = nil
    var expectedOutcomes = ""
    var expectedShortcomings = ""
    var date = Date()
    var priority = Priority.high
    var tags: [String] = []
    var status = Status.pending
    var category: Category? = nil
    var reminderDate: Date? = nil
    var confidenceScore = 5
    var isSuccessful = false
    var isFavorite = false
    @Relationship var reflections: [Reflection]? = []
    
    init(title: String, detail: String = "", color: Color? = nil, expectedOutcomes: String = "", expectedShortcomings: String = "", decisionDate: Date = Date(), priority: Priority = .high, tags: [String] = [], status: Status = .ongoing, category: Category? = nil, reminderDate: Date? = nil, confidenceScore: Int = 1, isSuccessful: Bool = false, isFavorite: Bool = false, reflections: [Reflection]? = nil) {
        self.title = title
        self.detail = detail
        self.codableColor = CodableColor(color: color ?? .black)
        self.expectedOutcomes = expectedOutcomes
        self.expectedShortcomings = expectedShortcomings
        self.date = decisionDate
        self.priority = priority
        self.tags = tags
        self.status = status
        self.category = category
        self.reminderDate = reminderDate
        self.confidenceScore = confidenceScore
        self.isSuccessful = isSuccessful
        self.isFavorite = isFavorite
        self.reflections = reflections
    }
    
    var color: Color {
        get { codableColor?.toColor ?? .gray }
        set { codableColor = CodableColor(color: newValue)}
    }
    

    enum Status: String, Codable, Identifiable, CaseIterable {
        case pending, ongoing, resolved
        
        var id: Self { self }
    }
    
    // Sample Data
    @MainActor static let sampleDecisions: [Decision] = [
        Decision(
            title: "Implement New Attendance Policy",
            detail: "Revise and implement the new attendance tracking policy for the school year.",
            color: .mint,
            expectedOutcomes: "Improve attendance reporting accuracy and accountability.",
            expectedShortcomings: "Resistance from staff due to additional workload.",
            decisionDate: Date(),
            priority: .high,
            tags: ["policy", "attendance", "staff"],
            status: Decision.Status.ongoing,
            category: nil,
            reminderDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
            confidenceScore: 8,
            isFavorite: true,
            reflections: []
        ),
        Decision(
            title: "Upgrade School Technology Infrastructure",
            detail: "Upgrade all outdated computers and improve network connectivity.",
            color: .yellow,
            expectedOutcomes: "Boost teacher and student productivity.",
            expectedShortcomings: "Budget constraints and potential technical issues.",
            decisionDate: Date(),
            priority: .low,
            tags: ["technology", "infrastructure", "budget"],
            status: Decision.Status.pending,
            category: nil,
            reminderDate: Calendar.current.date(byAdding: .day, value: 30, to: Date()),
            confidenceScore: 7,
            isFavorite: true,
            reflections: []
        ),
        Decision(
            title: "Organize Teacher Training Workshop",
            detail: "Conduct a workshop on differentiated instruction techniques.",
            color: .cyan,
            expectedOutcomes: "Enhance teaching methods and student engagement.",
            expectedShortcomings: "Limited attendance and scheduling conflicts.",
            decisionDate: Date(),
            priority: .medium,
            tags: ["training", "teaching", "workshop"],
            status: Decision.Status.resolved,
            category: nil,
            reminderDate: nil,
            confidenceScore: 9,
            reflections: []
        )
    ]
    
    enum Priority: String, Codable, CaseIterable, Identifiable {
        case low, medium, high
        
        var id: Self { self }
    }
}
